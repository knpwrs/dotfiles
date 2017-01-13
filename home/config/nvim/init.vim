" Originally based on minimal vimrc: https://github.com/mhinz/vim-galore/blob/master/content/minimal-vimrc.vim

"
" General Settings
"
if has('vim_starting')
  "" Encoding
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8
endif
"" Use jk as escape sequence
imap jk <Esc>
"" Load plugins according to detected filetype.
filetype plugin indent on
"" Enable syntax highlighting.
syntax on
"" Highlight coloring
hi Visual cterm=NONE ctermbg=0 ctermfg=NONE
hi Search cterm=NONE ctermbg=0 ctermfg=white
hi Pmenu cterm=NONE ctermbg=white ctermfg=0
hi LineNr cterm=NONE ctermbg=NONE ctermfg=grey
hi MatchParen cterm=NONE ctermbg=NONE ctermfg=red
"" Indent according to previous line.
set autoindent
"" Use spaces instaed of tabs.
set expandtab
"" Tab key indents by 2 spaces.
set softtabstop=2
"" >> indents by 2 spaces.
set shiftwidth=2
"" Make backspace work as you would expect.
set backspace=indent,eol,start
"" Switch between buffers without having to save first.
set hidden
"" Show as much as possible of the last line.
set display=lastline
"" Show current mode in command-line.
set showmode
"" Show already typed keys when more are expected.
set showcmd
"" Highlight while searching with / or ?.
set incsearch
"" Keep matches highlighted.
set hlsearch
"" Ignore case when searching.
set ignorecase
"" If a search contains an uppercase letter, it is case-sensitive.
set smartcase
"" Only redraw when necessary.
set lazyredraw
"" Open new windows below the current window.
set splitbelow
"" Open new windows right of the current window.
set splitright
"" Searches wrap around end-of-life.
set wrapscan
"" Always report changed lines.
set report=0
"" Only highlight the first 200 columns.
set synmaxcol=200
"" Show invisible characters.
set list
"" Show cursor position in status line.
set ruler

"" Line numbers.
set number
function! NumberToggle()
  if (&relativenumber == 1)
    set norelativenumber
    set number
  else
    set nonumber
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"" Source the vim config after saving it.
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"" \x edits the vi config file.
nnoremap <Leader>x :tabedit $MYVIMRC<CR>
"" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"" Split mappings
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\| :<C-u>vsplit<CR>

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

"
" Begin vim-plug
" Run :PlugInstall to install plugins.
"
if has('vim_starting')
  source ~/.dotfiles/vendor/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
""
"" Start Plugs

"" Interface Plugs
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'edkolev/tmuxline.vim'
"" Enhancement Plugs
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/PreserveNoEOL' " Required by EditorConfig for full functionality
Plug 'bronson/vim-trailing-whitespace'
Plug 'danro/rename.vim'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'sickill/vim-pasta'
Plug 'keith/investigate.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'tommcdo/vim-exchange'
"" Movement Plugs
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
"" Navigation Plugs
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"" Autocompletion Plugs
if has('lua')
  Plug 'Shougo/neocomplete.vim'
  let g:completion_engine='neocomplete'
else
  Plug 'Shougo/neocomplcache'
  let g:completion_engine='neocomplcache'
endif
"" Version Control Plugs
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
"" Language Plugs
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'amirh/HTML-AutoCloseTag'
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'

"" End Plugs
""
call plug#end()
"
" End vim-plug
"

"" Status Line
set laststatus=2
set noshowmode
set ttimeoutlen=50
let g:airline_theme='bubblegum'
let g:airline#extensions#tmuxline#enabled=0
let g:bufferline_echo=0
let g:bufferline_modified='[+]'
let g:airline_powerline_fonts=1
"" CtrlP
let g:ctrlp_map='<C-p>'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"" NERDTree
let NERDTreeShowHidden=1
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>
"" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus=1
"" delimitMate
let delimitMate_expand_cr=1
