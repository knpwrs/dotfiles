local wk = require('which-key')

vim.g.floaterm_opener = 'edit'

wk.register(
  {
    x = {
      name = 'Floaterm',
      X = { '<Cmd>FloatermNew --title=xplr --cwd=<root> xplr<Cr>', 'xplr root' },
      x = { '<Cmd>FloatermNew --title=xplr xplr<Cr>', 'xplr' },
      d = { '<Cmd>FloatermNew --title=lazydocker lazydocker<Cr>', 'lazydocker' },
      g = { '<Cmd>FloatermNew --title=lazygit lazygit<Cr>', 'lazygit' },
      z = { '<Cmd>FloatermNew --title=term<Cr>', 'zsh' },
    },
  },
  {
    prefix = '<Leader>',
  }
)
