#!/usr/bin/env zsh

#
# You will need the `jq` and `fzf` commands installed in order for these
# functions to work:
#
#   - https://stedolan.github.io/jq/
#   - https://github.com/junegunn/fzf
#
# You will also need to define $JIRA_TEAM, $JIRA_USER, and $JIRA_TOKEN
# environment variables. See the following for information on setting
# machine-private environment variables:
#
#   - https://github.com/knpwrs/dotfiles#private-environment-variables
#
# See the following for information on creating a JIRA access token:
#
#  - https://confluence.atlassian.com/cloud/api-tokens-938839638.html ( https://archive.is/vjoEZ )
#

function jql() {
  curl "https://$JIRA_TEAM.atlassian.net/rest/api/2/search?jql=$1&maxResults=100&startAt=$(($2 * 100))" \
    -s -u "$JIRA_USER:$JIRA_TOKEN" \
    |  jq -r '.issues[] | "\(.key): \(.fields.summary)"'
}

function fjql() {
  ticket=$({for ((req=0;req<5;req++)); do
    jql $1 $req &
  done} | fzf --no-hscroll +m | cut -d ':' -f 1)

  [ ${#ticket} -gt 0 ] && open "https://$JIRA_TEAM.atlassian.net/browse/$ticket"
}

alias fj="fjql 'order%20by%20updated%20DESC'"
alias fjm="fjql 'assignee%20%3D%20currentUser()%20AND%20resolution%20%3D%20Unresolved%20order%20by%20updated%20DESC'"
