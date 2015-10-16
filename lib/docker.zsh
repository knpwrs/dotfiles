# docker-machine
alias dm="docker-machine"
alias dma="dm active"            # Print which machine is active
alias dmconf="dm config"         # Print the connection config for machine
alias dmc="dm create"            # Create a machine
alias dme="dm env"               # Display the commands to set up the environment for the Docker client
alias dmi="dm inspect"           # Inspect information about a machine
alias dmip="dm ip"               # Get the IP address of a machine
alias dmk="dm kill"              # Kill a machine
alias dml="dm ls"                # List machines
alias dmrc="dm regenerate-certs" # Regenerate TLS Certificates for a machine
alias dmr="dm restart"           # Restart a machine
alias dmrm="dm rm"               # Remove a machine
alias dmssh="dm ssh"             # Log into or run a command on a machine with SSH.
alias dmscp="dm scp"             # Copy files between machines
alias dms="dm start"             # Start a machine
alias dmst="dm status"           # Get the status of a machine
alias dmstop="dm stop"           # Stop a machine
alias dmu="dm upgrade"           # Upgrade a machine to the latest version of Docker
alias dmurl="dm url"             # Get the URL of a machine
alias dmh="dm help"              # Shows a list of commands or help for one command

# Custom
dmee() {
  eval "$(dme $1)"
}
