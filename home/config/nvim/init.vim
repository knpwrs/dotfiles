"
" Neovim default settins
" :h defaults
"

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
"" Use spaces instead of tabs.
set expandtab
"" Tab key indents by 2 spaces.
set softtabstop=2
"" >> indents by 2 spaces.
set shiftwidth=2
"" Switch between buffers without having to save first.
set hidden
"" Show current mode in command-line.
set showmode
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
"" Enable code folding
set foldmethod=syntax
"" Disable code folding by default
set nofoldenable
"" Command timeout
set ttimeoutlen=50

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

"" \, edits the vi config file.
nnoremap <Leader>, :tabedit $MYVIMRC<CR>
"" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"" Spell check settings
set spelllang=en
set spellfile=$DOTLIB/spell/en.utf-8.add
noremap <Leader>s :set spell!<CR>
" The following is from https://stackoverflow.com/a/38742983/355325
for d in glob("$DOTLIB/spell/*.add", 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor

"" Split mappings
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\| :<C-u>vsplit<CR>
noremap <leader>w <C-w>w

"" Tab mappings
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 :tablast<cr>

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

"" Status Line
let s:modemap={ 'n': 'NORMAL', 'i': 'INSERT', 'v': 'VISUAL' }
function! CurrentModeString()
  return get(s:modemap, mode(), '')
endfunction
set noshowmode
let g:bufferline_echo=0
set statusline=%{CurrentModeString()}
set statusline+=%=%l,%c " ruler
set statusline+=\ %f

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
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'bronson/vim-trailing-whitespace'
Plug 'danro/rename.vim'
Plug 'editorconfig/editorconfig-vim' | Plug 'vim-scripts/PreserveNoEOL'
Plug 'godlygeek/tabular'
Plug 'keith/investigate.vim'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'raimondi/delimitmate'
Plug 'sickill/vim-pasta'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
"" Movement Plugs
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
"" Navigation Plugs
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tyok/nerdtree-ack'
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
Plug 'hail2u/vim-css3-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown' " requires 'godlygeek/tabular'
Plug 'sheerun/vim-polyglot'

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
"" Misc Key bindings
nmap <silent> dsf ds(db
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
"" ALE
let g:ale_open_list = 1
let g:ale_completion_enabled = 1
"" vim-markdown
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_level = 6
"" sideways.vim
nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>H :SidewaysJumpLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>
nnoremap <leader>L :SidewaysJumpRight<cr>
