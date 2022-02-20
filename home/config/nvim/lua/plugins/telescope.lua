local wk = require('which-key')
local telescope = require 'telescope'
local actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-d>'] = actions.close,
        ['<Esc>'] = actions.close,
        ['<C-j>'] = actions.preview_scrolling_down,
        ['<C-k>'] = actions.preview_scrolling_up,
        -- Unmap <C-u> ( https://github.com/nvim-telescope/telescope.nvim/issues/499 )
        ['<C-u>'] = false,
      },
      n = {
        ['<C-d>'] = actions.close,
        ['<C-j>'] = actions.preview_scrolling_down,
        ['<C-k>'] = actions.preview_scrolling_up,
      },
    },
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
  },
}

telescope.load_extension('env')

wk.register(
  {
    f = {
      name = 'Telescope',
      e = { '<Cmd>Telescope env<Cr>', 'Environment Variables' },
      f = { '<Cmd>Telescope fd hidden=true<Cr>', 'Files' },
      g = { '<Cmd>Telescope live_grep<Cr>', 'Live Grep' },
      s = { '<Cmd>Telescope grep_string<Cr>', 'Grep String Under Cursor' },
      b = { '<Cmd>Telescope buffers<Cr>', 'Buffers' },
      r = { '<Cmd>Telescope registers<Cr>', 'Registers' },
      h = { '<Cmd>Telescope help_tags<Cr>', 'Help Tags' },
      c = { '<Cmd>Telescope commands<Cr>', 'Commands' },
      k = { '<Cmd>Telescope keymaps<Cr>', 'Keymaps' },
      v = { '<Cmd>Telescope vim_options<Cr>', 'Vim Options' },
      T = { '<Cmd>Telescope builtin<Cr>', 'Built-in Telescope Finders' },
      ['='] = { '<Cmd>Telescope spell_suggest<Cr>', 'Spelling Suggestions' },
    },
    [';'] = { '<Cmd>Telescope commands<Cr>', 'Commands' },
  },
  {
    prefix = '<Leader>'
  }
)
