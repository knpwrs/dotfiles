" Loosely based on ivim
" https://github.com/kepbod/ivim/blob/762ff3556c2251d1c997d683c0363e6680d4a9dc/vimrc

"
" General
"
set nocompatible
filetype plugin indent on
let mapleader=','
let maplocalleader='\'
set timeoutlen=500
set autoread
set hidden
set history=1000
set modeline
set encoding=utf-8
set completeopt+=longest
set completeopt-=preview

"" Source the vimrc file after saving it
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost $MYVIMRC NeoBundleClean
"" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

"
" NeoBundle
"
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand($HOME . '/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

""
"" Start Bundles

"" Interface Bundles
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'junegunn/goyo.vim' " Distraction-free editing
NeoBundle 'junegunn/limelight.vim' " Hyperfocus-writing

"" End Bundles
""

call neobundle#end()
NeoBundleCheck

"
" Interface
"
let g:startify_custom_header='Welcome to VimLand!'
colorscheme hybrid

