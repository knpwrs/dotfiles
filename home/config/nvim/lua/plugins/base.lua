return {
  'kyazdani42/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    version = false,
    cmd = { "TSUpdateSync" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        'astro',
        'bash',
        'css',
        'dockerfile',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'graphql',
        'hcl',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonnet',
        'jsonc',
        'lua',
        'markdown',
        'markdown_inline',
        'nix',
        'python',
        'regex',
        'ruby',
        'rust',
        'scss',
        'slint',
        'svelte',
        'terraform',
        'toml',
        'typescript',
        'tsx',
      },
      endwise = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Cr>',
          node_incremental = '<Cr>',
          scope_incremental = '<C-Cr>',
          node_decremental = '<Bs>',
        },
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
    },
  },
}
