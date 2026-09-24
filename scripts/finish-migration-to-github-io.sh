#!/usr/bin/env bash
# Publica el portafolio en adriantaf/adriantaf.github.io desde la rama preparada.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BRANCH_SRC="${BRANCH_SRC:-cursor/github-io-content-d2c9}"
BRANCH_DST="${BRANCH_DST:-cursor/migrate-portfolio-root-d2c9}"
GHIO_REPO="${GHIO_REPO:-https://github.com/adriantaf/adriantaf.github.io.git}"

cd "$REPO_ROOT"
git fetch origin "$BRANCH_SRC"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
git clone --branch "$BRANCH_SRC" --single-branch "$(git remote get-url origin)" "$TMP/src"
cd "$TMP/src"
git push "$GHIO_REPO" "HEAD:refs/heads/$BRANCH_DST"

echo "Listo. Abre un PR en adriantaf.github.io desde la rama $BRANCH_DST y haz merge a main."
echo "Tras el deploy de Actions, el sitio quedará en https://adriantaf.github.io/"
