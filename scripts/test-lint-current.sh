#!/bin/sh
set -eu

ROOT=${1:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT HUP INT TERM

copy_repo() {
  target=$1
  mkdir -p "$target"
  for path in README.md AGENTS.md CHANGELOG.md docs skills scripts .github; do
    test ! -e "$ROOT/$path" || cp -R "$ROOT/$path" "$target/$path"
  done
}

rewrite_without() {
  pattern=$1
  file=$2
  awk -v pattern="$pattern" '$0 != pattern { print }' "$file" > "$file.tmp"
  mv "$file.tmp" "$file"
}

expect_failure() {
  mutation=$1
  fixture="$TMP/$mutation"
  copy_repo "$fixture"

  case "$mutation" in
    missing-skill)
      rm -rf "$fixture/skills/bulletproof"
      ;;
    non-markdown-payload)
      : > "$fixture/skills/bulletproof/payload.bin"
      ;;
    escaping-link)
      printf '\n[escape](../demolition/SKILL.md)\n' >> "$fixture/skills/bulletproof/SKILL.md"
      ;;
    artifact-leak)
      printf '\n## Artifact\n\nForbidden.\n' >> "$fixture/skills/campaign/SKILL.md"
      ;;
    missing-frontmatter)
      rewrite_without 'type: spec' "$fixture/skills/sus-spec/SKILL.md"
      ;;
    invalid-description-yaml)
      awk '
        /^description:/ { print "description: Invalid: YAML"; next }
        { print }
      ' "$fixture/skills/fork-me/SKILL.md" > "$fixture/skills/fork-me/SKILL.md.tmp"
      mv "$fixture/skills/fork-me/SKILL.md.tmp" "$fixture/skills/fork-me/SKILL.md"
      ;;
    fenced-chat)
      awk '
        { print }
        $0 == "## Output" { print ""; print "```text"; print "fenced"; print "```" }
      ' "$fixture/skills/dissect/SKILL.md" > "$fixture/skills/dissect/SKILL.md.tmp"
      mv "$fixture/skills/dissect/SKILL.md.tmp" "$fixture/skills/dissect/SKILL.md"
      ;;
    stale-name)
      printf '\nrevolver-review\n' >> "$fixture/README.md"
      ;;
    broken-link)
      printf '\n[broken](./missing.md)\n' >> "$fixture/README.md"
      ;;
    symlink)
      ln -s SKILL.md "$fixture/skills/bulletproof/duplicate.md"
      ;;
    quarantine-drift)
      rewrite_without '`Advocacy exercise, not evidence.`' "$fixture/skills/demolition/SKILL.md"
      ;;
    *)
      echo "unknown mutation: $mutation" >&2
      exit 1
      ;;
  esac

  if sh "$fixture/scripts/lint-current.sh" "$fixture" >/dev/null 2>&1; then
    echo "mutation survived: $mutation" >&2
    exit 1
  fi
}

for mutation in missing-skill non-markdown-payload escaping-link artifact-leak missing-frontmatter \
  invalid-description-yaml fenced-chat stale-name broken-link symlink quarantine-drift; do
  expect_failure "$mutation"
done

echo "test-lint-current: OK"
