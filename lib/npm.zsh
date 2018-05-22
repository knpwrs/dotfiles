alias npci='npm ci'
alias npi='npm install'
alias npid='npm install -D'
alias npig='npm install -g'
alias npinit='npm init'
alias npinity='npm init -y'
alias npl='npm link'
alias npps='jq .scripts < package.json'
alias npr='npm run'
alias nprb='npm run build'
alias nprc='npm run check'
alias nprd='npm run dev'
alias nprfi='rm -rf node_modules && npm install'
alias nprl='npm run lint'
alias nps='npm start'
alias npsb='npm start build'
alias npsl='npm start lint'
alias npt='npm test'
alias npv='echo "v$(jq -r .version < package.json)"'
alias npv='npm version'
alias npvM='npm version major'
alias npvm='npm version minor'
alias npvp='npm version patch'

function npf() {
  jq ".$2" < $(npm ls --parseable "$1")/package.json
}

function nplf() {
  jq ".$2" < "./node_modules/$1/package.json"
}

function npoh() {
  open $(npm view $1 homepage)
}

function npon() {
  open "https://npm.im/$1"
}

function fnp() {
jq -r '[.dependencies | to_entries[] | .key][], [.devDependencies | to_entries[] | .key][]' < package.json \
  | sort \
  | fzf --preview='jq . node_modules/{}/package.json' \
        --bind='ctrl-h:execute(open $(jq -r .homepage node_modules/{}/package.json))'
}
