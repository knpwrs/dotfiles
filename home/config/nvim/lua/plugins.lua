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

require('packer').startup(function ()
  -- Package manager
  use 'wbthomason/packer.nvim'
  -- Base Dependencies
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate',
    config = [[require('plugins.nvim-treesitter')]],
  }
  -- Interface Plugins
  use { 'Pocco81/Catppuccino.nvim', config = [[require('plugins.catppuccino')]] }
  use {
    'SmiteshP/nvim-gps',
    requires = 'nvim-treesitter',
    config = [[require('plugins.nvim-gps')]],
  }
  use { 'folke/todo-comments.nvim', config = [[require('plugins.todo-comments')]] }
  use 'folke/which-key.nvim'
  use { 'hoob3rt/lualine.nvim', config = [[require('plugins.lualine')]] }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {{'plenary.nvim'}},
    config = [[require('plugins.gitsigns')]],
  }
  use 'lukas-reineke/indent-blankline.nvim'
  -- Enhancement Plugins
  use { 'AndrewRadev/dsf.vim', config = [[require('plugins.dsf')]] }
  use { 'AndrewRadev/sideways.vim', config = [[require('plugins.sideways')]] }
  use 'AndrewRadev/splitjoin.vim'
  use 'bronson/vim-trailing-whitespace'
  use 'editorconfig/editorconfig-vim'
  use 'godlygeek/tabular'
  use { 'jenterkin/vim-autosource', config = [[require('plugins.autosource')]] }
  use 'lambdalisue/suda.vim' -- temporary, see keybindings.lua
  use {
    'mhinz/vim-grepper',
    cmd = {'Grepper'},
    keys = {'gs', '<Leader>g', '<Leader>G'},
    config = [[require('plugins.vim-grepper')]],
  }
  use { 'prettier/vim-prettier', run = 'npm install', config = [[require('plugins.vim-prettier')]] }
  use 'sickill/vim-pasta'
  use { 'sindrets/winshift.nvim', config = [[require('plugins.winshift')]] }
  use { 'szw/vim-maximizer', config = [[require('plugins.vim-maximizer')]] }
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tommcdo/vim-exchange'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-abolish'
  use { 'tpope/vim-dadbod', cmd = {'DB'} }
  use 'tpope/vim-endwise'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use { 'tommcdo/vim-fugitive-blame-ext', requires = {{'vim-fugitive'}} }
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use { 'vitalk/vim-simple-todo', config = [[require('plugins.vim-simple-todo')]] }
  use { 'windwp/nvim-autopairs', config = [[require('plugins.nvim-autopairs')]] }
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
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'plenary.nvim'}},
    config = [[require('plugins.telescope')]]
  }
  -- Text Object Plugins
  use { 'David-Kunz/treesitter-unit', config = [[require('plugins.treesitter-unit')]] }
  use 'kana/vim-textobj-user'
  use { 'kana/vim-textobj-indent', requires = {{'kana/vim-textobj-user'}} }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = '0.5-compat',
    requires = {{'nvim-treesitter'}},
  }
  -- Language Plugins
  use 'hail2u/vim-css3-syntax'
  use 'mattn/emmet-vim'
  use { 'plasticboy/vim-markdown', config = [[require('plugins.vim-markdown')]] }
  use { 'rust-lang/rust.vim', config = [[require('plugins.rust')]] }
  -- LSP
  use { 'folke/trouble.nvim', requires = {'nvim-web-devicons'}, config = [[require('plugins.trouble')]] }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/vim-vsnip', -- required for autocompletion to work, even without snippets
      'onsails/lspkind-nvim',
    },
    config = [[require('plugins.nvim-cmp')]],
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {'plenary.nvim', 'nvim-lspconfig'},
    config = [[require('plugins.null-ls')]],
  }
  use 'kabouzeid/nvim-lspinstall'
  use { 'neovim/nvim-lspconfig', config = [[require('plugins.nvim-lspconfig')]] }
  use { 'ray-x/lsp_signature.nvim', config = [[require('plugins.lsp-signature')]] }
  -- DAP
  use { 'mfussenegger/nvim-dap', config = [[require('plugins.nvim-dap')]] }
  use {
    'nvim-telescope/telescope-dap.nvim',
    requires = {{'nvim-dap'}, {'telescope.nvim'}},
    config = [[require('plugins.telescope-dap')]],
  }
  use {
    'rcarriga/nvim-dap-ui',
    requires = {'nvim-dap'},
    config = [[require('plugins.nvim-dap-ui')]],
  }
  use { 'theHamsta/nvim-dap-virtual-text', config = [[require('plugins.nvim-dap-virtual-text')]] }
end)