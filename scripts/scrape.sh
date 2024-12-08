#!/usr/bin/env bash

set -eo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
DATA_DIR="$PROJECT_DIR/data"

URLS_FILE="$1"
if [ -z "$URLS_FILE" ]; then
  URLS_FILE="$SCRIPT_DIR/factory_town_urls.txt"
fi

SCRAPED_DIR="$2"
if [ -z "$SCRAPED_DIR" ]; then
  SCRAPED_DIR="$DATA_DIR/scraped"
fi

mkdir -p "$SCRAPED_DIR"
"$SCRIPT_DIR/download_fandom_data.sh" -od "$SCRAPED_DIR" < "$URLS_FILE" >/dev/null
