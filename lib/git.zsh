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

# Determine to use either the master or main branch
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
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
alias gbc='git branch --contains'
alias gbd='git branch -D'
function gbda() {
  local branches=$(git branch --no-color --merged | grep -v "\*" | grep -v '$(git_main_branch)\|svn\|develop\|release-candidate')
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
alias gbmc='git branch -m $(current_branch)'
alias gbnm='git branch --no-merged'
alias gbpb='current_branch | pbcopy'
alias gbr='git branch --remote'
alias gbsrd='git bisect reset develop'
alias gbsrh='git bisect reset HEAD'
alias gbsrm='git bisect reset $(git_main_branch)'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcnv!='git commit -v --amend --no-verify'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcanv!='git commit -v -a --amend --no-verify'
alias gcan!='git commit -v -a -s --no-edit --amend'
alias gcannv!='git commit -v -a -s --no-edit --amend'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcf='git config --list'
alias gcl='git clone --recursive'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit -m'
alias gcnv='git commit --no-verify'
alias gco='git checkout'
alias gcod='git checkout -- .'
alias gcof='git checkout $(gfirst)'
alias gcoo='git checkout --ours'
alias gcot='git checkout --theirs'
alias gcount='git shortlog -sn'
alias gcw='git checkout work'
compdef gcount=git
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcre='git commit --reedit-message=$1'
alias gcrea='git commit -a --reedit-message$1'
alias gcs='git commit -S'
alias gcz='git cz'
alias gcza='git cz -a'

alias gd='git diff'
alias gde='git diff --name-only | xargs -o $EDITOR -p'
alias gdm='git diff $(git_main_branch)'
alias gds='git diff --staged'
alias gdt='git difftool'
alias gdtr='git diff-tree --no-commit-id --name-only -r'
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gdw='git diff --word-diff'

alias gf='git fetch'
alias gfa='git fetch --all --prune'
function gfg() { git ls-files | grep $@ }
compdef gfg=grep
alias gfirst='git rev-list --max-parents=0 HEAD | tail -n 1'
alias gfo='git fetch origin'
function gfp() {
  git show $(git merge-base --fork-point $1)
}
alias gfpm='gfp $(git_main_branch)'
gfr() {
  [[ "$#" != 1 ]] && local r="origin"
  git fetch --all && git reset --hard "${r:=$1}/$(current_branch)"
}

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggc='git gc --prune=now'
alias ggca='git gc --prune=now --aggressive'
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
compdef _git ggpull=git-checkout
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

alias gha="git rev-parse HEAD | tr -d '\n'"
alias ghapb='git rev-parse HEAD | pbcopy'
alias ghas='git rev-parse HEAD | head -c 7'
alias ghaspb='git rev-parse HEAD | head -c 7 | pbcopy'

function ghcd() {
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
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
compdef git-svn-dcommit-push=git

alias ggk='\gitk --all --branches'
compdef _git gk='gitk'
alias ggke='\gitk --all $(git log -g --pretty=format:%h)'
compdef _git gke='gitk'

alias gl='git pull'
function glcd() {
  git clone $1 && cd $(basename -s .git $1)
}
alias glean='git clean -df'
alias glep='git log --all -i --grep'
alias glg='git log --stat --color'
alias glgp='git log --stat --color -p'
alias glgg='git log --graph --color'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate --color'
alias globber='git reset --hard && git clean -dfx -e "*.ignore.*"'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glof='git log --format=full --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias glone='git clone'
alias glp="_git_log_prettily"
compdef _git glp=git-log
alias glrb="git pull --rebase"
alias glrbd="git pull --rebase origin develop"
alias glrbi="git pull --rebase=interactive"
alias glrbid="git pull --rebase=interactive origin develop"
alias glrbim="git pull --rebase=interactive origin $(git_main_branch)"
alias glrbm="git pull --rebase origin $(git_main_branch)"
alias glu="git pull upstream"
alias glum="git pull upstream $(git_main_branch)"
alias glump="git pull upstream $(git_main_branch) && git push origin $(git_main_branch)"

alias gm='git merge'
alias gma='git merge --abort'
alias gmd='git merge develop'
alias gmm='git merge $(git_main_branch)'
alias gmrc='git merge release-candidate'
alias gmnff='git merge --no-ff'
alias gmnffd='git merge develop --no-ff'
alias gmnffm='git merge $(git_main_branch) --no-ff'
alias gmom='git merge origin/$(git_main_branch)'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gmv='git mv'

alias gp='git push'
alias gpar='git remote | xargs -L1 -I R git push R'
alias gparf='git remote | xargs -L1 -I R git push --force R'
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
alias grbim='git rebase -i $(git_main_branch)'
alias grbiod='git rebase -i origin/develop'
alias grbiom='git rebase -i origin/$(git_main_branch)'
alias grbir='git rebase -i --root'
alias grbm='git rebase $(git_main_branch)'
alias grbm='git rebase $(git_main_branch)'
alias grbs='git rebase --skip'
alias grc='git rerere clear'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grl='git reflog'
alias grmv='git remote rename'
alias groot='cd "$(git rev-parse --show-toplevel)"'
alias grrf='rm -rf .git/rr-cache'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsf='git show $(gfirst)'
alias gsh='git show HEAD'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstc='git stash clear'
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

alias gwa='git log --diff-filter=A --'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -t "$DOTLIB/gwip.template"'

#
# Other git-related aliaes
#
alias dug='du -hd0 $(git rev-parse --git-dir)'

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

#
# FZF
# https://github.com/junegunn/fzf/wiki/examples#git
#

# fbr - checkout git branch, including remote branches, sorted by last commit
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fbrd - delete branches
fbrd() {
  local branches target
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf --no-hscroll --ansi +m -d "\t" -n 2) || return
  git branch -D $(echo "$target" | awk '{print $2}')
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf --query "${@:-""}" --select-1 --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcof - undo unstaged changes to files
alias fcof='git checkout -- $(fzf)'

# fcop(review) - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fcop() {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --query "$@" --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(white)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fcs - get git commit SHA
# example: git rebase -i $(fsha)
fsha() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --query "$@" --select-1 --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fa [FUZZY PATTERN] - Add file to git staging area
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fa() {
  local files
  IFS=$'\n' files=($(git diff --name-only | fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && git add "${files[@]}"
}

# frs [FUZZY PATTERN] - Restore file(s)
frs() {
  local files
  IFS=$'\n' files=($(git diff --name-only | fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && git restore "${files[@]}"
}

# frss [FUZZY PATTERN] - Restore staged file(s)
frss() {
  local files
  IFS=$'\n' files=($(git diff --staged --name-only | fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && git restore --staged "${files[@]}"
}

# Initialize git environment variables for a workspace
genvrc() {
  cat >> .envrc <<EOF
  export GIT_AUTHOR_NAME="$1"
  export GIT_AUTHOR_EMAIL="$2"
  export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
  export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
EOF
}
