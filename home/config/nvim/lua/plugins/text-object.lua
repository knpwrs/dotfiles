return {
  {
    'David-Kunz/treesitter-unit',
    config = function()
      local wk = require('which-key')
      local tsu = require('treesitter-unit')

      local opts = { noremap = true }

      wk.register(
        {
          iu = { function () tsu.select() end, 'Select Inner Unit' },
          au = { function () tsu.select(true) end, 'Select Around Unit' },
        },
        {
          mode = 'x',
        }
      )

      wk.register(
        {
          iu = { ':<C-u>lua require"treesitter-unit".select()<Cr>', 'Select Inner Unit' },
          au = { ':<C-u>lua require"treesitter-unit".select(true)<Cr>', 'Select Around Unit' },
        },
        {
          mode = 'o',
        }
      )
    end,
  },
  'kana/vim-textobj-user',
  {
    'kana/vim-textobj-indent',
    dependencies = {'kana/vim-textobj-user'},
  },
}
