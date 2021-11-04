local wk = require('which-key')

vim.g.grepper = {
  tools = {'rg', 'git'},
  rg = {
    grepprg = 'rg -H --no-heading --vimgrep --hidden'
  },
}


wk.register(
  {
    g = { '<Cmd>Grepper<Cr>', 'Grepper' },
    G = { '<Cmd>Grepper -buffers<Cr>', 'Grepper Buffers' },
    ['*'] = { '<Cmd>Grepper -cword -noprompt<Cr>', 'Grepper Word Under Cursor' },
  },
  {
    prefix = '<Leader>',
  }
)


wk.register(
  {
    gs = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
  },
  {
    mode = 'n',
  }
)

wk.register(
  {
    gs = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
  },
  {
    mode = 'x',
  }
)
