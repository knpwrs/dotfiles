if type navi > /dev/null; then
  eval "$(navi widget zsh)"
  export NAVI_FZF_OVERRIDES_VAR='--no-exact'
fi
