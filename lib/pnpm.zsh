alias pna='pnpm add'
alias pnau='pnpm audit'
alias pnaf='pnpm audit --fix'
alias pncb='pnpm install --frozen-lockfile && pnpm run build'
alias pncc='pnpm install --frozen-lockfile && pnpm run check'
alias pncd='pnpm install --frozen-lockfile && pnpm run dev'
alias pnci='pnpm install --frozen-lockfile'
alias pnct='pnpm install --frozen-lockfile && pnpm test'
alias pnd='pnpm dlx'
alias pne='pnpm exec'
alias pni='pnpm install'
alias pnid='pnpm install -D'
alias pnig='pnpm install -g'
alias pninit='pnpm init'
alias pnl='pnpm link'
alias pnps='jq .scripts < package.json'
alias pnr='pnpm run'
alias pnrb='pnpm run build'
alias pnrbw='pnpm run build:watch'
alias pnrc='pnpm run check'
alias pnrd='pnpm run dev'
alias pnre='pnpm remove'
alias pnrfi='rm -rf node_modules && pnpm install'
alias pnrl='pnpm run lint'
alias pnrr='pnpm run release'
alias pns='pnpm start'
alias pnsw='pnpm run start:watch'
alias pnsb='pnpm start build'
alias pnsl='pnpm start lint'
alias pnt='pnpm test'
alias pntc='pnpm run test:coverage'
alias pntw='pnpm run test:watch'
alias pnv='echo "v$(jq -r .version < package.json)"'

function pnf() {
  if jq -e '.scripts.fix' package.json > /dev/null 2>&1; then
    pnpm run fix
  elif jq -e '.scripts.format' package.json > /dev/null 2>&1; then
    pnpm run format
  else
    echo "No 'fix' or 'format' script found in package.json"
    return 1
  fi
}

alias pnf!='pnpm run fix!'
