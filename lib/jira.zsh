#!/usr/bin/env zsh

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
