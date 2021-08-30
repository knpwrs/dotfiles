local wk = require('which-key')

vim.g.simple_todo_map_keys = 0

wk.register(
  {
    m = {
      name = 'Simple Todo',
      i = { '<Plug>(simple-todo-new-list-item-start-of-line)', 'Make new list item from this line' },
      o = { '<Plug>(simple-todo-below)', 'Make new list item below this line' },
      O = { '<Plug>(simple-todo-above)', 'Make new list item above this line' },
      x = { '<Plug>(simple-todo-mark-as-done)', 'Mark this line as done' },
      X = { '<Plug>(simple-todo-mark-as-undone)', 'Mark this line as undone' },
      m = { '<Plug>(simple-todo-mark-switch)', 'Toggle this line as done' },
    },
  },
  {
    prefix = '<Leader>',
  }
)

