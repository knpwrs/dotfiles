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
  -- Interface Plugins
  use 'chriskempson/base16-vim'
  use { 'lukas-reineke/indent-blankline.nvim', config = [[require('p-indent-blankline')]] }
  -- Enhancement Plugins
  use { 'AndrewRadev/dsf.vim', config = [[require('p-dsf')]] }
  use { 'AndrewRadev/sideways.vim', config = [[require('p-sideways')]] }
  use 'AndrewRadev/splitjoin.vim'
  use 'bronson/vim-trailing-whitespace'
  use { 'editorconfig/editorconfig-vim', requires = {{'vim-scripts/PreserveNoEOL'}} }
  use { 'famiu/nvim-reload', requires = {{'plenary.nvim'}} }
  use 'godlygeek/tabular'
  use 'junegunn/vim-peekaboo'
  use 'lambdalisue/suda.vim' -- temporary, see keybindings.lua
  use {
    'lewis6991/gitsigns.nvim',
    requires = {{'plenary.nvim'}},
    config = [[require('p-gitsigns')]],
  }
  use {
    'mhinz/vim-grepper',
    cmd = {'Grepper'},
    keys = {'gs', '<Leader>g', '<Leader>G'},
    config = [[require('p-vim-grepper')]],
  }
  use { 'prettier/vim-prettier', run = 'npm install', config = [[require('p-vim-prettier')]] }
  use 'sickill/vim-pasta'
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
  use { 'vitalk/vim-simple-todo', config = [[require('p-vim-simple-todo')]] }
  use { 'windwp/nvim-autopairs', config = [[require('p-nvim-autopairs')]] }
  -- Movement Plugins
  use { 'justinmk/vim-sneak', config = [[require('p-vim-sneak')]] }
  -- Navigation Plugins
  use {
    'junegunn/fzf',
    run = [[fn['fzf#install']()]],
    config = [[require('p-fzf')]],
  }
  use 'junegunn/fzf.vim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {{'plenary.nvim', 'nvim-web-devicons'}},
    config = [[require('p-nvim-tree')]],
  }
  use { 'yssl/QFEnter', config = [[require('p-qfenter')]] }
  -- Motion Plugins
  use 'kana/vim-textobj-user'
  use { 'kana/vim-textobj-indent', requires = {{'kana/vim-textobj-user'}} }
  -- Language Plugins
  use 'hail2u/vim-css3-syntax'
  use 'mattn/emmet-vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = [[require('p-nvim-treesitter')]] }
  use { 'plasticboy/vim-markdown', config = [[require('p-vim-markdown')]] }
  use { 'rust-lang/rust.vim', config = [[require('p-rust')]] }
  -- LSP
  use { 'folke/trouble.nvim', requires = {'nvim-web-devicons'}, config = [[require('p-trouble')]] }
  use { 'hrsh7th/nvim-compe', config = [[require('p-nvim-compe')]]}
  use 'kabouzeid/nvim-lspinstall'
  use { 'neovim/nvim-lspconfig', config = [[require('p-nvim-lspconfig')]] }
end)
