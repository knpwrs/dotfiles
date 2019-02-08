# Custom aliases
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias c1='cd -'
alias c2='cd -2'
alias c3='cd -3'
alias c4='cd -4' alias c5='cd -5'
alias c6='cd -6'
alias c7='cd -7'
alias c8='cd -8'
alias c9='cd -9'

cdd() {
  cd $(dirname $1)
}

alias dr="cd ~/Google\ Drive/"
alias dl="cd ~/Downloads/"
alias dt="cd ~/Desktop/"
alias w="cd ~/Workspace/"

duu() {
  du -hd0 $1 | cut -f1
}

alias md='mkdir -p'
function mvd() {
  mkdir $1
  mv $(ls -A | grep -v $1 | grep -v .git) $1
}
alias rd=rmdir
alias rf='rm -rf'
alias d='dirs -v | head -10'
function mkcd() {
  md $1 && cd $1
}

alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias pu='pushd'
alias po='popd'

alias rgi='rg -i'
alias rl='readlink -f'

if  [[ "$OSTYPE" = darwin* ]]; then
  alias show='open -R'
fi

# https://blog.g3rt.nl/upgrade-your-ssh-keys.html
function keygen() {
  if [ -z "$1" ]; then
    echo "Please pass a comment as the first argument."
    return 1
  fi
  ssh-keygen -o -a 100 -t ed25519 -C $1
}
alias KILL='killall -KILL'
alias resume="kill -CONT"

alias hb='HandBrakeCLI'

alias osvg='svgo -i - -o - --pretty --multipass --enable=removeXMLNS'

alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup;'

alias v='nvim'
alias vv='nvim .'
alias vim='nvim'

alias fed='fd -tf | xargs sed -i'

# reload zsh
alias zshr='exec zsh -l'

# stdio encryption and decryption
encrypt() {
  openssl aes-256-cbc
}
decrypt() {
  openssl aes-256-cbc -d
}

# see what is listening on a given port
port() {
  lsof -n -i:$1 | grep LISTEN
}

# open a man page as a pdf
mdf() {
  man -t "${1}" | open -f -a Preview
}

# extract anything
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.7z)       7z e "$1"                                     ;;
      *.tar.bz2)  tar -jxf "$1"                                 ;;
      *.tar.gz)   tar -zxf "$1"                                 ;;
      *.bz2)      bunzip2 "$1"                                  ;;
      *.dmg)      hdiutil mount "$1"                            ;;
      *.gz)       gunzip "$1"                                   ;;
      *.tar)      tar -xf "$1"                                  ;;
      *.tbz2)     tar -jxf "$1"                                 ;;
      *.tgz)      tar -zxf "$1"                                 ;;
      *.zip)      unzip "$1"                                    ;;
      *.ZIP)      unzip "$1"                                    ;;
      *.pax)      cat "$1" | pax -r                             ;;
      *.pax.Z)    uncompress "$1" --stdout | pax -r             ;;
      *.Z)        uncompress "$1"                               ;;
      *) echo "'$1' cannot be extracted/mounted via extract()"  ;;
    esac
  else
    echo "'$1' cannot be extracted/mounted via extract()"
  fi
}

# unbuffer command for copying
unbuf() {
  local prog
  if hash gsed 2>/dev/null; then
    prog='gsed'
  else
    prog='sed'
  fi
  unbuffer $@ | $prog -r "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"
}

# Open DefinitelyTyped
typed() {
  open "https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/$1"
}

# Clear out Neovim Swap
nvcswp() {
  rm -f $HOME/.local/share/nvim/swap/*.swp
}

# Measure time to first byte with CURL
ttfb() {
  curl -o /dev/null \
    -H 'Cache-Control: no-cache' \
    -s \
    -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total: %{time_total} \n" \
    $1
}

# Generate 256-bit secret
alias gensec='openssl rand -base64 32'

# Make aliases available to sudo
alias sudo='sudo '

# pls
alias pls='sudo $(fc -ln -1)'
