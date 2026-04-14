if type navi > /dev/null; then
  export NAVI_FZF_OVERRIDES_VAR='--no-exact'
  if [[ -z "$ZELLIJ" ]]; then
    eval "$(navi widget zsh)"
    bindkey '^ ' _navi_widget
    bindkey -r '^g'
  fi
fi
