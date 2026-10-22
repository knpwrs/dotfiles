# Mirror portless dev servers into the cmux sidebar. The watcher has to start
# from a cmux terminal to be allowed on its socket; see bin/cmux-portless-status.
if [[ -n "$CMUX_SOCKET_PATH" ]] && (( $+commands[cmux-portless-status] )); then
  cmux-portless-status --ensure &!
fi
