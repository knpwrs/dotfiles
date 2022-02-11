local wk = require('which-key')

vim.o.guifont='monospace:h11'

wk.register(
  {
    l = {
      function()
        if vim.o.lines < 10 or vim.o.lines == 20 then
          vim.o.lines = 10
        else
          vim.o.lines = 20
        end
      end,
      'Toggle number of lines between 10 and 20',
    },
  },
  {
    prefix = '<Leader><Leader>',
  }
)
