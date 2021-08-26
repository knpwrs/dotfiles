local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap
local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-d>'] = actions.close,
        ['<Esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<Up>'] = actions.preview_scrolling_up,
        ['<Down>'] = actions.preview_scrolling_down,
        -- Unmap <C-u> ( https://github.com/nvim-telescope/telescope.nvim/issues/499 )
        ['<C-u>'] = false,
      },
      n = {
        ['<C-d>'] = actions.close,
        ['<Up>'] = actions.preview_scrolling_up,
        ['<Down>'] = actions.preview_scrolling_down,
      }
    }
  }
}

local opts = { noremap = true }
nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope git_files<Cr>', opts)
nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep<Cr>', opts)
nvim_set_keymap('n', '<Leader>fs', '<Cmd>Telescope grep_string<Cr>', opts)
nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers<Cr>', opts)
nvim_set_keymap('n', '<Leader>fr', '<Cmd>Telescope registers<Cr>', opts)
nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags<Cr>', opts)
nvim_set_keymap('n', '<Leader>fc', '<Cmd>Telescope commands<Cr>', opts)
nvim_set_keymap('n', '<Leader>f=', '<Cmd>Telescope spell_suggest<Cr>', opts)
nvim_set_keymap('n', '<Leader>fk', '<Cmd>Telescope keymaps<Cr>', opts)
nvim_set_keymap('n', '<Leader>fv', '<Cmd>Telescope vim_options<Cr>', opts)
nvim_set_keymap('n', '<Leader>ft', '<Cmd>Telescope builtin<Cr>', opts)
