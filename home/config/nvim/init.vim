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

"" \x edits the vi config file.
nnoremap <Leader>x :tabedit $MYVIMRC<CR>
"" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"" Split mappings
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\| :<C-u>vsplit<CR>
noremap <leader>w <C-w>w

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

"" Status Line
let g:modemap={ 'n': 'NORMAL', 'i': 'INSERT', 'v': 'VISUAL' }
function! CurrentModeString()
  return get(g:modemap, mode(), '')
endfunction
set laststatus=2
set noshowmode
set ttimeoutlen=50
let g:bufferline_echo=0
let g:bufferline_modified='[+]'
set statusline=%{CurrentModeString()}
set statusline+=%=%f\ %m

"
" Begin vim-plug
" Run :PlugInstall to install plugins.
"
if has('vim_starting')
  "" Source the vim config after saving it
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  "" Source vim-plug
  source ~/.dotfiles/vendor/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
""
"" Start Plugs

"" Interface Plugs
Plug 'bling/vim-bufferline'
Plug 'w0ng/vim-hybrid'
"" Enhancement Plugs
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/PreserveNoEOL' " Required by EditorConfig for full functionality
Plug 'bronson/vim-trailing-whitespace'
Plug 'danro/rename.vim'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
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
Plug 'mileszs/ack.vim'
Plug 'vim-syntastic/syntastic'
"" Movement Plugs
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
"" Navigation Plugs
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
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
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'

"" End Plugs
""
call plug#end()
"
" End vim-plug
"

"" Colorscheme
set background=dark
colorscheme hybrid
hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=grey
hi StatusLine ctermfg=white ctermbg=bg cterm=bold
hi StatusLineNC ctermfg=235 ctermbg=bg
hi TabLineFill ctermfg=bg ctermbg=bg
hi TabLine ctermfg=bg ctermbg=fg
hi TabLineSel ctermfg=red ctermbg=bg
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=bg
hi GitGutterAdd ctermfg=green
hi GitGutterChange ctermfg=yellow
hi GitGutterDelete ctermfg=red
hi GitGutterChangeDelete ctermfg=red
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
set laststatus=2
set noshowmode
"" CtrlP
let g:ctrlp_map='<C-p>'
nmap <leader>o :CtrlPBuffer<CR>
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
nmap <Leader>t :NERDTreeToggle<CR>
nmap <Leader>T :NERDTreeFind<CR>
"" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus=1
"" delimitMate
let delimitMate_expand_cr=1
"" ack.vim
let g:ackprg='ag --vimgrep'
noremap <leader>f :Ack!<Space>''<Left>
"" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height=5
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
