#!/bin/sh
set -eu

ROOT=${1:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
CASES="$ROOT/evals/cases.tsv"

expected='bulletproof
campaign
demolition
disrespec
dissect
fork-me
promote
remember
revolver
sus-audit
sus-change-plan
sus-inventory
sus-research
sus-review
sus-spec
sus-task
triple-check'

test -f "$CASES" || { echo "evaluation cases missing" >&2; exit 1; }

awk -F '	' '
  NR == 1 {
    expected = "id\tskill\tclass\tprompt\tfacts\texpected_activation\texpected_artifact\texpected_question\tinvariant\tforbidden\tscoring_evidence"
    if ($0 != expected) exit 1
    next
  }
  NF != 11 { exit 1 }
  $1 !~ /^[a-z0-9-]+$/ { exit 1 }
  $2 !~ /^[a-z0-9-]+$/ { exit 1 }
  $3 !~ /^(direct|implicit|near-miss|isolated|composition|regression)$/ { exit 1 }
  $6 !~ /^(yes|no)$/ { exit 1 }
  $7 !~ /^(none|spec|task|review|inventory|change-plan|audit|research)$/ { exit 1 }
  $8 !~ /^(none|selection|selection-after-action)$/ { exit 1 }
  {
    for (i = 1; i <= 11; i++) if ($i == "") exit 1
    if (seen[$1]++) exit 1
    if ($6 == "no" && ($7 != "none" || $8 != "none")) exit 1
  }
' "$CASES" || { echo "invalid evaluation case shape" >&2; exit 1; }

for skill in $expected; do
  test -f "$ROOT/skills/$skill/SKILL.md" || {
    echo "evaluation names unknown skill: $skill" >&2
    exit 1
  }
  for class in direct implicit near-miss isolated; do
    count=$(awk -F '	' -v skill="$skill" -v class="$class" '
      NR > 1 && $2 == skill && $3 == class { count += 1 }
      END { print count + 0 }
    ' "$CASES")
    test "$count" = 1 || {
      echo "evaluation coverage drift: $skill $class ($count)" >&2
      exit 1
    }
  done
done

actual=$(awk -F '	' 'NR > 1 { print $2 }' "$CASES" | sort -u)
test "$actual" = "$expected" || {
  echo "evaluation catalog drift" >&2
  exit 1
}

awk -F '	' '
  BEGIN {
    artifact["sus-audit"] = "audit"
    artifact["sus-change-plan"] = "change-plan"
    artifact["sus-inventory"] = "inventory"
    artifact["sus-research"] = "research"
    artifact["sus-review"] = "review"
    artifact["sus-spec"] = "spec"
    artifact["sus-task"] = "task"
  }
  NR == 1 { next }
  {
    expected_type = ($2 in artifact) ? artifact[$2] : "none"
    if ($7 != expected_type && $3 != "near-miss") exit 1
    if (!($2 in artifact) && $7 != "none") exit 1
  }
' "$CASES" || {
  echo "evaluation artifact ownership drift" >&2
  exit 1
}

awk -F '	' '
  NR == 1 { next }
  {
    selection = $1 ~ /^(fork-me-(direct|implicit|isolated)|fork-question-(preference|binary|text-fallback))$/
    selection = selection || $1 ~ /^(sus-review-(direct|implicit|isolated)|review-decision-handoff)$/
    selection = selection || $1 ~ /^campaign-(pr-size|stance-budget)$/
    if (selection && $8 != "selection") exit 1
    if ($1 == "artifact-close" && $8 != "selection-after-action") exit 1
    if ($1 ~ /^(fork-me-near-miss|fork-user-fact|fork-discoverable-fact)$/ && $8 != "none") exit 1
  }
' "$CASES" || {
  echo "evaluation question contract drift" >&2
  exit 1
}

for id in fork-question-preference fork-question-binary fork-question-text-fallback fork-user-fact \
  fork-discoverable-fact campaign-topology revolver-order triple-wave bulletproof-evidence \
  demolition-quarantine dissect-rendering artifact-close campaign-review-handoff \
  change-plan-inventory-handoff review-decision-handoff campaign-pr-size campaign-stance-budget \
  campaign-inline-review campaign-owner-repair; do
  awk -F '	' -v id="$id" 'NR > 1 && $1 == id { found = 1 } END { exit !found }' "$CASES" || {
    echo "required behavior case missing: $id" >&2
    exit 1
  }
done

result_header='source_commit	payload_digest	harness	harness_version	model	date	case_id	repetition	activation	artifact	question	invariant	forbidden	tokens	latency_ms	trace	result'
for result in "$ROOT"/evals/results/*.tsv; do
  test -e "$result" || continue
  awk -F '	' -v expected="$result_header" '
    NR == 1 { if ($0 != expected) exit 1; next }
    NF != 17 { exit 1 }
    $1 !~ /^[0-9a-f]{40}$/ || $2 !~ /^[0-9a-f]{64}$/ { exit 1 }
    $6 !~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ || $8 !~ /^[1-9][0-9]*$/ { exit 1 }
    $9 !~ /^(pass|fail|blocked)$/ || $10 !~ /^(none|spec|task|review|inventory|change-plan|audit|research)$/ { exit 1 }
    $12 !~ /^(pass|fail|blocked)$/ || $13 !~ /^(pass|fail|blocked)$/ { exit 1 }
    $14 !~ /^([0-9]+|n\/a)$/ || $15 !~ /^([0-9]+|n\/a)$/ { exit 1 }
    {
      for (i = 1; i <= 17; i++) if ($i == "") exit 1
      rows += 1
    }
    END { if (!rows) exit 1 }
  ' "$result" || {
    echo "invalid evaluation result: $result" >&2
    exit 1
  }
  awk -F '	' 'NR > 1 { print $7 }' "$result" | while IFS= read -r id; do
    awk -F '	' -v id="$id" 'NR > 1 && $1 == id { found = 1 } END { exit !found }' "$CASES" || {
      echo "evaluation result names unknown case: $id" >&2
      exit 1
    }
  done
done

echo "lint-evals: OK"
