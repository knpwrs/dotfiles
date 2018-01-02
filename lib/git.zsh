# Based on oh-my-zsh git plugin
# https://github.com/ncanceill/oh-my-zsh/blob/5b75cc7880de1931a0507800d90eb77ed659fa46/plugins/git/git.plugin.zsh

# Query/use custom command for `git`.
zstyle -s ":vcs_info:git:*:-all-" "command" _local_git_cmd
: ${_local_git_cmd:=git}

#
# Functions
#

# The current branch name
# Usage example: git pull origin $(current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function current_branch() {
  local ref
  ref=$($_local_git_cmd symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$($_local_git_cmd rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
# The list of remotes
function current_repository() {
  if ! $_local_git_cmd rev-parse --is-inside-work-tree &> /dev/null; then
    return
  fi
  echo $($_local_git_cmd remote -v | cut -d':' -f 2)
}
# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
# Warn if the current branch is a WIP
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}

# Aliases
# (sorted alphabetically)
#

alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'

alias gb='git branch'
alias gba='git branch -a'
function gbda() {
  local branches=$(git branch --no-color --merged | grep -v "\*" | grep -v master | grep -v svn)
  if [ "$1" = "-r" ]; then
    # Delete all merged branches (including remote and tracking)
    # Requires git-extras to be installed.
    echo "$branches" | xargs git delete-branch
  else
    # Delete all merged local branches
    echo "$branches" | xargs -n 1 git branch -d
  fi
}
alias gbdaf='gfa && gbda -r'
alias gbdar='gbda -r'
alias gbpa='git fetch -p --all && git branch -vv | grep ":gone]" | cut -d" " -f3 | xargs git branch -D'
alias gbl='git blame -b -w'
alias gbm='git branch -m'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a -s --no-edit --amend'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcf='git config --list'
alias gcl='git clone --recursive'
alias gclean='git reset --hard && git clean -dfx'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcod='git checkout -- .'
alias gcoo='git checkout --ours'
alias gcot='git checkout --theirs'
alias gcount='git shortlog -sn'
alias gcw='git checkout work'
compdef gcount=git
alias gcp='git cherry-pick'
alias gcre='git commit --reedit-message=$1'
alias gcrea='git commit -a --reedit-message$1'
alias gcs='git commit -S'
alias gcz='git cz'
alias gcza='git cz -a'

alias gd='git diff'
alias gdc='git diff --cached'
alias gdm='git diff master'
alias gdt='git difftool'
alias gdtr='git diff-tree --no-commit-id --name-only -r'
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gdw='git diff --word-diff'

alias gf='git fetch'
alias gfa='git fetch --all --prune'
function gfg() { git ls-files | grep $@ }
compdef gfg=grep
alias gfo='git fetch origin'
function gfp() {
  git show $(git merge-base --fork-point $1)
}
alias gfpm='gfp master'

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggc='git gc'
ggf() {
  [[ "$#" != 1 ]] && b="$(current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout
ggl() {
  [[ "$#" != 1 ]] && local b="$(current_branch)"
  git pull origin "${b:=$1}" "${*[2,-1]}"
}
compdef _git ggl=git-checkout
alias ggpull='ggl'
compdef _git ggpull=git-checkout
ggp() {
if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
  git push origin "${*}"
else
  [[ "$#" == 0 ]] && local b="$(current_branch)"
  git push origin "${b:=$1}"
fi
}
compdef _git ggp=git-checkout
alias ggpush='ggp'
compdef _git ggpush=git-checkout
ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout
alias ggsup='git branch --set-upstream-to=origin/$(current_branch)'
ggu() {
  [[ "$#" != 1 ]] && local b="$(current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout
alias ggpur='ggu'
compdef _git ggpur=git-checkout

function ghlcd() {
  glcd "git@github.com:$1"
}
function ghone() {
  git clone "git@github.com:$1"
}

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gim='git imerge'
alias gimc='git imerge continue'
alias gimf='git imerge finish'
alias gimm='git imerge merge'
alias gimr='git imerge rebase'
alias ginit='git init'
function gicd() {
  git init $1 && cd $1
}
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git

alias ggk='\gitk --all --branches'
compdef _git gk='gitk'
alias ggke='\gitk --all $(git log -g --pretty=format:%h)'
compdef _git gke='gitk'

alias gl='git pull'
function glcd() {
  git clone $1 && cd $(basename -s .git $1)
}
alias glg='git log --stat --color'
alias glgp='git log --stat --color -p'
alias glgg='git log --graph --color'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate --color'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glog='git log --oneline --decorate --color --graph'
alias glone='git clone'
alias glp="_git_log_prettily"
compdef _git glp=git-log
alias glrb="git pull --rebase"
alias glrbd="git pull --rebase origin develop"
alias glrbm="git pull --rebase origin master"
alias glu="git pull upstream"
alias glum="git pull upstream master"
alias glump="git pull upstream master && git push origin master"

alias gm='git merge'
alias gma='git merge --abort'
alias gmd='git merge develop'
alias gmm='git merge master'
alias gmmnff='git merge master --no-ff'
alias gmnff='git merge --no-ff'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gmv='git mv'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
compdef _git gpoat=git-push
alias gpt='git push --tags'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbid='git rebase -i develop'
alias grbim='git rebase -i master'
alias grbm='git rebase master'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grmv='git remote rename'
alias groot='cd "$(git rev-parse --show-toplevel)"'
alias grrf='rm -rf .git/rr-cache'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gsu='git submodule update'

alias gts='git tag -s'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "WIP:" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'

alias gvt='git verify-tag'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -t "$DOTLIB/gwip.template"'
