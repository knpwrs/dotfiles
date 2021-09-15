local wk = require('which-key')

require('todo-comments').setup()

wk.register(
  {
    lx = {
      t = { '<Cmd>TodoTrouble<Cr>', 'Toggle TODO Comments' },
    },
    f = {
      t = { '<Cmd>TodoTelescope<Cr>', 'TODO Comments' },
    },
  },
  {
    prefix = '<Leader>',
  }
)
