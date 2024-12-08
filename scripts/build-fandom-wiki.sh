#!/usr/bin/env bash

set -eo pipefail

FANDOM_WIKI_REPO="git@github.com:GOLEM-lab/fandom-wiki.git"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_DIR/build"
FANDOM_WIKI_GIT_DIR="$BUILD_DIR/fandom-wiki/fandom-wiki"
FANDOM_WIKI_VENV_DIR="$BUILD_DIR/fandom-wiki/.venv"
FWPIP="$FANDOM_WIKI_VENV_DIR/bin/pip"
FWPYTHON="$FANDOM_WIKI_VENV_DIR/bin/python"

cd $PROJECT_DIR

mkdir -p build/fandom-wiki
cd build/fandom-wiki
if [ -d "fandom-wiki" ]; then
  cd fandom-wiki
  git reset --hard
  git clean -dxf
  git checkout main
  git pull
else
  git clone "$FANDOM_WIKI_REPO" ./fandom-wiki
  cd fandom-wiki
fi

if [ -d "$FANDOM_WIKI_VENV_DIR" ]; then
  echo "Virtual environment already exists; not recreating" >&2
else
  python3.9 -m venv "$FANDOM_WIKI_VENV_DIR"
fi
#source "$FANDOM_WIKI_VENV_DIR/bin/activate"
"$FWPIP" install --upgrade pip
"$FWPIP" install -r requirements.txt

echo "fandom-wiki build complete" >&2
