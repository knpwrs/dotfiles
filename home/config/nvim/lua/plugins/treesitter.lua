return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "andymass/vim-matchup" },
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "css",
        "dockerfile",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "graphql",
        "hcl",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonnet",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "regex",
        "ruby",
        "rust",
        "scss",
        "slint",
        "svelte",
        "terraform",
        "toml",
        "typescript",
        "tsx",
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
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<C-Cr>",
          node_decremental = "<Bs>",
        },
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    "David-Kunz/treesitter-unit",
    keys = {
      {
        "iu",
        function(tsu)
          tsu.select()
        end,
        desc = "Inner Unit",
        mode = "x",
      },
      {
        "au",
        function(tsu)
          tsu.select(true)
        end,
        desc = "Around Unit",
        mode = "x",
      },
      {
        "iu",
        ':<C-u>lua require"treesitter-unit".select()<cr>',
        desc = "Inner Unit",
        mode = "o",
      },
      {
        "au",
        ':<C-u>lua require"treesitter-unit".select(true)<cr>',
        desc = "Around Unit",
        mode = "o",
      },
    },
  },
  {
    "Wansmer/treesj",
    opts = function()
      return {
        use_default_keymaps = false,
        check_syntax_error = true,
        max_join_length = 120,
        cursor_behavior = "hold",
        notify = true,
        langs = {
          javascript = require("treesj.langs.javascript"),
          typescript = require("treesj.langs.typescript"),
          typescriptreact = require("treesj.langs.tsx"),
          ruby = require("treesj.langs.ruby"),
        },
      }
    end,
    keys = {
      { "gS", "<cmd>TSJSplit<cr>", desc = "Split Treesitter Node" },
      { "gJ", "<cmd>TSJJoin<cr>", desc = "Join Treesitter Node" },
      { "gM", "<cmd>TSJToggle<cr>", desc = "Toggle Split Treesitter Node" },
    },
  },
  "RRethy/nvim-treesitter-endwise",
  "windwp/nvim-ts-autotag",
  "yorickpeterse/nvim-tree-pairs",
}
