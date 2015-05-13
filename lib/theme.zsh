# Based on steeef
# https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_steeef_setup

# Colors
## Use extended color pallete if available.
if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
  turquoise="%F{81}"
  orange="%F{166}"
  purple="%F{135}"
  hotpink="%F{161}"
  limegreen="%F{118}"
else
  turquoise="$fg[cyan]"
  orange="$fg[yellow]"
  purple="$fg[magenta]"
  hotpink="$fg[red]"
  limegreen="$fg[green]"
fi

# Functions
## Working Directory
function get_pwd() {
  echo "${PWD/$HOME/~}"
}
## Git
function git_dirty() {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    # Dirty
    echo "$hotpink●"
  fi
}
function git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
function git_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ($turquoise$(git_branch)$(git_dirty)$reset_color)"
}

# Sets the prompt
function precmd() {
  PROMPT="$purple%n$reset_color at $orange%m$reset_color in $limegreen$(get_pwd)$reset_color$(git_prompt)
%{$reset_color%}$ "
}
