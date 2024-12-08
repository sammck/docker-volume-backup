#!/usr/bin/env bash

# Extracts wikitext from a Fandom page
# Usage: extract_wikitext.sh [<option>...] [URL]
# If URL is not provided, extracts wikitext from stdin, which should contain the HTML of a Fandom "edit" page
#  (e.g. https://factorytown.fandom.com/wiki/Buildings?action=edit)
# Options:
#  -h, --help: Display this help message


set -eo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_DIR/build"
FANDOM_WIKI_GIT_DIR="$BUILD_DIR/fandom-wiki/fandom-wiki"
FANDOM_WIKI_VENV_DIR="$BUILD_DIR/fandom-wiki/.venv"
PYTHON="$FANDOM_WIKI_VENV_DIR/bin/python"
FANDOM_EXTRACT="${FANDOM_WIKI_GIT_DIR}/src/fandom_extraction/fandom_extract.py"

POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -od|-output_dir|--output_dir)
      OUT_DIR="$2"
      shift
      shift
      ;;
    -h|--help)
      echo "extract_wikitext.sh - extracts wikitext from a Fandom page" >&2
      echo >&2
      echo "Usage: extract_wikitext.sh [<option>...] [URL]" >&2
      echo "If URL is not provided, extracts wikitext from stdin, which should contain the HTML of a Fandom \"edit\" page" >&2
      echo " (e.g. https://factorytown.fandom.com/wiki/Buildings?action=edit)." >&2
      echo "If URL does not begin with \"http\", then https://factorytown.fandom.com/wiki/ is prepended." >&2
      echo >&2
      echo "Options:" >&2
      echo " -h, --help: Display this help message" >&2
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1" >&2
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

URL=""

if [ $# -gt 0 ]; then
  URL="$1"
  shift
fi

# must be no more arguments
if [ $# -gt 0 ]; then
  echo "Too many arguments" >&2
  exit 1
fi

if [ ! -d "$FANDOM_WIKI_GIT_DIR"  -o ! -d "$FANDOM_WIKI_VENV_DIR" ]; then
  echo "Building fandom-wiki tool first..." >&2
  "$SCRIPT_DIR/build-fandom-wiki.sh"
fi

source "$FANDOM_WIKI_VENV_DIR/bin/activate"
EXIT_CODE=0
if [ -n "$URL" ]; then
  DLURL="$URL"
  [[ "$DLURL" = "http"* ]] || DLURL="https://factorytown.fandom.com/wiki/$DLURL"
  [[ "$DLURL" = *"?action=edit" ]] || DLURL="$DLURL?action=edit"
  curl "$DLURL" 2>/dev/null | "$PYTHON" "$FANDOM_EXTRACT" 2>/dev/null || EXIT_CODE=$?
else
  "$PYTHON" "$FANDOM_EXTRACT" 2>/dev/null || EXIT_CODE=$?
fi
exit $EXIT_CODE
