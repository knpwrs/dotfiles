" Loosely based on ivim
" https://github.com/kepbod/ivim/blob/762ff3556c2251d1c997d683c0363e6680d4a9dc/vimrc

"
" General
"
set nocompatible
filetype plugin indent on
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
set title
set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)
set wildmenu
set wildmode=full
set backspace=indent,eol,start
set whichwrap+=h,l,<,>,[,]
set scrolljump=5 " Lines to jump when scrolling off-screen
set scrolloff=3 " Minimum number of lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor
set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink
set number " Show line numbers
nnoremap <Leader>n :set relativenumber!<CR> " Toggle relative line numbers
set formatoptions+=rnlmM
set wrap
set textwidth=80
"" Fonts
set list " Visible whitespace
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set linebreak
set showbreak=↪
set fillchars=diff:⣿,vert:│

