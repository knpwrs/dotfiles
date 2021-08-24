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
nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope git_files<cr>', opts)
nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep<cr>', opts)
nvim_set_keymap('n', '<Leader>fs', '<Cmd>Telescope grep_string<cr>', opts)
nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers<cr>', opts)
nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags<cr>', opts)
nvim_set_keymap('n', '<Leader>fc', '<Cmd>Telescope commands<cr>', opts)
nvim_set_keymap('n', '<Leader>f=', '<Cmd>Telescope spell_suggest<cr>', opts)
