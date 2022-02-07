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
  endwise = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['ab'] = "@block.outer",
        ['ib'] = "@block.inner",
        ['ac'] = "@class.outer",
        ['ic'] = "@class.inner",
        ['af'] = "@function.outer",
        ['if'] = "@function.inner",
      },
    },
  },
}
