#!/bin/sh
set -eu

ROOT=${1:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
ROOT=$(CDPATH= cd -- "$ROOT" && pwd)

expected='bulletproof
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

artifact_creators='sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task'
universal_methods='bulletproof demolition disrespec dissect fork-me promote remember revolver triple-check'

for file in "$ROOT"/skills/*/SKILL.md; do
  folder=$(CDPATH= cd -- "$(dirname "$file")" && pwd -P)
  name=$(basename "$folder")
  validate_skill_frontmatter "$file" "$name" || {
    echo "invalid skill frontmatter: $name" >&2
    exit 1
  }
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
      grep -Fq '~/.agents/artifacts/<workspace>/' "$file" || { echo "neutral root missing in $name" >&2; exit 1; }
      for word in absolute repository vendor temporary collision; do
        require_regex "$file" "$word" "incomplete artifact placement in $name"
      done
      require_regex "$file" '(unwritable|blocked writes?)' "incomplete blocked-write handling in $name"
      for word in Delete Leave Promote sidecar 'fully actioned' 'downstream step' 'human disposition'; do
        require_regex "$file" "$word" "incomplete lifecycle disposition in $name"
      done
      ;;
  esac

  case " $universal_methods " in
    *" $name "*)
      if grep -Eq '~/.agents/artifacts/<workspace>/|fully actioned.*sidecars|type:[[:space:]]+(inspection|spec|task|review|inventory|change-plan|audit|research)' "$file"; then
        echo "artifact authorship leaked into universal method: $name" >&2
        exit 1
      fi
      ;;
  esac
done

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

revolver="$ROOT/skills/revolver/SKILL.md"
require_regex "$revolver" 'at least six materially distinct stances' 'Revolver stance floor missing'
require_regex "$revolver" 'one fresh reviewer at a time' 'Revolver reviewer sequence missing'
require_regex "$revolver" '(Kill|address).*finding.*before.*next stance' 'Revolver resolution order missing'
require_regex "$revolver" 'Finish the full pool' 'Revolver full rotation missing'
require_regex "$revolver" 'quiet rotation.*three cycles|three cycles.*quiet rotation' 'Revolver stop bounds missing'
require_regex "$revolver" 'supported: apply the fix and verify' 'Revolver remediation missing'
require_regex "$revolver" 'human decision: stop until selected' 'Revolver decision stop missing'

triple="$ROOT/skills/triple-check/SKILL.md"
require_regex "$triple" 'exactly three materially distinct stances' 'Triple-check pass count missing'
require_regex "$triple" 'fresh top-tier reviewer' 'Triple-check model tier missing'
require_regex "$triple" 'no peer prose' 'Triple-check independence missing'
require_regex "$triple" 'supported: apply the fix and run decisive verification' 'Triple-check remediation missing'
require_regex "$triple" 'unresolved real defect blocks the next pass' 'Triple-check resolution order missing'
require_regex "$triple" 'Complete exactly three passes' 'Triple-check completion missing'

fork_me="$ROOT/skills/fork-me/SKILL.md"
require_regex "$fork_me" 'ALWAYS apply whenever.*ambiguous' 'Fork-me activation boundary missing'
require_regex "$fork_me" 'at least three materially different options' 'Fork-me option floor missing'
require_regex "$fork_me" 'recommendation first' 'Fork-me recommendation order missing'
require_regex "$fork_me" 'reason and cost in one plain sentence' 'Fork-me explanation contract missing'
require_regex "$fork_me" 'harness-native picker.*`Other`' 'Fork-me picker contract missing'
require_regex "$fork_me" 'unavailable.*same numbered.*`Other`' 'Fork-me text fallback missing'
require_regex "$fork_me" 'Freeze dependent work until selection' 'Fork-me execution block missing'

bulletproof="$ROOT/skills/bulletproof/SKILL.md"
require_regex "$bulletproof" 'Verification:' 'Bulletproof verification mode missing'
require_regex "$bulletproof" 'Implementation proof:' 'Bulletproof implementation-proof mode missing'
require_regex "$bulletproof" 'Freeze the verification target' 'Bulletproof may edit target'
require_regex "$bulletproof" 'Supported.*Unsupported.*Unverified.*Blocked' 'Bulletproof assessments missing'

demolition="$ROOT/skills/demolition/SKILL.md"
grep -Fq 'Advocacy exercise, not evidence.' "$demolition" || { echo "Demolition quarantine banner missing" >&2; exit 1; }
require_regex "$demolition" 'Apply only when the user requests' 'Demolition activation boundary missing'
require_regex "$demolition" 'Fabricated sources.*test output are disqualifying' 'Demolition fabrication boundary missing'

dissect="$ROOT/skills/dissect/SKILL.md"
require_regex "$dissect" 'Trace it to bedrock' 'Dissect hard method missing'
require_regex "$dissect" 'Return only:' 'Dissect bounded return missing'

disrespec="$ROOT/skills/disrespec/SKILL.md"
require_regex "$disrespec" 'Edit the supplied Markdown in place' 'Disrespec target boundary missing'
require_regex "$disrespec" 'delete default behavior' 'Disrespec default-behavior economy missing'
require_regex "$disrespec" 'Replace weak verbs.*hard imperatives' 'Disrespec ruthless-language rule missing'

review="$ROOT/skills/sus-review/SKILL.md"
require_regex "$review" 'Requirement coverage' 'Review coverage missing'
require_regex "$review" 'Supported.*Unsupported.*Unverified.*Blocked' 'Review assessments missing'
require_regex "$review" 'Any Blocked row.*Request changes or Defer' 'Review blocked-state choices missing'
require_regex "$review" 'Never offer plain Accept' 'Review waiver boundary missing'

spec="$ROOT/skills/sus-spec/SKILL.md"
for literal in 'type: spec' 'status: draft' '## Intent' '## Requirements' 'Verify with:'; do
  require_literal "$spec" "$literal" 'Spec authoring contract drift'
done

task="$ROOT/skills/sus-task/references/task-packet.md"
for literal in 'type: task' 'status: ready' 'source:' 'scope:' '## Source' '## Scope' \
  '## Do not change' '## Affected areas' '## Verify' '## Agent instructions' '## Findings' \
  '## Run order' 'Starts after:' 'May run with:' '## Run summary'; do
  require_literal "$task" "$literal" 'Task authoring contract drift'
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
