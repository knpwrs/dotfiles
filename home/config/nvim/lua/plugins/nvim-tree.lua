local g = vim.g
local tree = require('nvim-tree')
local wk = require('which-key')

wk.register(
  {
    t = { '<Cmd>NvimTreeToggle<Cr>', 'Toggle File Tree' },
    T = { '<Cmd>NvimTreeFindFile<Cr>', 'Show Current File in Tree' },
  },
  {
    prefix = '<Leader>',
  }
)

local tree_cb = require('nvim-tree.config').nvim_tree_callback

-- Close tree when opening file
g.nvim_tree_quit_on_open = 1

-- Icons
g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}

tree.setup({
  update_to_buf_dir = {
     enable = false, -- Required for dirbuf.nvim
  },
  view = {
    mappings = {
      list = {
        { key = 'd', cb = tree_cb('remove') },
        { key = 'm', cb = tree_cb('rename') },
        { key = 'M', cb = tree_cb('full_rename') },
        { key = 'r', cb = tree_cb('refresh') },
        { key = {'<Esc>', '<C-d>', 'q'}, cb = tree_cb('close') }
      },
    },
  },
})
