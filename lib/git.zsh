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

# Clone a GitHub repo and cd into it: ghcd <user/repo> [dir]
function ghcd() {
  glcd "git@github.com:$1" $2
}

# Clone a GitHub repo: ghone <user/repo> [dir]
function ghone() {
  git clone "git@github.com:$1" ${@:2}
}

alias ginit='git init'

function gicd() {
  git init $1 && cd $1
}

alias gl='git pull'

# Clone a repo and cd into it: glcd <url> [dir]
function glcd() {
  local target=${2:-$(basename -s .git $1)}
  git clone $1 $target && cd $target
}

alias globber='git reset --hard && git clean -dfx -e "*.ignore.*"'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glone='git clone'
alias glrb='git pull --rebase'
alias gm='git merge'
alias gma='git merge --abort'
alias gmnff='git merge --no-ff'
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

alias gct!='gct --amend'
alias gcta!='gct -a --amend'
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

# Forgit-style interactive git functions using fzf and bat
# Uses git switch/restore instead of git checkout

# Interactive git log viewer
flo() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % git show --color=always % | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" \
    --bind "enter:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | bat --style=plain --paging=always')"
}

# Interactive git reflog viewer
frl() {
  git reflog --color=always "$@" |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % git show --color=always % | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" \
    --bind "enter:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | bat --style=plain --paging=always')"
}

# Interactive git diff
fgd() {
  git diff --name-only "$@" |
  fzf --ansi --no-sort --reverse --multi \
    --preview "git diff --color=always $@ -- {} | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up"
}

# Interactive git show
fso() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % git show --color=always % | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" \
    --bind "enter:execute(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | bat --style=plain --paging=always')"
}

# Interactive git add
fa() {
  git -c color.status=always status --short "$@" |
  fzf --ansi --multi --reverse \
    --preview "echo {} | awk '{print \$2}' | xargs git diff --color=always -- | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  awk '{print $2}' |
  xargs -I {} git add {} && git status --short
}

# Interactive git reset HEAD
frh() {
  git diff --cached --name-only |
  fzf --ansi --multi --reverse \
    --preview "git diff --cached --color=always -- {} | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  xargs -I {} git reset HEAD {} && git status --short
}

# Interactive .gitignore generator
fgi() {
  local gitignore_file="${GIT_PREFIX}.gitignore"
  git status --short --untracked-files=all |
  grep '^??' |
  awk '{print $2}' |
  fzf --ansi --multi --reverse \
    --preview "echo {} will be added to .gitignore" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  while read -r file; do
    echo "$file" >> "$gitignore_file"
  done && cat "$gitignore_file"
}

# Interactive .gitattributes generator
fat() {
  local gitattributes_file="${GIT_PREFIX}.gitattributes"
  git ls-files |
  fzf --ansi --multi --reverse \
    --prompt "Select files for .gitattributes: " \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  while read -r file; do
    echo -n "Attribute for $file (e.g., 'text eol=lf'): "
    read -r attr
    echo "$file $attr" >> "$gitattributes_file"
  done && cat "$gitattributes_file"
}

# Interactive git restore (file)
frf() {
  git diff --name-only "$@" |
  fzf --ansi --multi --reverse \
    --preview "git diff --color=always -- {} | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  xargs -I {} git restore {} && git status --short
}

# Interactive git switch (branch)
fsb() {
  local selected
  selected=$(git branch --all |
    grep -v HEAD |
    sed 's/^[* ]*//' |
    sed 's/^  //' |
    fzf --reverse \
      --preview "git log --color=always --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit {}" \
      --bind "ctrl-d:preview-down,ctrl-u:preview-up")

  [ -z "$selected" ] && return

  # Check if it's a remote branch
  if echo "$selected" | grep -q '^remotes/origin/'; then
    local branch_name=$(echo "$selected" | sed 's#^remotes/origin/##')
    # Check if local branch already exists
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
      git switch "$branch_name"
    else
      # Create new local branch tracking the remote
      git switch -c "$branch_name" --track "origin/$branch_name"
    fi
  else
    git switch "$selected"
  fi
}

# Interactive branch delete
fbd() {
  git branch --color=always |
  grep -v '^\*' |
  fzf --ansi --multi --reverse \
    --preview "echo {} | sed 's/^[* ]*//' | xargs git log --color=always --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  sed 's/^[* ]*//' |
  xargs -I {} git branch -D {}
}

# Interactive git switch (tag)
fct() {
  git tag --sort=-version:refname |
  fzf --ansi --reverse \
    --preview "git show --color=always {} | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  xargs git switch --detach
}

# Interactive git switch (commit)
fcc() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  grep -o '[a-f0-9]\{7\}' | head -1 |
  xargs git switch --detach
}

# Interactive git revert
frc() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --multi \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  grep -o '[a-f0-9]\{7\}' |
  xargs git revert
}

# Interactive git clean
fcl() {
  git clean -xdfn |
  sed 's/^Would remove //' |
  fzf --ansi --multi --reverse \
    --preview "[ -f {} ] && bat --style=plain --color=always {} || ls -la {}" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  xargs -I {} git clean -xdf {}
}

# Interactive git stash show
fss() {
  git stash list |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | cut -d: -f1 | xargs git stash show --color=always -p | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" \
    --bind "enter:execute(echo {} | cut -d: -f1 | xargs git stash show --color=always -p | bat --style=plain --paging=always)"
}

# Interactive git stash push
fsp() {
  git status --short --untracked-files=all |
  fzf --ansi --multi --reverse \
    --preview "echo {} | awk '{print \$2}' | xargs git diff --color=always -- | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  awk '{print $2}' |
  xargs git stash push -m "stash: $(date)" --
}

# Interactive git cherry-pick
fcp() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --multi \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  grep -o '[a-f0-9]\{7\}' |
  xargs git cherry-pick
}

# Interactive git rebase
frb() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  grep -o '[a-f0-9]\{7\}' | head -1 |
  xargs git rebase -i
}

# Interactive git blame
fbl() {
  local file="$1"
  if [ -z "$file" ]; then
    file=$(git ls-files | fzf --ansi --reverse --prompt "Select file to blame: ")
  fi
  [ -z "$file" ] && return

  git blame --color-always "$file" |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | awk '{print \$1}' | xargs git show --color=always | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" \
    --bind "enter:execute(echo {} | awk '{print \$1}' | xargs sh -c 'git show --color=always \$0 | bat --style=plain --paging=always')"
}

# Interactive git fixup
ffu() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse \
    --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always | bat --style=plain --color=always" \
    --bind "ctrl-d:preview-down,ctrl-u:preview-up" |
  grep -o '[a-f0-9]\{7\}' | head -1 |
  xargs -I {} git commit --fixup={}
}
