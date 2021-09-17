local wk = require('which-key')

wk.register(
  {
    H = { '<Cmd>SidewaysLeft<Cr>', 'Move Item Left' },
    L = { '<Cmd>SidewaysRight<Cr>', 'Move Item Right' },
  },
  {
    prefix = '<Leader>'
  }
)
