# Custom aliases
if type eza > /dev/null; then
  alias ls='eza'
elif ls --color -d . &>/dev/null 2>&1; then
  alias ls='ls --color=tty'
else
  alias ls='ls -G'
fi
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

alias cdd='cd -'
alias cpr="cp -r"

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
alias rr='rm -r'
alias d='dirs -v | head -10'
function mkcd() {
  md $1 && cd $1
}

alias l='ls -lah'
alias la='ls -lah'
alias ll='ls -lh'

superman() {
  man $1 || $1 --help 2>&1 | bat -plhelp
}
alias man=superman

alias pu='pushd'
alias po='popd'

alias rgi='rg -i'
alias rl='readlink -f'

if  [[ "$OSTYPE" = darwin* ]]; then
  alias show='open -R'
fi

alias KILL='killall -KILL'
alias resume="kill -CONT"
# Kill suspended process
alias kz='kill -9 %1'

alias hb='HandBrakeCLI'

alias j='just'

alias osvg='svgo -i - -o - --pretty --multipass --enable=removeXMLNS'

alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup;'

alias v='nvim'
alias vd='vidir'
alias vim='nvim'
alias vims='nvim -S Session.vim'
alias vv='nvim .'
alias tim='nvim +terminal'

alias fed='fd -tf | xargs sed -i'

alias o='open'
alias x='xargs'

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

# kill what is listening on a given port
killport() {
  local pid=$(port $1 | awk '{print $2}')
  if [[ $pid ]]; then
    echo $pid | sort | uniq | xargs -n1 kill -9
  else
    echo "No process found on port ${1}"
  fi
}

alias kp='killport'

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
      *.xz)       unxz "$1"                                     ;;
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

# Measure time to first byte with CURL
ttfb() {
  curl -o /dev/null \
    -H 'Cache-Control: no-cache' \
    -s \
    -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total: %{time_total} \n" \
    $1
}

# Get public IP address
alias ip{4,}='dig @resolver4.opendns.com myip.opendns.com +short -4'
alias ip6='dig @ns1.google.com TXT o-o.myaddr.l.google.com +short -6'

# Pasteboard jq
alias pbjq='pbpaste | jq'

# jo for yaml
yo() {
  jo $@ | yq -P
}

# Explain Previous Command
explain() {
  open https://explainshell.com/explain\?cmd=$(echo $(fc -ln -1) | node -e 'process.stdout.write(encodeURIComponent(require("fs").readFileSync(0, "utf-8")))')
}

unlice() {
  cat << EOF > UNLICENSE
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
EOF
}

# Make aliases available to sudo
alias sudo='sudo '

# pls
alias pls='sudo $(fc -ln -1)'
