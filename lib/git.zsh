# Query/use custom command for `git`.
zstyle -s ":vcs_info:git:*:-all-" "command" _local_git_cmd
: ${_local_git_cmd:=git}

function current_branch() {
  git branch --show-current
}

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
alias gm='git merge'
alias gma='git merge --abort'
alias gmt='git mergetool --no-prompt'
alias gmtv='git mergetool --no-prompt --tool=vimdiff'
alias gp='git push'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias groot='cd "$(git rev-parse --show-toplevel)"'
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
alias zap='gaa;gc -m ":zap:";gp'

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

# fsha - get git commit SHA
# example: git rebase -i $(fsha)
fsha() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --query "$@" --select-1 --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# fa [FUZZY PATTERN] - Add file to git staging area (based on forgit::add)
fa() {
  local files preview extract diff_pager
  extract="
        sed 's/^.*]  //' |
        sed 's/.* -> //' |
        sed -e 's/^\\\"//' -e 's/\\\"\$//'"
  diff_pager=$(git config pager.diff || git config core.pager)
  preview="
    file=\$(echo {} | $extract)
    if (git status -s -- \$file | grep '^??') &>/dev/null; then  # diff with /dev/null for untracked files
        git diff --color=always --no-index -- /dev/null \$file | $diff_pager | sed '2 s/added:/untracked:/'
    else
        git diff --color=always -- \$file | $diff_pager
    fi"
  IFS=$'\n' files=($(git diff --name-only | fzf --query="$1" --multi --preview "$preview" --select-1 --exit-0))
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
