#!/usr/bin/env bash
# Applies .github/rulesets/master-protection.json to the default branch.
# Rulesets need a PUBLIC repository on GitHub Free (private repos need Pro):
# run this right after making the repository public.
set -euo pipefail
repo="${1:-johnny5550822/johnny5550822.github.io}"
file="$(dirname "$0")/../.github/rulesets/master-protection.json"
existing=$(gh api "repos/$repo/rulesets" --jq '.[] | select(.name=="master protection") | .id' || true)
if [ -n "$existing" ]; then
  gh api -X PUT "repos/$repo/rulesets/$existing" --input "$file" --jq '"updated ruleset \(.id): \(.enforcement)"'
else
  gh api -X POST "repos/$repo/rulesets" --input "$file" --jq '"created ruleset \(.id): \(.enforcement)"'
fi
gh api "repos/$repo/rules/branches/master" --jq '.[].type'
