# general
alias deit='docker exec -it'

# docker compose
alias dc="docker compose"
alias dcb="docker compose build"
alias dce="docker compose exec"
dcl() {
  docker logs -f $(dc ps -q $1)
}
alias dck="docker compose kill"
alias dcrf="docker compose rm -f"
alias dcu="docker compose up"
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcr="docker compose run --rm"
alias dcrs="docker compose restart"
