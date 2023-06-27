local MiniFiles = require('mini.files')
local wk = require('which-key')

MiniFiles.setup()

wk.register(
  {
    t = { function() MiniFiles.open() end, 'Toggle File Tree' },
    T = { function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, 'Show Current File in Tree' },
  },
  {
    prefix = '<Leader>',
  }
)

