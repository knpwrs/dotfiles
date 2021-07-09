require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'rust',
    'toml',
    'typescript',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
