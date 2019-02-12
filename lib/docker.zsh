# general
alias drun='docker run -it --rm -v $(pwd):/host -w /host'
alias deit='docker exec -it'

# docker-compose
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dce="docker-compose exec"
dcl() {
  docker logs -f $(dc ps -q $1)
}
alias dck="docker-compose kill"
alias dcrf="docker-compose rm -f"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr="docker-compose run --rm"
alias dcrs="docker-compose restart"

# docker-machine
alias dm="docker-machine"
alias dma="docker-machine active"            # Print which machine is active
alias dmconf="docker-machine config"         # Print the connection config for machine
alias dmc="docker-machine create"            # Create a machine
alias dme="docker-machine env"               # Display the commands to set up the environment for the Docker client
dmee() {                         # Execute the commands to set up the environment for the Docker client
  eval "$(dme $1)"
}
alias dmi="docker-machine inspect"           # Inspect information about a machine
alias dmip="docker-machine ip"               # Get the IP address of a machine
alias dmk="docker-machine kill"              # Kill a machine
alias dml="docker-machine ls"                # List machines
alias dmrc="docker-machine regenerate-certs" # Regenerate TLS Certificates for a machine
alias dmr="docker-machine restart"           # Restart a machine
alias dmrm="docker-machine rm"               # Remove a machine
alias dmssh="docker-machine ssh"             # Log into or run a command on a machine with SSH.
alias dmscp="docker-machine scp"             # Copy files between machines
alias dms="docker-machine start"             # Start a machine
alias dmst="docker-machine status"           # Get the status of a machine
alias dmstop="docker-machine stop"           # Stop a machine
alias dmu="docker-machine upgrade"           # Upgrade a machine to the latest version of Docker
alias dmurl="docker-machine url"             # Get the URL of a machine
alias dmh="docker-machine help"              # Shows a list of commands or help for one command
