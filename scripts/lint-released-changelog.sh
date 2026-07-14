#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
file="$ROOT/CHANGELOG.md"
expected=bb28151be77b84872076b94b7c9f47470b5f66be47e1d1db749650c3a468c1cd
base=${SUSPEC_SKILLS_HISTORY_BASE:-}

case "$base" in
  ''|0000000000000000000000000000000000000000) ;;
  *)
    git -C "$ROOT" cat-file -e "$base^{commit}" 2>/dev/null || {
      echo "released changelog history base is unavailable: $base" >&2
      exit 1
    }
    base_commit=$(git -C "$ROOT" rev-parse "$base^{commit}")
    first=$(git -C "$ROOT" show "${base_commit}:CHANGELOG.md" | awk '/^## \[[0-9]/{ print; exit }')
    test -n "$first" || {
      echo "history base has no released changelog section" >&2
      exit 1
    }
    base_digest=$(git -C "$ROOT" show "${base_commit}:CHANGELOG.md" |
      awk -v first="$first" '$0 == first { found = 1 } found' |
      shasum -a 256 | awk '{print $1}')
    current_digest=$(awk -v first="$first" '$0 == first { found = 1 } found' "$file" |
      shasum -a 256 | awk '{print $1}')
    test "$current_digest" = "$base_digest" || {
      echo "released changelog history changed since $base" >&2
      exit 1
    }
    ;;
esac

grep -q '^## \[[0-9]' "$file" || {
  echo "released changelog sections missing" >&2
  exit 1
}

actual=$(sed -n '/^## \[[0-9]/,$p' "$file" | shasum -a 256 | awk '{print $1}')
test "$actual" = "$expected" || {
  echo "released changelog history drift" >&2
  exit 1
}

echo "lint-released-changelog: OK"
