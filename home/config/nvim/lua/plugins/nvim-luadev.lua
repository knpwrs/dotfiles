local wk = require('which-key')

wk.register(
  {
    n = {
      name = 'nvim-luadev',
      r = { '<Plug>(Luadev-Run)', 'Run' },
      rr = { '<Plug>(Luadev-RunLine)', 'Run' },
    }
  },
  {
    prefix = '<Leader>',
  }
)
