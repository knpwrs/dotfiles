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

" Source the vimrc file after saving it
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" Fast edit the .vimrc file using ,x
nnoremap <Leader>x :tabedit $MYVIMRC<CR>

