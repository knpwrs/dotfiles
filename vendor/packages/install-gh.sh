#!/usr/bin/env zsh

hash gh 2>/dev/null || { echo "Please install gh before installing gh extensions." && exit 0; }

extensions=(
  davidraviv/gh-clean-branches # Safely delete local branches that have no remotes and no hanging changes.
  dlvhdr/gh-prs                # CLI PR Dashboard
)

echo "${extensions[@]///}" | xargs -n1 gh extension install
