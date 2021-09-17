local catppuccino = require('catppuccino')
local catppuccino_api = require('catppuccino.api.colors')
local cmd = vim.cmd

catppuccino.setup({
  colorscheme = 'dark_catppuccino',
  integrations = {
    bufferline = true,
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    lightspeed = true,
    lsp_trouble = true,
    nvimtree = {
      enabled = true,
    },
    telescope = true,
    treesitter = true,
    which_key = true,
  },
})

local err, colors = catppuccino_api.get_colors('dark_catppuccino')

if err.status then -- good
  catppuccino.remap({
    bg = '#121212',
    bg_float = '#090909',
    bg_popup = '#090909',
    bg_sidebar = '#090909',
    bg_statusline = '#121212',
    white_br = '#ffffff',
    diff = {
      add = colors.green,
      delete = colors.red,
      change = colors.yellow,
    }
  })
end

catppuccino.load()

-- Highlight yanked regions
vim.api.nvim_exec(
  [[
    augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
    augroup END
  ]],
  false
)
