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

actual=$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
test "$actual" = "$expected" || {
  echo "skill topology drift" >&2
  printf 'expected:\n%s\nactual:\n%s\n' "$expected" "$actual" >&2
  exit 1
}

if find "$ROOT/skills" -type f ! -name '*.md' | grep -q .; then
  echo "skill payload contains a non-Markdown file" >&2
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

relative_links() {
  grep -oE ']\((\.\.?/)[^)]*\)' | sed -E 's/^]\((.*)\)$/\1/' | sed -E 's/[?#].*$//'
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
  folder=$(dirname "$file")
  name=$(basename "$folder")
  frontmatter_name=$(sed -n 's/^name: //p' "$file" | head -1)
  test "$frontmatter_name" = "$name" || { echo "folder/name drift: $name != $frontmatter_name" >&2; exit 1; }
  grep -q '^description:' "$file" || { echo "missing description: $name" >&2; exit 1; }
  grep -Fq "\`$name\`" "$ROOT/README.md" || { echo "catalog omits skill: $name" >&2; exit 1; }

  find "$folder" -type f -name '*.md' -print | while IFS= read -r document; do
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

writer_types='sus-spec:spec sus-task:task sus-review:review sus-inventory:inventory sus-change-plan:change-plan sus-audit:audit sus-research:research'
for pair in $writer_types; do
  writer=${pair%%:*}
  expected_type=${pair#*:}
  actual_types=$(declaration_values "$ROOT/skills/$writer" type)
  test "$actual_types" = "$expected_type" || {
    echo "artifact type ownership drift in $writer: $actual_types" >&2
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

stale='concise-output|revolver-review|codebase-exploration|promote-artifact|save-findings|empirical-proof|implement-task|market-research|planning-spec|write-spec|spec-check|split-work|review-output|security-review|fix-flaky-test|git-pr|write-audit|write-bug-report|write-change-plan|write-documentation|write-feature|write-fix|write-inventory|write-migration|write-performance|write-prd|write-refactor|write-research|write-rewrite|write-rfc|write-testing'
if grep -RniE "(^|[^[:alnum:]-])($stale)([^[:alnum:]-]|$)" "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/docs" "$ROOT/skills"; then
  echo "stale current method name" >&2
  exit 1
fi
unreleased=$(sed -n '/^## \[Unreleased\]/,/^## \[/p' "$ROOT/CHANGELOG.md" | sed '$d')
if printf '%s\n' "$unreleased" | grep -Ei "(^|[^[:alnum:]-])($stale)([^[:alnum:]-]|$)"; then
  echo "stale method name in current changelog" >&2
  exit 1
fi
if grep -RniE 'suspec-agents|canonical agent|Codex projection|agents/suspec-' "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/docs" "$ROOT/skills"; then
  echo "retired custom-agent guidance survives" >&2
  exit 1
fi

echo "lint-current: OK"
