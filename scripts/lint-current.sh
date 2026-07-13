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
choice_protocol_skills='promote sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task'
actual=$(find "$ROOT/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
test "$actual" = "$expected" || {
  echo "skill topology drift" >&2
  printf 'expected:\n%s\nactual:\n%s\n' "$expected" "$actual" >&2
  exit 1
}

if find "$ROOT/skills" -type f ! -name '*.md' | grep -q .; then
  echo "installed skill payload contains a non-Markdown file" >&2
  exit 1
fi

relative_links() {
  grep -oE ']\((\.\.?/)[^)]*\)' | sed -E 's/^]\((.*)\)$/\1/' | sed -E 's/[?#].*$//'
}

current_markdown=$(
  printf '%s\n' "$ROOT/README.md" "$ROOT/AGENTS.md"
  find "$ROOT/docs" "$ROOT/skills" -type f -name '*.md' -print
)
printf '%s\n' "$current_markdown" | while IFS= read -r document; do
  document_dir=$(dirname "$document")
  relative_links < "$document" | while IFS= read -r ref; do
    [ -z "$ref" ] || test -e "$document_dir/$ref" || {
      echo "broken relative link: $document -> $ref" >&2
      exit 1
    }
  done
done

for file in "$ROOT"/skills/*/SKILL.md; do
  folder=$(dirname "$file")
  name=$(basename "$folder")
  frontmatter_name=$(sed -n 's/^name: //p' "$file" | head -1)
  test "$frontmatter_name" = "$name" || {
    echo "folder/name drift: $name != $frontmatter_name" >&2
    exit 1
  }
  grep -q '^description:' "$file" || { echo "missing description: $name" >&2; exit 1; }
  grep -Fq "\`$name\`" "$ROOT/README.md" || { echo "catalog omits skill: $name" >&2; exit 1; }

  find "$folder" -type f -name '*.md' -print | while IFS= read -r document; do
    if grep -nE 'DISRESPEC-SPINE|SPINE-(START|END)|ADR-[0-9]+|this catalog|sibling skill|if installed|catalog topology' "$document"; then
      echo "internal or external dependency vocabulary in $name: $document" >&2
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
    protocol='Investigate discoverable facts before asking. Every material choice uses the native picker: recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs, and automatic `Other`. Without a native picker, render the same numbered options plus `Other`. Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.'
    flattened=$(tr '\n' ' ' < "$file")
    printf '%s\n' "$flattened" | grep -Fq "$protocol" || {
      echo "complete choice protocol missing in $name" >&2
      exit 1
    }
    ;;
    *)
      if grep -Fq 'Every material choice uses the native picker:' "$file"; then
        echo "irrelevant global choice protocol in $name" >&2
        exit 1
      fi
      ;;
  esac
done

artifact_creators='bulletproof demolition sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task triple-check'
artifact_handlers='bulletproof demolition disrespec sus-audit sus-change-plan sus-inventory sus-research sus-review sus-spec sus-task triple-check'
for name in $artifact_creators; do
  file="$ROOT/skills/$name/SKILL.md"
  grep -Fq '~/.agents/artifacts/<workspace>/' "$file" || {
    echo "neutral artifact root missing in $name" >&2
    exit 1
  }
done
for name in $artifact_handlers; do
  file="$ROOT/skills/$name/SKILL.md"
  flattened=$(tr '\n' ' ' < "$file")
  for term in delete leave promote sidecar; do
    grep -qi "$term" "$file" || { echo "incomplete disposition rule in $name: $term" >&2; exit 1; }
  done
  printf '%s\n' "$flattened" | grep -Fqi 'At true lifecycle close, skip the path-only handoff and issue the disposition choice instead.' || {
    echo "lifecycle-close handoff missing in $name" >&2
    exit 1
  }
done

for method in triple-check; do
  method_text=$(tr '\n' ' ' < "$ROOT/skills/$method/SKILL.md" | tr -s ' ')
  for phrase in 'A substantive run requires that artifact.' \
    'An explicit no-write or chat-only request conflicts with this method.' \
    'Never write against the refusal'; do
    printf '%s\n' "$method_text" | grep -Fq "$phrase" || {
      echo "$method no-write conflict missing: $phrase" >&2
      exit 1
    }
  done
done
revolver_text=$(tr '\n' ' ' < "$ROOT/skills/revolver/SKILL.md" | tr -s ' ')
for phrase in 'Create no artifact or sidecar.' 'at least six materially distinct stances' \
  'Adjudicate every finding before dispatching the next reviewer' \
  'Never carry an unresolved material finding into the next stance.' \
  'One complete rotation is mandatory.'; do
  printf '%s\n' "$revolver_text" | grep -Fq "$phrase" || {
    echo "revolver sequential-resolution contract missing: $phrase" >&2
    exit 1
  }
done
grep -Fq 'Skip targeted code-path tracing without an explicit three-pass request.' \
  "$ROOT/skills/triple-check/SKILL.md" || {
  echo "triple-check overlaps targeted dissection" >&2
  exit 1
}
for phrase in 'is already the independent reviewer: execute here and do not dispatch again.' \
  'Any Blocked row: Request changes or Defer. Never offer either acceptance option.' \
  'Never offer plain Accept.' 'Keep this as one contiguous GFM table:'; do
  grep -Fq "$phrase" "$ROOT/skills/sus-review/SKILL.md" || {
    echo "sus-review state or fallback contract missing: $phrase" >&2
    exit 1
  }
done

stale='concise-output|revolver-review|codebase-exploration|promote-artifact|save-findings|empirical-proof|implement-task|market-research|planning-spec|write-spec|spec-check|split-work|review-output|security-review|fix-flaky-test|git-pr|write-audit|write-bug-report|write-change-plan|write-documentation|write-feature|write-fix|write-inventory|write-migration|write-performance|write-prd|write-refactor|write-research|write-rewrite|write-rfc|write-testing'
if grep -RniE "(^|[^[:alnum:]-])($stale)([^[:alnum:]-]|$)" \
  "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/docs" "$ROOT/skills"; then
  echo "stale current method name" >&2
  exit 1
fi
unreleased=$(sed -n '/^## \[Unreleased\]/,/^## \[/p' "$ROOT/CHANGELOG.md" | sed '$d')
if printf '%s\n' "$unreleased" | grep -Ei "(^|[^[:alnum:]-])($stale)([^[:alnum:]-]|$)"; then
  echo "stale method name in current changelog" >&2
  exit 1
fi
if grep -RniE 'suspec-agents|canonical agent|Codex projection|agents/suspec-' \
  "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/docs" "$ROOT/skills"; then
  echo "retired custom-agent guidance survives" >&2
  exit 1
fi

echo "lint-current: OK"
