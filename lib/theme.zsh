# Originally based on steeef
# https://github.com/sorin-ionescu/prezto/blob/master/modules/prompt/functions/prompt_steeef_setup

# Functions
## Working Directory
function get_pwd() {
  echo "${PWD/$HOME/~}"
}
## Git
function git_dirty() {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    # Dirty
    echo "$fg_bold[red]●"
  fi
}
function git_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
function git_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ($fg_bold[cyan]$(git_branch)$(git_dirty)$reset_color)"
}

# Sets the prompt
function precmd() {
    PROMPT="$fg_bold[red]%n$reset_color at $fg_bold[yellow]%m$reset_color in $fg_bold[green]$(get_pwd)$reset_color$(git_prompt)
%{$reset_color$fg_bold[white]%}❯ "
}
