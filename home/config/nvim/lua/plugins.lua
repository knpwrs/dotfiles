local cmd = vim.cmd
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

cmd([[
  augroup PackerUserConfig
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup({
  function ()
    -- Package manager
    use 'wbthomason/packer.nvim'
    -- Base Dependencies
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = [[require('plugins.nvim-treesitter')]] }
    -- Interface Plugins
    use { 'folke/tokyonight.nvim', config = [[require('plugins.tokyonight')]] }
    use { 'chentoast/marks.nvim', config = [[require('marks').setup({})]] }
    use {
      'SmiteshP/nvim-navic',
      requires = 'neovim/nvim-lspconfig',
      config = [[require('plugins.nvim-navic')]],
    }
    use { 'edluffy/specs.nvim', config = [[require('plugins.specs-nvim')]] }
    use { 'elihunter173/dirbuf.nvim', config = [[require('plugins.dirbuf')]] }
    use { 'folke/todo-comments.nvim', config = [[require('plugins.todo-comments')]] }
    use 'folke/which-key.nvim'
    use {
      'lewis6991/gitsigns.nvim',
      requires = {{'plenary.nvim'}},
      config = [[require('plugins.gitsigns')]],
    }
    use { 'lukas-reineke/indent-blankline.nvim', config = [[require('plugins.indent-blankline')]] }
    use { 'luukvbaal/stabilize.nvim', config = [[require('stabilize').setup()]] }
    use { 'voldikss/vim-floaterm', config = [[require('plugins.vim-floaterm')]] }
    use { 'https://gitlab.com/yorickpeterse/nvim-window.git', config = [[require('plugins.nvim-window')]]}
    -- Enhancement Plugins
    use { 'AndrewRadev/dsf.vim', config = [[require('plugins.dsf')]] }
    use { 'AndrewRadev/sideways.vim', config = [[require('plugins.sideways')]] }
    use 'andymass/vim-matchup'
    use { 'bfredl/nvim-luadev', config = [[require('plugins.nvim-luadev')]] }
    use 'dhruvasagar/vim-table-mode'
    use 'editorconfig/editorconfig-vim'
    use 'godlygeek/tabular'
    use { 'jenterkin/vim-autosource', config = [[require('plugins.autosource')]] }
    use { 'jpalardy/vim-slime', config = [[require('plugins.vim-slime')]] }
    use 'lambdalisue/suda.vim' -- temporary, see keybindings.lua
    use {
      'mhinz/vim-grepper',
      cmd = {'Grepper'},
      keys = {'gs', '<Leader>g', '<Leader>G'},
      config = [[require('plugins.vim-grepper')]],
    }
    use {
      'numToStr/Comment.nvim',
      requires = {{'JoosepAlviste/nvim-ts-context-commentstring'}},
      config = [[require('plugins.comment-nvim')]],
    }
    use { 'nvim-lualine/lualine.nvim', config = [[require('plugins.lualine')]] }
    use { 'rmagatti/auto-session', config = [[require('plugins.auto-session')]] }
    use { 'RRethy/nvim-treesitter-endwise', requires = {{'nvim-treesitter/nvim-treesitter'}} }
    use 'sickill/vim-pasta'
    use { 'sindrets/winshift.nvim', config = [[require('plugins.winshift')]] }
    use { 'szw/vim-maximizer', config = [[require('plugins.vim-maximizer')]] }
    use 'tmux-plugins/vim-tmux-focus-events'
    use 'tommcdo/vim-exchange'
    use { 'tommcdo/vim-fugitive-blame-ext', requires = {{'vim-fugitive'}} }
    use 'tpope/vim-abolish'
    use { 'tpope/vim-dadbod', cmd = {'DB'} }
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-speeddating'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use { 'vitalk/vim-simple-todo', config = [[require('plugins.vim-simple-todo')]] }
    use { 'Wansmer/treesj', requires = { 'nvim-treesitter' }, config = [[require('plugins.treesj')]] }
    use { 'windwp/nvim-autopairs', config = [[require('plugins.nvim-autopairs')]] }
    use { 'windwp/nvim-ts-autotag', config = [[require('plugins.nvim-ts-autotag')]] }
    -- Movement Plugins
    use { 'ggandor/lightspeed.nvim', config = [[require('plugins.lightspeed')]] }
    -- Navigation Plugins
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {{'plenary.nvim'}, {'nvim-web-devicons'}},
      config = [[require('plugins.nvim-tree')]],
    }
    use {
      'akinsho/bufferline.nvim',
      requires = {{'nvim-web-devicons'}},
      config = [[require('plugins.bufferline')]],
    }
    use { 'ibhagwan/fzf-lua', config = [[require('plugins.fzf-lua')]] }
    -- Text Object Plugins
    use { 'David-Kunz/treesitter-unit', config = [[require('plugins.treesitter-unit')]] }
    use 'kana/vim-textobj-user'
    use { 'kana/vim-textobj-indent', requires = {{'kana/vim-textobj-user'}} }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = {{'nvim-treesitter'}} }
    -- Language Plugins
    use 'hail2u/vim-css3-syntax'
    use 'mattn/emmet-vim'
    use { 'plasticboy/vim-markdown', config = [[require('plugins.vim-markdown')]] }
    use { 'rust-lang/rust.vim', config = [[require('plugins.rust')]] }
    -- Completion
    use { 'folke/trouble.nvim', requires = {'nvim-web-devicons'}, config = [[require('plugins.trouble')]] }
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/vim-vsnip', -- required for autocompletion to work, even without snippets
        'onsails/lspkind-nvim',
      },
      config = [[require('plugins.nvim-cmp')]],
    }
    use { 'j-hui/fidget.nvim', config = [[require('fidget').setup()]] }
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = {'plenary.nvim', 'nvim-lspconfig'},
      config = [[require('plugins.null-ls')]],
    }
    use { 'ray-x/lsp_signature.nvim', config = [[require('plugins.lsp-signature')]] }
    use {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
       'neovim/nvim-lspconfig',
        config = [[require('plugins.nvim-lspconfig')]],
        requires = {{'vim-illuminate'}},
      }
    }
    use { 'zbirenbaum/copilot.lua', after = 'nvim-lspconfig', config = [[require('plugins.copilot')]] }
    use { 'zbirenbaum/copilot-cmp', after = { 'copilot.lua', 'nvim-cmp' }, config = [[require('plugins.copilot-cmp')]] }
    -- DAP
    use { 'mfussenegger/nvim-dap', config = [[require('plugins.nvim-dap')]] }
    use {
      'rcarriga/nvim-dap-ui',
      requires = {'nvim-dap'},
      config = [[require('plugins.nvim-dap-ui')]],
    }
    use 'RRethy/vim-illuminate'
    use { 'theHamsta/nvim-dap-virtual-text', config = [[require('nvim-dap-virtual-text').setup()]] }
    -- Integration
    use {
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end,
      config = [[require('plugins.firenvim')]],
    }
    -- Fun
    use {
      'tamton-aquib/duck.nvim',
      config = [[require('plugins.duck')]]
    }
  end,
  config = {
    max_jobs = 10,
  },
})
