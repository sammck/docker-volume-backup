#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_DIR/build"
FANDOM_WIKI_GIT_DIR="$BUILD_DIR/fandom-wiki/fandom-wiki"
FANDOM_WIKI_VENV_DIR="$BUILD_DIR/fandom-wiki/.venv"

if [ ! -d "$FANDOM_WIKI_GIT_DIR"  -o ! -d "$FANDOM_WIKI_VENV_DIR" ]; then
  echo "Building fandom-wiki tool first..." >&2
  "$SCRIPT_DIR/build-fandom-wiki.sh"
fi

source "$FANDOM_WIKI_VENV_DIR/bin/activate"
EXIT_CODE=0
"$FANDOM_WIKI_GIT_DIR/scripts/download_fandom_data.sh" "$@" || EXIT_CODE=$?
exit $EXIT_CODE
