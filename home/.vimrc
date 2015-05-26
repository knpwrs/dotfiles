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
"" Fast edit the .vimrc file using \x
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

"" Enhancement Bundles
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kristijanhusak/vim-multiple-cursors'
NeoBundle 'mbbill/undotree'
NeoBundle 'godlygeek/tabular'
NeoBundle 'sickill/vim-pasta'

"" End Bundles
""

call neobundle#end()
NeoBundleCheck

"
" Interface
"
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
"set wrap
"set textwidth=80

"
" Colors and Fonts
"
syntax on
colorscheme hybrid
set background=dark
set list " Visible whitespace
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set linebreak
set showbreak=↪
set fillchars=diff:⣿,vert:│

"
" Indentation
"
set autoindent
set cindent
set expandtab
set softtabstop=2
set shiftwidth=2
set shiftround

"
" Search
"
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault " Default g flag
nnoremap / /\v
vnoremap / /\v
nnoremap <Leader><Space> :set hlsearch!<CR> " Use \<Space> to toggle search highlighting

"
" Filetype Settings
"

" quickfix
augroup ft_quickfix
  autocmd!
  autocmd filetype qf setlocal nolist nocursorline nowrap textwidth=0
augroup end

" markdown
augroup ft_markdown
  autocmd!
  " use <Leader>1/2/3/4/5/6 to add headings
  autocmd filetype markdown nnoremap <buffer> <Leader>1 i# <ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>2 i## <ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>3 i### <ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>4 i#### <ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>5 i##### <ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>6 i###### <ESC>
  " use <Leader>b to add blockquotes in normal and visual mode
  autocmd filetype markdown nnoremap <buffer> <Leader>b i> <ESC>
  autocmd filetype markdown vnoremap <buffer> <Leader>b :s/^/> /<CR>
  " use <Leader>ul and <Leader>ol to add list symbols in visual mode
  autocmd filetype markdown vnoremap <buffer> <Leader>ul :s/^/* /<CR>
  autocmd filetype markdown vnoremap <buffer> <Leader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
  " use <Leader>e1/2/3 to add emphasis symbols
  autocmd filetype markdown nnoremap <buffer> <Leader>e1 i*<ESC>a*<ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>e2 i**<ESC>a**<ESC>
  autocmd filetype markdown nnoremap <buffer> <Leader>e3 i***<ESC>a***<ESC>
  autocmd filetype markdown vnoremap <buffer> <Leader>e1 :s/\%v\(.*\)\%v/\*\1\*/<CR>
  autocmd filetype markdown vnoremap <buffer> <Leader>e2 :s/\%v\(.*\)\%v/\*\*\1\*\*/<CR>
  autocmd filetype markdown vnoremap <buffer> <Leader>e3 :s/\%V\(.*\)\%V/\*\*\*\1\*\*\*/<CR>
  " Turn on spell
  autocmd filetype markdown setlocal spell
augroup END

" HTML
augroup ft_html
  autocmd!
  autocmd filetype html setlocal spell " Turn on spell
augroup END

"
" Key Mappings
"

"" Window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

"" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"" Select entire buffer
nnoremap vaa ggvGg_

"" Strip all trailing whitespace in the current file
nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

"" Fix all indents
nnoremap <Leader>= gg=G

"" Toggle paste mode
set pastetoggle=<F2>

"" Remove last search highlight
nnoremap <F3> :noh<CR>

"
" Plugin Settings
"

"" Indent Guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_default_mapping=0
let g:indent_guides_exclude_filetypes=['help', 'nerdtree', 'startify', 'markdown']

"" Startify
let g:startify_custom_header=[
  \'            (       *     ',
  \'            )\ )  (  `    ',
  \'    (   (  (()/(  )\))(   ',
  \'    )\  )\  /(_))((_)()\  ',
  \'   ((_)((_)(_))  (_()((_) ',
  \'   \ \ / / |_ _| |  \/  | ',
  \'    \ V /   | |  | |\/| | ',
  \'     \_/   |___| |_|  |_| ',
  \'                          ']
hi StartifyHeader  ctermfg=111
hi StartifyFooter  ctermfg=111
hi StartifyBracket ctermfg=240
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240

"" Goyo and Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!

"" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space=1
let delimitMate_balance_matchpairs=1

"" NERD commenter
let NERDCommentWholeLinesInVMode=2
let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1

"" Multiple Cursors
" See https://github.com/kepbod/ivim/blob/762ff3556c2251d1c997d683c0363e6680d4a9dc/vimrc#L684

"" Undo Tree
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1

