# Custom aliases
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

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

alias ni='npm install'
alias nps='jq .scripts < package.json'
alias nr='npm run'
alias nrb='npm run build'
alias nrc='npm run check'
alias nrd='npm run dev'
alias nrl='npm run lint'
alias ns='npm start'
alias nt='npm test'

alias pu='pushd'
alias po='popd'

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

alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup;'

alias v='nvim'
alias vv='nvim .'
alias vim='nvim'

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

# Make aliases available to sudo
alias sudo='sudo '
