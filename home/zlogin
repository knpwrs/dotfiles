# Executes commands at login post-zshrc.
# Based on https://github.com/sorin-ionescu/prezto/blob/6f9c1666e1a34258cfcb7fccb4c7973cdb4127d9/runcoms/zlogin

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!
