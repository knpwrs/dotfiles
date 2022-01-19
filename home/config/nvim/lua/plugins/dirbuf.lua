local wk = require('which-key')

wk.register(
  {
    vd = { '<Cmd>Dirbuf<Cr>', 'dirbuf' },
    vD = { '<Cmd>Dirbuf %<Cr>', 'dirbuf in current directory' },
  },
  {
    prefix = '<Leader>',
  }
)
