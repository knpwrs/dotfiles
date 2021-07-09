local nvim_set_keymap = vim.api.nvim_set_keymap

vim.o.completeopt = 'menuone,noselect'

require('compe').setup {
  enabled = true,
  autocomplete = true,
  min_length = 1,
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    nvim_lsp = true,
  },
}

nvim_set_keymap('i', '<C-Space>', 'compe#complete()', { silent = true, expr = true, noremap = true })
-- nvim_set_keymap('i', '<CR>', [[compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))]], { silent = true, expr = true, noremap = true })
nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', { silent = true, expr = true, noremap = true })
nvim_set_keymap('i', '<C-j>', 'compe#scroll({ "delta": +4 })', { silent = true, expr = true, noremap = true })
nvim_set_keymap('i', '<C-k>', 'compe#scroll({ "delta": -4 })', { silent = true, expr = true, noremap = true })
