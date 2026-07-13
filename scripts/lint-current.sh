#!/bin/sh
set -eu

ROOT=${1:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
ROOT=$(CDPATH= cd -- "$ROOT" && pwd)

expected='bulletproof
demolition
disrespec
dissect
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

choice_protocol_skills='promote sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task'
artifact_creators='bulletproof demolition sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task triple-check'
artifact_handlers='bulletproof demolition disrespec sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task triple-check'

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

  case " $choice_protocol_skills " in
    *" $name "*)
      require_regex "$file" 'native picker' "choice protocol lacks native picker"
      require_regex "$file" 'recommendation first' "choice protocol lacks recommendation order"
      require_regex "$file" 'three genuine options.*two when binary' "choice protocol lacks option counts"
      require_regex "$file" 'one-sentence tradeoffs' "choice protocol lacks tradeoffs"
      require_regex "$file" 'automatic `Other`' "choice protocol lacks Other"
      require_regex "$file" 'Without a native picker' "choice protocol lacks fallback"
      require_regex "$file" 'Never ask a bare question' "choice protocol permits bare questions"
      require_regex "$file" 'Batch only independent choices' "choice protocol lacks dependency order"
      ;;
    *)
      if grep -Fq 'Every material choice uses the native picker:' "$file"; then
        echo "irrelevant generic choice protocol in $name" >&2
        exit 1
      fi
      ;;
  esac

  case " $artifact_creators " in
    *" $name "*)
      grep -Fq '~/.agents/artifacts/<workspace>/' "$file" || { echo "neutral root missing in $name" >&2; exit 1; }
      for word in absolute repository vendor temporary overwrite collision; do
        require_regex "$file" "$word" "incomplete artifact placement in $name"
      done
      require_regex "$file" '(unwritable|blocked writes?)' "incomplete blocked-write handling in $name"
      ;;
  esac

  case " $artifact_handlers " in
    *" $name "*)
      for word in Delete Leave Promote sidecar 'final consumer' 'non-empty transient artifact set' \
        'no earlier disposition prompt' 'no downstream step' 'created or consumed by the active work'; do
        require_regex "$file" "$word" "incomplete lifecycle disposition in $name"
      done
      require_regex "$file" 'durable (documents|inputs).*never enter disposition' "durable input may enter disposition in $name"
      require_regex "$file" '(Never choose|do not choose|human chooses)' "agent may choose disposition in $name"
      ;;
  esac
done

writer_types='bulletproof:inspection demolition:inspection triple-check:inspection sus-spec:spec sus-task:task sus-review:review sus-inventory:inventory sus-change-plan:change-plan sus-audit:audit sus-research:research'
for pair in $writer_types; do
  writer=${pair%%:*}
  expected_type=${pair#*:}
  actual_types=$(declaration_values "$ROOT/skills/$writer" type)
  test "$actual_types" = "$expected_type" || {
    echo "artifact type ownership drift in $writer: $actual_types" >&2
    exit 1
  }
done

for method in bulletproof demolition triple-check; do
  actual_methods=$(declaration_values "$ROOT/skills/$method" method)
  test "$actual_methods" = "$method" || { echo "inspection method drift in $method: $actual_methods" >&2; exit 1; }
done

revolver="$ROOT/skills/revolver/SKILL.md"
require_regex "$revolver" 'Create no artifact or sidecar' 'Revolver may persist output'
require_regex "$revolver" 'at least six materially distinct stances' 'Revolver stance floor missing'
require_regex "$revolver" 'one fresh, read-only reviewer at a time' 'Revolver reviewer sequence missing'
require_regex "$revolver" '(Adjudicate|address).*finding.*before.*next reviewer' 'Revolver resolution order missing'
require_regex "$revolver" 'full (pool|rotation).*mandatory|complete rotation is mandatory' 'Revolver full rotation missing'
require_regex "$revolver" 'quiet rotation.*three cycles|three cycles.*quiet rotation' 'Revolver stop bounds missing'
require_regex "$revolver" '(unverified|blocked).*report the blocker and stop' 'Revolver blocker stop missing'
test -z "$(declaration_values "$ROOT/skills/revolver" type)" || { echo "Revolver owns an artifact type" >&2; exit 1; }

triple="$ROOT/skills/triple-check/SKILL.md"
require_regex "$triple" 'exactly three materially distinct stances' 'Triple-check pass count missing'
require_regex "$triple" 'top-tier model' 'Triple-check model tier missing'
require_regex "$triple" 'fixed read-only snapshot|hold the snapshot fixed' 'Triple-check fixed snapshot missing'
require_regex "$triple" 'refine only when explicitly requested|Use `refine` only on explicit request' 'Triple-check refine boundary missing'
require_regex "$triple" 'hide all peer reports|no peer report' 'Triple-check independence missing'

bulletproof="$ROOT/skills/bulletproof/SKILL.md"
require_regex "$bulletproof" 'Verification:' 'Bulletproof verification mode missing'
require_regex "$bulletproof" 'Implementation proof:' 'Bulletproof implementation-proof mode missing'
require_regex "$bulletproof" 'Never edit the target|Neither mode edits the target' 'Bulletproof may edit target'
require_regex "$bulletproof" 'Supported.*Unsupported.*Unverified.*Blocked' 'Bulletproof assessments missing'

demolition="$ROOT/skills/demolition/SKILL.md"
grep -Fq 'Advocacy exercise, not evidence.' "$demolition" || { echo "Demolition quarantine banner missing" >&2; exit 1; }
require_regex "$demolition" 'Explicit invocation only' 'Demolition activation boundary missing'
require_regex "$demolition" 'Never invent evidence-shaped material' 'Demolition fabrication boundary missing'

dissect="$ROOT/skills/dissect/SKILL.md"
require_regex "$dissect" 'Stay read-only' 'Dissect mutation boundary missing'
require_regex "$dissect" 'Return the smallest map' 'Dissect bounded return missing'

disrespec="$ROOT/skills/disrespec/SKILL.md"
require_regex "$disrespec" 'Edit only an artifact path supplied' 'Disrespec target boundary missing'
require_regex "$disrespec" 'Never author, place, or relocate' 'Disrespec may create artifacts'
require_regex "$disrespec" 'Never create a sidecar' 'Disrespec may create sidecars'

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
