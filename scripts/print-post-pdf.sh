#!/usr/bin/env bash
# Print one post to PDF (e.g. for a Zenodo archive) with headless Chrome.
# Usage: scripts/print-post-pdf.sh /blog/pokemon-ai-on-a-macbook/ out.pdf
set -euo pipefail
url_path=${1:?post path, e.g. /blog/pokemon-ai-on-a-macbook/}
out=${2:?output pdf}
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
port=4010
JEKYLL_ENV=development bundle exec jekyll build --quiet
bundle exec jekyll serve --skip-initial-build --no-watch --port "$port" >/dev/null 2>&1 &
server=$!
trap 'kill "$server" 2>/dev/null' EXIT
until curl -fs -o /dev/null "http://localhost:$port$url_path"; do sleep 1; done
"$chrome" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="$out" "http://localhost:$port$url_path" 2>/dev/null
echo "wrote $out"
