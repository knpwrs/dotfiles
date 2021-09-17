local wk = require('which-key')

vim.g.grepper = {
  tools = {'rg', 'git'},
}


wk.register(
  {
    g = { '<Cmd>Grepper<Cr>', 'Grepper' },
    G = { '<Cmd>Grepper -buffers<Cr>', 'Grepper Buffers' },
    gs = { '<Plug>(GrepperOperator)', 'Grepper Operator' },
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
    mode = 'x',
  }
)
