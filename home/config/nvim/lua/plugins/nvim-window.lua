local nw = require('nvim-window')
local wk = require('which-key')

wk.register(
  {
    ['<Leader>w'] = { function() nw.pick() end, 'Pick Window' },
  }
)
