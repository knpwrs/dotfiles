# Query/use custom command for `git`.
zstyle -s ":vcs_info:git:*:-all-" "command" _local_git_cmd
: ${_local_git_cmd:=git}

function current_branch() {
  git branch --show-current
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk kyrios; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
}

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gb='git branch'
alias gbd='git branch -D'
alias gbm='git branch -m'
alias gbsrm='git bisect reset $(git_main_branch)'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcanv!='git commit -v -a --amend --no-verify'
alias gcan!='git commit -v -a -s --no-edit --amend'
alias gcannv!='git commit -v -a -s --no-edit --amend'
alias gcb='git checkout -b'
alias gcbb='git checkout -'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
alias gcod='git checkout -- .'
alias gcoo='git checkout -'
alias gcount='git shortlog -sn'
compdef gcount=git
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'
alias gfa='git fetch --all --prune'
alias gfr='git fetch --all && git reset --hard @{upstream}'
ggf() {
  [[ "$#" != 1 ]] && b="$(current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggf=git-checkout
ggf!() {
  [[ "$#" != 1 ]] && b="$(current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf!=git-checkout
ggl() {
  [[ "$#" != 1 ]] && local b="$(current_branch)"
  git pull origin "${b:=$1}" "${*[2,-1]}"
}
compdef _git ggl=git-checkout
alias ggpull='ggl'
ggp() {
if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
  git push -u origin "${*}"
else
  [[ "$#" == 0 ]] && local b="$(current_branch)"
  git push -u origin "${b:=$1}"
fi
}
compdef _git ggp=git-checkout
alias ggpush='ggp'
compdef _git ggpush=git-checkout
function ghcd() {
  glcd "git@github.com:$1"
}
function ghone() {
  git clone "git@github.com:$1"
}
alias ginit='git init'
function gicd() {
  git init $1 && cd $1
}
alias gl='git pull'
function glcd() {
  git clone $1 && cd $(basename -s .git $1)
}
alias globber='git reset --hard && git clean -dfx -e "*.ignore.*"'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glone='git clone'
alias glrb='git pull --rebase'
alias gm='git merge'
alias gma='git merge --abort'
alias gmt='git mergetool --no-prompt'
alias gmtv='git mergetool --no-prompt --tool=vimdiff'
alias gp='git push'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias groot='cd "$(git rev-parse --show-toplevel)"'
alias gsh='git show @'
alias gst='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gunwip='git log -n 1 | grep -q -c "WIP:" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -t "$DOTLIB/gwip.template"'
alias lg='lazygit'
alias zap='gc -am ":zap:";gp'

# Extract ticket number from branch name (e.g., OSC-11584 from ken/osc-11584-description)
function git_ticket() {
  local branch=$(current_branch)
  echo $branch | grep -ioE '[A-Z]+-[0-9]+' | head -1 | tr '[:lower:]' '[:upper:]'
}

# Commit with ticket number prefix
function gct() {
  local ticket=$(git_ticket)
  if [[ -n "$ticket" ]]; then
    git commit -v -e -m "${ticket}: " "$@"
  else
    echo "No ticket found in branch name"
    return 1
  fi
}

alias gcta='gct -a'

# Count lines of code in a git repository
# Requires tokei crate to be installed
gloc() {
  tmp=$(mktemp -u)
  git clone --depth 1 $1 $tmp
  tokei --sort code $tmp
  rm -rf $tmp
}
# Count lines of code in a github repository
ghoc() {
  gloc https://github.com/$1
}
