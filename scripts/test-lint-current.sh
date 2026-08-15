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
    appendix-payload)
      mkdir -p "$fixture/skills/bulletproof/references"
      printf 'hidden control\n' > "$fixture/skills/bulletproof/references/control.md"
      ;;
    escaping-link)
      printf '\n[escape](../demolition/SKILL.md)\n' >> "$fixture/skills/bulletproof/SKILL.md"
      ;;
    artifact-leak)
      printf '\n## Artifact\n\nForbidden.\n' >> "$fixture/skills/bulletproof/SKILL.md"
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
    handoff-drift)
      sed 's/clickable Markdown links/clickable paths/' "$fixture/skills/sus-spec/SKILL.md" \
        > "$fixture/skills/sus-spec/SKILL.md.tmp"
      mv "$fixture/skills/sus-spec/SKILL.md.tmp" "$fixture/skills/sus-spec/SKILL.md"
      ;;
    evidence-economy-drift)
      sed 's/smallest untouched decisive output excerpt/untouched decisive output/' \
        "$fixture/skills/revolver/SKILL.md" > "$fixture/skills/revolver/SKILL.md.tmp"
      mv "$fixture/skills/revolver/SKILL.md.tmp" "$fixture/skills/revolver/SKILL.md"
      ;;
    source-reference-drift)
      rewrite_without \
        'Write local source references relative to the artifact. Use absolute paths only for runtime handoff.' \
        "$fixture/skills/sus-audit/SKILL.md"
      ;;
    source-reference-example-drift)
      sed 's|../../path/to/source.md|/absolute/path/to/source.md|' \
        "$fixture/skills/sus-spec/SKILL.md" > "$fixture/skills/sus-spec/SKILL.md.tmp"
      mv "$fixture/skills/sus-spec/SKILL.md.tmp" "$fixture/skills/sus-spec/SKILL.md"
      ;;
    source-reference-quoted-drift)
      sed 's|../../path/to/source.md|"/absolute/path/to/source.md"|' \
        "$fixture/skills/sus-spec/SKILL.md" > "$fixture/skills/sus-spec/SKILL.md.tmp"
      mv "$fixture/skills/sus-spec/SKILL.md.tmp" "$fixture/skills/sus-spec/SKILL.md"
      ;;
    source-reference-inline-drift)
      printf '\n```yaml\nsources: ["/absolute/path/to/source.md"]\n```\n' \
        >> "$fixture/skills/sus-spec/SKILL.md"
      ;;
    campaign-local-proof-drift)
      sed '/Hosted status checks are optional;/d' \
        "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" \
        "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-authority-drift)
      sed '/cannot accept its own work\./d' \
        "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" \
        "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-operation-scope-drift)
      sed 's/Map only operations the campaign will use:/Map every possible operation:/' \
        "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" \
        "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-capability-class-drift)
      sed 's/\*\*Deterministic local:\*\*/\*\*Advisory:\*\*/' \
        "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" \
        "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-bootstrap-drift)
      sed '/trusted owner may bootstrap a missing control/d' \
        "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" \
        "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-human-merge-drift)
      sed 's/The owner may delegate merge execution/The owner may not delegate merge execution/' \
        "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" \
        "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-human-ownership-drift)
      sed 's/Humans own/Humans review/' "$fixture/skills/sus-campaign/SKILL.md" \
        > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" "$fixture/skills/sus-campaign/SKILL.md"
      ;;
    campaign-model-routing-drift)
      sed 's/Choose reviewers from the criticality of their stance\./Choose reviewers by availability./' \
        "$fixture/skills/sus-campaign/SKILL.md" > "$fixture/skills/sus-campaign/SKILL.md.tmp"
      mv "$fixture/skills/sus-campaign/SKILL.md.tmp" "$fixture/skills/sus-campaign/SKILL.md"
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

sh "$ROOT/scripts/lint-current.sh" "$ROOT" >/dev/null

for mutation in missing-skill non-markdown-payload appendix-payload escaping-link artifact-leak missing-frontmatter \
  invalid-description-yaml fenced-chat stale-name broken-link symlink quarantine-drift handoff-drift \
  evidence-economy-drift source-reference-drift source-reference-example-drift \
  source-reference-quoted-drift source-reference-inline-drift \
  campaign-local-proof-drift campaign-authority-drift campaign-operation-scope-drift \
  campaign-capability-class-drift campaign-bootstrap-drift \
  campaign-human-merge-drift campaign-human-ownership-drift campaign-model-routing-drift; do
  expect_failure "$mutation"
done

echo "test-lint-current: OK"
