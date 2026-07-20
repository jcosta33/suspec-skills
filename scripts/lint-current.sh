#!/bin/sh
set -eu

ROOT=${1:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
ROOT=$(CDPATH= cd -- "$ROOT" && pwd)

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

actual_directories=$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
actual_payloads=$(
  find "$ROOT/skills" -mindepth 2 -maxdepth 2 -type f -name SKILL.md -exec dirname {} \; |
    while IFS= read -r directory; do basename "$directory"; done |
    sort
)
catalog=$(
  sed -nE 's#.*\(\./skills/([^/]+)/SKILL\.md\).*#\1#p' "$ROOT/README.md" |
    sort
)
for manifest in "$actual_directories" "$actual_payloads" "$catalog"; do
  test "$manifest" = "$expected" || {
    echo "skill manifest drift" >&2
    printf 'expected:\n%s\nactual:\n%s\n' "$expected" "$manifest" >&2
    exit 1
  }
done
expected_catalog_rows=$(printf '%s\n' "$expected" | awk '{ print $0 ":" $0 }')
catalog_rows=$(
  sed -nE 's#^\| \[`([^`]+)`\]\(\./skills/([^/]+)/SKILL\.md\).*$#\1:\2#p' "$ROOT/README.md" |
    sort
)
test "$catalog_rows" = "$expected_catalog_rows" || {
  echo "catalog label and target drift" >&2
  exit 1
}

expected_docs='README.md
activation.md
body-anatomy.md
execution.md
scope.md
self-containment.md
skill-existence-test.md
sources.md'
actual_docs=$(find "$ROOT/docs" -mindepth 1 -maxdepth 1 -type f -name '*.md' -exec basename {} \; | sort)
test "$actual_docs" = "$expected_docs" || {
  echo "design docs manifest drift" >&2
  printf 'expected:\n%s\nactual:\n%s\n' "$expected_docs" "$actual_docs" >&2
  exit 1
}

if find "$ROOT/skills" -type f ! -name '*.md' | grep -q .; then
  echo "skill payload contains a non-Markdown file" >&2
  exit 1
fi
if find "$ROOT/skills" -type l | grep -q .; then
  echo "skill payload contains a symlink" >&2
  exit 1
fi

require_regex() {
  file=$1
  pattern=$2
  label=$3
  tr '\n' ' ' < "$file" | grep -Eqi "$pattern" || {
    echo "$label: $file" >&2
    exit 1
  }
}

require_literal() {
  file=$1
  literal=$2
  label=$3
  grep -Fq -- "$literal" "$file" || {
    echo "$label: $file" >&2
    exit 1
  }
}

description_text() {
  awk '/^description:[[:space:]]+/ { sub(/^description:[[:space:]]+/, ""); print; exit }' "$1"
}

require_description_regex() {
  file=$1
  pattern=$2
  label=$3
  description=$(description_text "$file")
  printf '%s\n' "$description" | grep -Eqi "$pattern" || {
    echo "$label: $file" >&2
    exit 1
  }
}

section_text() {
  awk -v heading="## $2" '
    $0 == heading { inside = 1; next }
    inside && /^## / { exit }
    inside { print }
  ' "$1" | tr '\n' ' '
}

relative_links() {
  grep -oE ']\([^)]*\)' |
    sed -E 's/^]\((.*)\)$/\1/' |
    sed -E 's/[?#].*$//' |
    awk 'length > 0 && $0 !~ /^\// && $0 !~ /^[[:alpha:]][[:alnum:]+.-]*:/'
}

validate_skill_frontmatter() {
  file=$1
  expected_name=$2
  awk -v expected_name="$expected_name" '
    NR == 1 {
      if ($0 != "---") exit 1
      inside = 1
      next
    }
    inside && $0 == "---" {
      inside = 0
      closed = 1
      next
    }
    inside {
      if ($0 ~ /^name:[[:space:]]+/) {
        value = $0
        sub(/^name:[[:space:]]+/, "", value)
        names += 1
        if (value != expected_name) exit 1
        next
      }
      if ($0 ~ /^description:[[:space:]]+/) {
        value = $0
        sub(/^description:[[:space:]]+/, "", value)
        sub(/[[:space:]]+#.*/, "", value)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
        lower = tolower(value)
        if (length(value) > 1024 || value !~ /^[[:alpha:]]/ || lower ~ /^(null|true|false|yes|no|on|off)$/) exit 1
        descriptions += 1
        next
      }
      exit 1
    }
    END {
      if (!closed || names != 1 || descriptions != 1) exit 1
    }
  ' "$file"
}

validate_description_anatomy() {
  printf '%s\n' "$1" | grep -Eq \
    '^[^.]+\. Use (only )?when [^.]+\. Do not use (for|as the owner of) [^.]+\.$'
}

validate_body_anatomy() {
  awk '
    BEGIN {
      rank["Method"] = 1
      rank["Artifact"] = 2
      rank["Verify"] = 3
      rank["Decision"] = 4
      rank["Output"] = 5
      rank["Boundaries"] = 6
      rank["Close"] = 7
    }
    /^## / {
      heading = substr($0, 4)
      if (!(heading in rank) || rank[heading] <= previous || seen[heading]++) exit 1
      previous = rank[heading]
    }
    END {
      if (seen["Method"] != 1) exit 1
    }
  ' "$1"
}

validate_link_syntax() {
  file=$1
  if grep -nE ']\[[^]]*\]|^[[:space:]]*\[[^]]+\]:' "$file"; then
    echo "reference-style link is unsupported: $file" >&2
    return 1
  fi
  if grep -nE ']\(<|]\([^)]*[[:space:]][^)]*\)|]\([^)]*\(' "$file"; then
    echo "complex inline link is unsupported: $file" >&2
    return 1
  fi
  if grep -niE ']\((file|data|javascript):' "$file"; then
    echo "unsafe URI link is forbidden: $file" >&2
    return 1
  fi
  if grep -nE ']\([^)]*#' "$file"; then
    echo "fragment link is unsupported: $file" >&2
    return 1
  fi
}

validate_artifact_frontmatter() {
  file=$1
  expected_type=$2
  expected_prefix=$3
  awk -v expected_type="$expected_type" -v expected_prefix="$expected_prefix" '
    {
      line = $0
      sub(/^[[:space:]]+/, "", line)
    }
    NR == 1 && line == "---" {
      in_yaml = 1
      inside = 1
      next
    }
    line == "```yaml" {
      in_yaml = 1
      next
    }
    in_yaml && line == "---" {
      if (!inside) {
        inside = 1
        types = 0
        ids = 0
        type_value = ""
        id_value = ""
        next
      }
      if (types == 1 && ids == 1 && type_value == expected_type && index(id_value, expected_prefix) == 1) {
        found += 1
      }
      inside = 0
      next
    }
    inside && line ~ /^type:[[:space:]]+/ {
      type_value = line
      sub(/^type:[[:space:]]+/, "", type_value)
      gsub(/^["\047]|["\047]$/, "", type_value)
      types += 1
      next
    }
    inside && line ~ /^id:[[:space:]]+/ {
      id_value = line
      sub(/^id:[[:space:]]+/, "", id_value)
      gsub(/^["\047]|["\047]$/, "", id_value)
      ids += 1
      next
    }
    in_yaml && line == "```" {
      in_yaml = 0
      inside = 0
    }
    END {
      if (found != 1) exit 1
    }
  ' "$file"
}

declaration_values() {
  root=$1
  key=$2
  find "$root" -type f -name '*.md' -exec awk -v key="$key" '
    {
      rest = $0
      pattern = "(^|[`[:space:]])" key ":[[:space:]]+"
      while (match(rest, pattern)) {
        value = substr(rest, RSTART + RLENGTH)
        first = substr(value, 1, 1)
        if (first == "\"" || first == "\047") value = substr(value, 2)
        if (match(value, /^[[:alnum:]-]+/)) print substr(value, RSTART, RLENGTH)
        rest = substr(rest, RSTART + RLENGTH)
      }
    }
  ' {} + | sort -u
}

for document in "$ROOT/README.md" "$ROOT/AGENTS.md" $(find "$ROOT/docs" "$ROOT/skills" -type f -name '*.md'); do
  validate_link_syntax "$document" || exit 1
  directory=$(dirname "$document")
  relative_links < "$document" | while IFS= read -r ref; do
    [ -z "$ref" ] || test -e "$directory/$ref" || {
      echo "broken relative link: $document -> $ref" >&2
      exit 1
    }
  done
done

require_literal "$ROOT/docs/activation.md" 'Use exactly three sentences:' \
  'activation anatomy contract missing'
require_literal "$ROOT/docs/activation.md" 'Test intended semantic handoffs' \
  'semantic activation test missing'
require_literal "$ROOT/docs/activation.md" 'Treat results as local evidence' \
  'activation evidence limit missing'
require_literal "$ROOT/docs/body-anatomy.md" '`Method` is mandatory.' \
  'body anatomy contract missing'
require_literal "$ROOT/docs/body-anatomy.md" 'Use hard verbs.' \
  'ruthless body language missing'
require_literal "$ROOT/docs/self-containment.md" 'Every skill must survive as the only installed Suspec skill.' \
  'standalone contract missing'
require_literal "$ROOT/docs/self-containment.md" '## Semantic composition' \
  'semantic composition contract missing'
require_literal "$ROOT/docs/scope.md" 'universal verification, campaign coordination' \
  'catalog scope contract missing'
for skill in $expected; do
  require_literal "$ROOT/docs/skill-existence-test.md" "\`$skill\`" \
    "existence test omits $skill"
done
for heading in '## Maintenance' '## Skill Format And Context Economy' '## Evidence And Inspection' \
  '## Campaign Coordination' '## Research Method'; do
  require_literal "$ROOT/docs/sources.md" "$heading" 'source ledger section missing'
done
for source in \
  'https://learn.chatgpt.com/docs/build-skills' \
  'https://agentskills.io/specification' \
  'https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices' \
  'https://github.com/Frontify/skills/blob/main/docs/activation.md' \
  'https://github.com/Frontify/skills/blob/main/docs/body-anatomy.md' \
  'https://github.com/Frontify/skills/blob/main/docs/execution.md' \
  'https://github.com/Frontify/skills/blob/main/docs/sources.md' \
  'https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request' \
  'https://google.github.io/eng-practices/review/reviewer/comments.html'; do
  require_literal "$ROOT/docs/sources.md" "$source" 'source ledger coverage missing'
done
require_literal "$ROOT/AGENTS.md" \
  'Update `docs/sources.md` in the same change whenever an externally grounded skill or design rule' \
  'source maintenance edit contract missing'

artifact_creators='sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task'
universal_methods='bulletproof campaign demolition disrespec dissect fork-me promote remember revolver triple-check'

for file in "$ROOT"/skills/*/SKILL.md; do
  folder=$(CDPATH= cd -- "$(dirname "$file")" && pwd -P)
  name=$(basename "$folder")
  validate_skill_frontmatter "$file" "$name" || {
    echo "invalid skill frontmatter: $name" >&2
    exit 1
  }
  description=$(awk '/^description:[[:space:]]+/ { sub(/^description:[[:space:]]+/, ""); print; exit }' "$file")
  validate_description_anatomy "$description" || {
    echo "invalid description anatomy: $name" >&2
    exit 1
  }
  if printf '%s\n' "$description" | grep -Eqi "(^|[^[:alnum:]-])$name([^[:alnum:]-]|$)"; then
    echo "skill description names itself: $name" >&2
    exit 1
  fi
  validate_body_anatomy "$file" || {
    echo "invalid body anatomy: $name" >&2
    exit 1
  }
  lines=$(wc -l < "$file" | tr -d '[:space:]')
  if [ "$lines" -gt 500 ]; then
    echo "skill body exceeds 500 lines: $name" >&2
    exit 1
  fi
  grep -Fq "\`$name\`" "$ROOT/README.md" || { echo "catalog omits skill: $name" >&2; exit 1; }

  find "$folder" -mindepth 1 -type d -print | while IFS= read -r path; do
    relative=${path#"$folder"/}
    case "$relative" in
      references|references/*) ;;
      *)
        echo "unexpected skill payload directory: $path" >&2
        exit 1
        ;;
    esac
  done
  find "$folder" -mindepth 1 -type f -print | while IFS= read -r path; do
    relative=${path#"$folder"/}
    case "$relative" in
      SKILL.md|references/*.md) ;;
      *)
        echo "unexpected skill payload file: $path" >&2
        exit 1
        ;;
    esac
  done

  find "$folder" -type f -name '*.md' -print | while IFS= read -r document; do
    if grep -nE ']\(/[^)]*\)' "$document"; then
      echo "root-relative link escapes package: $document" >&2
      exit 1
    fi
    directory=$(dirname "$document")
    relative_links < "$document" | while IFS= read -r ref; do
      [ -z "$ref" ] && continue
      target_directory=$(CDPATH= cd -- "$directory/$(dirname "$ref")" && pwd -P)
      target="$target_directory/$(basename "$ref")"
      case "$target" in
        "$folder"|"$folder"/*) ;;
        *)
          echo "skill link escapes package: $document -> $ref" >&2
          exit 1
          ;;
      esac
    done
    if grep -nE 'DISRESPEC-SPINE|SPINE-(START|END)|ADR-[0-9]+|lint-[a-z-]+|this catalog|sibling skill|if installed|catalog topology' "$document"; then
      echo "internal or dependency vocabulary in $name: $document" >&2
      exit 1
    fi
    if grep -nE '\.\./[^/]+/SKILL\.md' "$document"; then
      echo "external skill dependency in $name: $document" >&2
      exit 1
    fi
    case "${document#"$folder"/}" in
      references/*)
        if relative_links < "$document" | grep -q .; then
          echo "nested bundled reference in $name: $document" >&2
          exit 1
        fi
        ;;
    esac
    for sibling in $expected; do
      [ "$sibling" = "$name" ] && continue
      if grep -nE "(^|[^[:alnum:]-])$sibling([^[:alnum:]-]|$)" "$document"; then
        echo "sibling skill named in $name: $sibling ($document)" >&2
        exit 1
      fi
    done
  done

  if [ "$name" != fork-me ] && grep -Eqi 'at least three materially different options|harness-native picker and its `Other`|batch independent forks' "$file"; then
    echo "ambiguity protocol duplicated outside fork-me: $name" >&2
    exit 1
  fi

  if grep -Eqi 'Create no artifact|Do not create an artifact|Keep round state in the orchestrator|Ordinary conversation and direct action create no|Never author, place, or relocate|Never create a sidecar' "$file"; then
    echo "inert negative instruction in $name" >&2
    exit 1
  fi

  case " $artifact_creators " in
    *" $name "*)
      for heading in '## Artifact' '## Close'; do
        require_literal "$file" "$heading" "incomplete artifact anatomy in $name"
      done
      grep -Fq '~/.agents/artifacts/<workspace>/' "$file" || { echo "neutral root missing in $name" >&2; exit 1; }
      for word in absolute repository vendor temporary collision; do
        require_regex "$file" "$word" "incomplete artifact placement in $name"
      done
      require_regex "$file" '(unwritable|blocked writes?)' "incomplete blocked-write handling in $name"
      for word in Delete Leave Promote sidecar 'fully actioned' 'downstream step' 'human disposition'; do
        require_regex "$file" "$word" "incomplete lifecycle disposition in $name"
      done
      output_text=$(section_text "$file" Output)
      printf '%s\n' "$output_text" | grep -Eqi \
        'compress and harden the document without changing its contract.*identifiers.*verbatim source text.*evidence.*behavior.*repetition.*softness.*ceremony.*structural bloat.*Rerun applicable checks' || {
        echo "artifact compression handoff missing in $name" >&2
        exit 1
      }
      if printf '%s\n' "$output_text" | grep -Eqi '(do not|never)[^.]*compress and harden'; then
        echo "artifact compression handoff negated in $name" >&2
        exit 1
      fi
      require_regex "$file" 'If Promote is selected.*move the transient working material into project-owned permanence' \
        "durable promotion handoff missing in $name"
      ;;
  esac

  case " $universal_methods " in
    *" $name "*)
      if grep -Eq '^## (Artifact|Verify|Decision|Close)$' "$file"; then
        echo "artifact anatomy leaked into universal method: $name" >&2
        exit 1
      fi
      if grep -Eq '~/.agents/artifacts/<workspace>/|fully actioned.*sidecars|type:[[:space:]]+(inspection|spec|task|review|inventory|change-plan|audit|research)' "$file"; then
        echo "artifact authorship leaked into universal method: $name" >&2
        exit 1
      fi
      ;;
  esac
done

require_description_regex "$ROOT/skills/bulletproof/SKILL.md" \
  '^Fact-check claims.*prove completed implementation.*direct evidence\. Use when.*claims.*completed work.*\. Do not use as the owner of' \
  'Bulletproof activation contract missing'
require_description_regex "$ROOT/skills/campaign/SKILL.md" \
  '^Orchestrate broad software delivery across reusable worktree lanes.*multiple pull requests.*adaptive model routing.*independent review\. Use when.*delivery goal.*multiple dependency-aware, write-disjoint implementation streams.*repositories\. Do not use for' \
  'Campaign activation contract missing'
require_description_regex "$ROOT/skills/disrespec/SKILL.md" \
  '^Compress and harden supplied prose\. Use when.*repetition.*softness.*ceremony.*structural bloat.*\. Do not use for' \
  'Disrespec activation contract missing'
require_description_regex "$ROOT/skills/dissect/SKILL.md" \
  '^Trace one unfamiliar or dangerous code path to closure\. Use when.*callers.*flow.*state.*effects.*failures.*\. Do not use as the owner of' \
  'Dissect activation contract missing'
require_description_regex "$ROOT/skills/fork-me/SKILL.md" \
  '^Force material ambiguity into explicit human selection\. Use when.*unresolved.*\. Do not use for' \
  'Fork-me activation contract missing'
require_description_regex "$ROOT/skills/promote/SKILL.md" \
  '^Move transient working material into project-owned permanence\. Use only when.*durable\. Do not use for' \
  'Promote activation contract missing'
require_description_regex "$ROOT/skills/revolver/SKILL.md" \
  '^Run exhaustive multi-angle review and sequential repair.*\. Use when.*every target-justified stance.*\. Do not use for' \
  'Revolver activation contract missing'
require_description_regex "$ROOT/skills/triple-check/SKILL.md" \
  '^Run a fast parallel review with exactly three fresh top-tier reviewers.*\. Use when.*rapid independent scrutiny.*\. Do not use for' \
  'Triple-check activation contract missing'
require_description_regex "$ROOT/skills/sus-inventory/SKILL.md" \
  '^Map an unfamiliar or change-critical code area as durable current state\. Use when wide change lacks a proven map\. Do not use for' \
  'Inventory activation contract missing'
require_description_regex "$ROOT/skills/sus-research/SKILL.md" \
  '^Research a decision until evidence can carry it\. Use when.*comparing options.*evaluating.*\. Do not use as the owner of' \
  'Research activation contract missing'
require_description_regex "$ROOT/skills/sus-review/SKILL.md" \
  '^Review finished work against its governing Suspec spec.*task when present\. Use when.*completed work.*conformance\. Do not use for' \
  'Review activation contract missing'

writer_types='sus-spec:spec:SPEC- sus-task:task:TASK- sus-review:review:REVIEW- sus-inventory:inventory:INV- sus-change-plan:change-plan:CHANGE- sus-audit:audit:AUDIT- sus-research:research:RESEARCH-'
for pair in $writer_types; do
  writer=${pair%%:*}
  declaration=${pair#*:}
  expected_type=${declaration%%:*}
  expected_prefix=${declaration#*:}
  actual_types=$(declaration_values "$ROOT/skills/$writer" type)
  test "$actual_types" = "$expected_type" || {
    echo "artifact type ownership drift in $writer: $actual_types" >&2
    exit 1
  }
  if [ "$writer" = sus-task ]; then
    frontmatter_source="$ROOT/skills/sus-task/references/task-packet.md"
  else
    frontmatter_source="$ROOT/skills/$writer/SKILL.md"
  fi
  validate_artifact_frontmatter "$frontmatter_source" "$expected_type" "$expected_prefix" || {
    echo "artifact frontmatter contract drift in $writer" >&2
    exit 1
  }
done

for method in $universal_methods; do
  test -z "$(declaration_values "$ROOT/skills/$method" type)" || {
    echo "universal method owns an artifact type: $method" >&2
    exit 1
  }
done

campaign="$ROOT/skills/campaign/SKILL.md"
require_regex "$campaign" 'issue or issue-backed epic as the campaign ledger.*milestones only as grouping metadata' \
  'Campaign ledger semantics missing'
require_regex "$campaign" 'three genuine options by default.*two when genuinely binary.*recommendation first' \
  'Campaign ambiguity shape missing'
require_regex "$campaign" 'global lane budget.*independent width.*machine capacity.*CI.*reviewer capacity.*partition.*fixed per-repository pools' \
  'Campaign lane sizing missing'
require_regex "$campaign" 'Create each worktree once.*Reuse the worktree after each pull request.*empty tracked and untracked status.*detach.*remote-base commit.*ignored dependencies.*lockfile and toolchain identity.*refresh them when either changes.*Force-clean nothing' \
  'Campaign worktree reuse missing'
require_regex "$campaign" 'one active branch and one implementation owner[[:space:]]+per lane' \
  'Campaign lane ownership missing'
require_regex "$campaign" 'Schedule only dependency-ready, write-disjoint work' \
  'Campaign collision boundary missing'
require_regex "$campaign" 'cheapest model proven adequate.*repository evaluation.*deterministic oracle.*Escalate the blocked decision.*Return to the cheaper tier' \
  'Campaign adaptive routing missing'
require_regex "$campaign" 'Open a draft pull request.*project template.*imperative title.*Summary.*Verification.*Dependencies.*Risks.*Link the campaign ledger.*once' \
  'Campaign pull-request shape missing'
require_regex "$campaign" 'one independently reviewable concern.*declared dependency.*order' \
  'Campaign pull-request dependency shape missing'
require_regex "$campaign" '500 reviewable changed.*15 handwritten source files' \
  'Campaign pull-request size guard missing'
require_regex "$campaign" '15 handwritten source files.*explicit human approval' \
  'Campaign pull-request size override missing'
require_regex "$campaign" 'Rewrite stale body text instead of appending chronology.*Cut agent names.*transient artifacts.*internal review mechanics.*head diaries.*repeated evidence.*reviewer cannot act' \
  'Campaign pull-request economy missing'
require_regex "$campaign" 'exhaustive multi-angle review and sequential repair.*fixed target-justified stance pool' \
  'Campaign exhaustive review handoff missing'
require_regex "$campaign" 'smallest pool.*unique risk.*Three is the default.*More than five requires.*human approval.*split the pull request' \
  'Campaign stance budget missing'
require_regex "$campaign" 'Freeze the pool for one rotation.*creates or exposes.*previously unknown risk.*Never rebuild the pool.*because a finding was fixed' \
  'Campaign stance circuit breaker missing'
require_regex "$campaign" 'one fresh reviewer at a time.*governing requirements.*accepted decisions.*no pull-request conversation or.*prior reviewer prose' \
  'Campaign reviewer sequence missing'
require_regex "$campaign" 'Fact-check every finding as supported, refuted, a human decision, unverified, or blocked.*Kill.*duplicates.*stale findings.*preference dressed as defect.*unverified or blocked finding.*stops the stance' \
  'Campaign finding disposition missing'
require_regex "$campaign" 'Keep the method private.*Publish only supported actionable findings' \
  'Campaign publication boundary missing'
require_regex "$campaign" 'one pending review.*submit only when.*nonempty.*no summary' \
  'Campaign nonempty review boundary missing'
require_regex "$campaign" 'local defect.*narrowest changed line.*file comment.*file-wide defect' \
  'Campaign review placement missing'
require_regex "$campaign" 'review-body item.*cross-cutting defect.*one.*repair and owner' \
  'Campaign broad-defect placement missing'
require_regex "$campaign" 'Quiet stances and refutations produce nothing' \
  'Campaign quiet review publication missing'
require_regex "$campaign" 'one terse paragraph: defect, consequence, required outcome.*severity scheme.*label only merge blockers.*Cut greetings.*summaries.*process narration.*solution essays' \
  'Campaign comment economy missing'
require_regex "$campaign" 'thread links, not a restatement.*replies once.*Fixed in <sha>.*decisive proof.*checks the current head.*resolves the thread.*no follow-up review event or completion recap' \
  'Campaign review ownership missing'
require_regex "$campaign" 'next stance only after every item from the current stance is resolved' \
  'Campaign stance resolution order missing'
require_regex "$campaign" 'Finish the frozen pool once.*Run no quiet rotation.*ceremonial' \
  'Campaign review completion missing'
require_regex "$campaign" 'reviewed head and base SHAs.*merge immediately.*ledger-authorized mode.*protected merge queue.*revalidate both SHAs.*expected-head merge.*drift resets affected checks and review.*Never.*authorized mergeable pull request open' \
  'Campaign merge gate missing'
require_regex "$campaign" 'explicit human or project-policy authorization.*delete merged local and remote branches.*remove clean worktrees without force' \
  'Campaign cleanup authority missing'
require_regex "$campaign" 'Humans and project policy own.*irreversible actions.*acceptance.*merge authority' \
  'Campaign human authority missing'
require_regex "$campaign" 'verification of acceptance.*every merged SHA' \
  'Campaign merged-state proof missing'
require_regex "$campaign" 'requires separate worktrees' \
  'Campaign worktree boundary missing'
if grep -Fq 'One command. Many lanes. Nothing off the books.' "$campaign"; then
  echo 'Campaign filler returned' >&2
  exit 1
fi
if grep -Eqi 'formal[[:space:]]+request-changes review|reviewer approves' "$campaign"; then
  echo 'Campaign agent merge authority returned' >&2
  exit 1
fi
if grep -Eqi 'review event per stance|Record a quiet stance|follow-up review event referencing' "$campaign"; then
  echo 'Campaign review ceremony returned' >&2
  exit 1
fi
if grep -Eqi 'independently mergeable concern|isolated worktrees' "$campaign"; then
  echo 'Campaign stale delivery boundary returned' >&2
  exit 1
fi

revolver="$ROOT/skills/revolver/SKILL.md"
require_regex "$revolver" 'complete materially distinct stance pool' 'Revolver coverage pool missing'
require_regex "$revolver" 'Cover every.*material risk' 'Revolver risk coverage missing'
require_regex "$revolver" 'explicit human constraints.*without asking' 'Revolver pool authority missing'
require_regex "$revolver" 'no fixed floor or ceiling' 'Revolver adaptive pool missing'
require_regex "$revolver" 'one fresh reviewer at a time' 'Revolver reviewer sequence missing'
require_regex "$revolver" '(Kill|address).*finding.*before.*next stance' 'Revolver resolution order missing'
require_regex "$revolver" 'Finish the full pool' 'Revolver full rotation missing'
require_regex "$revolver" 'Add or remove stances only between rotations' 'Revolver pool timing missing'
require_regex "$revolver" 'quiet rotation.*three cycles|three cycles.*quiet rotation' 'Revolver stop bounds missing'
require_regex "$revolver" 'supported: apply the fix and verify' 'Revolver remediation missing'
require_regex "$revolver" 'human decision:.*stop until selected' 'Revolver decision stop missing'
require_regex "$revolver" 'fact-check every finding against direct evidence' 'Revolver fact-check handoff missing'
require_regex "$revolver" 'force material ambiguity into explicit human selection' 'Revolver decision handoff missing'
if grep -Eqi 'at least[[:space:]]+[0-9]+.*stances?' "$revolver"; then
  echo 'Revolver numeric stance floor returned' >&2
  exit 1
fi

triple="$ROOT/skills/triple-check/SKILL.md"
require_regex "$triple" 'exactly three fresh top-tier reviewers concurrently' 'Triple-check concurrent trio missing'
require_regex "$triple" 'same frozen snapshot' 'Triple-check snapshot parity missing'
require_regex "$triple" 'independently derives.*reviews the whole target' 'Triple-check independent coverage missing'
require_regex "$triple" 'no peer prose' 'Triple-check independence missing'
require_regex "$triple" 'Keep reviewers read-only' 'Triple-check reviewer mutation leak'
require_regex "$triple" 'Wait for all three.*Deduplicate' 'Triple-check reconciliation missing'
require_regex "$triple" 'After reconciliation, apply every queued fix' 'Triple-check repair timing missing'
require_regex "$triple" 'verification against the final target' 'Triple-check final proof missing'
require_regex "$triple" 'one dispatch wave.*explicit request' 'Triple-check repeat boundary missing'
require_regex "$triple" 'fact-check every finding against direct evidence' 'Triple-check fact-check handoff missing'
require_regex "$triple" 'force material ambiguity into explicit human selection' 'Triple-check decision handoff missing'

fork_me="$ROOT/skills/fork-me/SKILL.md"
require_regex "$fork_me" 'Use when.*unresolved' 'Fork-me activation boundary missing'
require_regex "$fork_me" 'three materially different options by default.*two when genuinely binary' 'Fork-me option shape missing'
require_regex "$fork_me" 'recommendation first' 'Fork-me recommendation order missing'
require_regex "$fork_me" 'reason and cost in one plain sentence' 'Fork-me explanation contract missing'
require_regex "$fork_me" 'harness-native picker.*`Other`' 'Fork-me picker contract missing'
require_regex "$fork_me" 'unavailable.*same numbered.*`Other`' 'Fork-me text fallback missing'
require_regex "$fork_me" 'Freeze dependent work until selection' 'Fork-me execution block missing'

bulletproof="$ROOT/skills/bulletproof/SKILL.md"
require_literal "$bulletproof" '### Verification' 'Bulletproof verification mode missing'
require_literal "$bulletproof" '### Implementation Proof' 'Bulletproof implementation-proof mode missing'
require_regex "$bulletproof" 'Freeze the verification target' 'Bulletproof may edit target'
require_regex "$bulletproof" 'Supported.*Unsupported.*Unverified.*Blocked' 'Bulletproof assessments missing'

demolition="$ROOT/skills/demolition/SKILL.md"
grep -Fq 'Advocacy exercise, not evidence.' "$demolition" || { echo "Demolition quarantine banner missing" >&2; exit 1; }
require_regex "$demolition" 'Use only when.*explicitly requests' 'Demolition activation boundary missing'
require_regex "$demolition" 'Fabricated sources.*test output are disqualifying' 'Demolition fabrication boundary missing'

dissect="$ROOT/skills/dissect/SKILL.md"
require_regex "$dissect" 'Trace it to bedrock' 'Dissect hard method missing'
require_regex "$dissect" 'Return only:' 'Dissect bounded return missing'

disrespec="$ROOT/skills/disrespec/SKILL.md"
require_regex "$disrespec" 'Edit the supplied prose in place' 'Disrespec target boundary missing'
require_regex "$disrespec" 'delete default behavior' 'Disrespec default-behavior economy missing'
require_regex "$disrespec" 'Replace weak verbs.*hard imperatives' 'Disrespec ruthless-language rule missing'
disrespec_method=$(section_text "$disrespec" Method)
for rule in 'canonical sources.*derivative copies' 'Freeze governing contracts' \
  'one authoritative home' 'Delete derivative duplicates' 'Verify every.*resulting link' \
  'original recoverable.*contract check passes.*restore.*failure'; do
  printf '%s\n' "$disrespec_method" | grep -Eqi "$rule" || {
    echo 'Disrespec method contract missing' >&2
    exit 1
  }
done
printf '%s\n' "$disrespec_method" | grep -Fqi 'restore and verify it on failure.' || {
  echo 'Disrespec rollback clause missing' >&2
  exit 1
}
if printf '%s\n' "$disrespec_method" | grep -Eqi '(do not|never)[^.]*restore'; then
  echo 'Disrespec rollback negated' >&2
  exit 1
fi

promote="$ROOT/skills/promote/SKILL.md"
promote_method=$(section_text "$promote" Method)
printf '%s\n' "$promote_method" | grep -Eqi \
  'Use Move unless.*explicitly requests both.*versions.*include Copy.*Apply the preflighted move or selected copy.*Keep a recovery copy until.*selected source disposition verify.*Commit only when selected.*Verify the commit.*After every selected action verifies.*delete the recovery copy.*verify it is absent.*selected source copy is durable output, not recovery' || {
  echo 'Promote recovery cleanup order missing' >&2
  exit 1
}
promote_boundaries=$(section_text "$promote" Boundaries)
for rule in 'restore every removed.*source.*repaired reference' 'remove the destination' \
  'verify rollback' 'Report anything rollback.*could not restore'; do
  printf '%s\n' "$promote_boundaries" | grep -Eqi "$rule" || {
    echo 'Promote failure rollback missing' >&2
    exit 1
  }
done

review="$ROOT/skills/sus-review/SKILL.md"
require_regex "$review" 'Requirement coverage' 'Review coverage missing'
require_regex "$review" 'Supported.*Unsupported.*Unverified.*Blocked' 'Review assessments missing'
require_regex "$review" 'Any Blocked row.*Request changes or Defer' 'Review blocked-state choices missing'
require_regex "$review" 'Never offer plain Accept' 'Review waiver boundary missing'
require_regex "$review" 'Prove completed implementation against direct evidence' 'Review proof handoff missing'
review_method=$(section_text "$review" Method)
for rule in 'reviewer read-only.*target frozen' \
  'compare its source ID.*source state.*requirement snapshots.*scope.*preservation.*guarantees.*mismatch blocks review.*re-cut packet' \
  'prove the harness can dispatch one fresh independent.*reviewer.*If it cannot, stop for human selection'; do
  printf '%s\n' "$review_method" | grep -Eqi "$rule" || {
    echo 'Review method authority missing' >&2
    exit 1
  }
done
if printf '%s\n' "$review_method" | grep -Eqi 'mismatch[^.]*((does not|never) block|only in|proceed)'; then
  echo 'Review task freshness weakened' >&2
  exit 1
fi
review_decision=$(section_text "$review" Decision)
printf '%s\n' "$review_decision" | grep -Eqi \
  'implementation owner fix.*verify.*complete fresh independent review' || {
  echo 'Review repair authority missing' >&2
  exit 1
}
printf '%s\n' "$review_decision" | grep -Fqi 'Only human selection changes `decision`' || {
  echo 'Review decision authority missing' >&2
  exit 1
}

spec="$ROOT/skills/sus-spec/SKILL.md"
for literal in 'type: spec' 'status: draft' '## Intent' '## Requirements' 'Verify with:'; do
  require_literal "$spec" "$literal" 'Spec authoring contract drift'
done
require_regex "$spec" 'decision lacks evidence.*research it until evidence can carry it' 'Spec research handoff missing'
require_regex "$spec" 'force material ambiguity into explicit human selection' 'Spec decision handoff missing'

task="$ROOT/skills/sus-task/references/task-packet.md"
for literal in 'type: task' 'status: ready' 'source:' 'scope:' '## Source' '## Scope' \
  '## Do not change' '## Affected areas' '## Verify' '## Agent instructions' '## Findings' \
  '## Run order' 'Starts after:' 'May run with:' '## Run summary'; do
  require_literal "$task" "$literal" 'Task authoring contract drift'
done
task_instructions=$(section_text "$task" 'Agent instructions')
for phrase in 'At `review-ready`.*hand the frozen target to a fresh independent reviewer' \
  'read-only review.*canonical source spec' 'task to narrow source-spec IDs' \
  'supply applicable.*preservation.*guarantees' 'source spec remains canonical for requirement text'; do
  printf '%s\n' "$task_instructions" | grep -Eqi "$phrase" || {
    echo 'Task review handoff missing' >&2
    exit 1
  }
done
printf '%s\n' "$task_instructions" | grep -Eqi \
  'Before editing or changing status.*compare source IDs.*source state.*requirement snapshots.*scope.*preservation.*guarantees.*mismatch blocks dispatch.*re-cut packet' || {
  echo 'Task dispatch freshness missing' >&2
  exit 1
}
printf '%s\n' "$task_instructions" | grep -Eqi 'implementation owner applies fixes.*requests fresh review' || {
  echo 'Task review repair authority missing' >&2
  exit 1
}
printf '%s\n' "$task_instructions" | grep -Eqi 'Without a fresh reviewer.*status: review-ready.*never close or self-review' || {
  echo 'Task review capability fallback missing' >&2
  exit 1
}
printf '%s\n' "$task_instructions" | grep -Eqi \
  'status: closed.*only after fresh review completes.*findings are reconciled.*human.*acceptance is recorded.*Otherwise remain.*review-ready' || {
  echo 'Task closure authority missing' >&2
  exit 1
}
if printf '%s\n' "$task_instructions" | grep -Eqi '(do not|never)[^.]*review against the.*canonical source spec'; then
  echo 'Task review handoff negated' >&2
  exit 1
fi
if printf '%s\n' "$task_instructions" | grep -Eqi '(only in examples|without fresh review|close without.*fresh review)'; then
  echo 'Task review authority weakened' >&2
  exit 1
fi

change_plan="$ROOT/skills/sus-change-plan/SKILL.md"
change_plan_artifact=$(section_text "$change_plan" Artifact)
for rule in 'Transformation waves:.*verification.*rollback point' \
  'Cutover / rollback:.*observable entry, completion, abort, and restoration conditions'; do
  printf '%s\n' "$change_plan_artifact" | grep -Eqi "$rule" || {
    echo 'Change-plan rollback contract missing' >&2
    exit 1
  }
done
change_plan_verify=$(section_text "$change_plan" Verify)
for rule in 'Preserve everything else' 'resolve every `preserves` ID.*source spec or.*plan guarantees' \
  'transformation wave.*verification'; do
  printf '%s\n' "$change_plan_verify" | grep -Eqi "$rule" || {
    echo 'Change-plan preservation contract missing' >&2
    exit 1
  }
done

for literal in 'type: review' 'spec:' 'reviewer:' 'decision: pending' \
  '| ID | Assessment | Evidence |'; do
  require_literal "$review" "$literal" 'Review authoring contract drift'
done

change_plan="$ROOT/skills/sus-change-plan/SKILL.md"
for literal in 'type: change-plan' 'preserves:' 'Baseline' 'Target' 'Preservation guarantees' \
  'Transformation waves' 'Cutover / rollback' 'Task split'; do
  require_literal "$change_plan" "$literal" 'Change-plan authoring contract drift'
done
require_regex "$change_plan" 'wide change.*lacks a proven map.*map the unfamiliar or change-critical area as durable current state' \
  'Change-plan inventory handoff missing'

for path_skill in sus-audit sus-inventory; do
  require_regex "$ROOT/skills/$path_skill/SKILL.md" 'unfamiliar or dangerous code path to closure' \
    "Dissection handoff missing in $path_skill"
done

for decision_skill in remember sus-audit sus-change-plan sus-inventory sus-research sus-task; do
  require_regex "$ROOT/skills/$decision_skill/SKILL.md" 'force material ambiguity.*explicit human selection' \
    "Decision handoff missing in $decision_skill"
done

stale='concise-output|revolver-review|codebase-exploration|promote-artifact|save-findings|empirical-proof|implement-task|market-research|planning-spec|write-spec|spec-check|split-work|review-output|security-review|fix-flaky-test|git-pr|write-audit|write-bug-report|write-change-plan|write-documentation|write-feature|write-fix|write-inventory|write-migration|write-performance|write-prd|write-refactor|write-research|write-rewrite|write-rfc|write-testing'
if grep -RniE "(^|[^[:alnum:]-])($stale)([^[:alnum:]-]|$)" "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/.github" "$ROOT/docs" "$ROOT/skills"; then
  echo "stale current method name" >&2
  exit 1
fi
unreleased=$(sed -n '/^## \[Unreleased\]/,/^## \[/p' "$ROOT/CHANGELOG.md" | sed '$d')
if printf '%s\n' "$unreleased" | grep -Ei "(^|[^[:alnum:]-])($stale)([^[:alnum:]-]|$)"; then
  echo "stale method name in current changelog" >&2
  exit 1
fi
if printf '%s\n' "$unreleased" | grep -Ei 'suspec-agents|canonical agent|Codex projection|agents/suspec-'; then
  echo "retired custom-agent guidance in current changelog" >&2
  exit 1
fi
if grep -RniE 'suspec-agents|canonical agent|Codex projection|agents/suspec-' "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/.github" "$ROOT/docs" "$ROOT/skills"; then
  echo "retired custom-agent guidance survives" >&2
  exit 1
fi

echo "lint-current: OK"
