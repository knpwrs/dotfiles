local wk = require('which-key')

require('winshift').setup()

wk.register(
  {
    m = { '<Cmd>WinShift<Cr>', 'Enter Win-Move Mode' },
  },
  {
    prefix = '<C-w>',
  }
)
