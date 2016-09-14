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
alias rd=rmdir
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

if  [[ "$OSTYPE" = darwin* ]]; then
  alias show='open -R'
fi

alias KILL='killall -KILL'

alias hb='HandBrakeCLI'

alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup;'

alias v='nvim'
alias vv='nvim .'
alias vim='nvim'

# stdio encryption and decryption
encrypt() {
  openssl aes-256-cbc
}
decrypt() {
  openssl aes-256-cbc -d
}

# Make aliases available to sudo
alias sudo='sudo '
