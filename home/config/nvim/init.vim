
" Neovim default settings
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

"" Toggle paste mode
noremap <Leader>P :set paste!<cr>

"" Split mappings
noremap <Leader>- :<C-u>split<CR>
noremap <Leader>\| :<C-u>vsplit<CR>
noremap <leader>w <C-w>w

"" Close quickfix
noremap <Leader>c :ccl<CR>

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
noremap <Leader>[ :tabm -1<cr>
noremap <Leader>] :tabm +1<cr>

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let wn = tabpagewinnr(i,'$')

      let s .= '%#TabNum#'
      let s .= i
      " let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= ' ' . file . ' '
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
  set showtabline=1
  highlight link TabNum Special
endif

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
Plug 'bronson/vim-trailing-whitespace'
Plug 'danro/rename.vim'
Plug 'editorconfig/editorconfig-vim' | Plug 'vim-scripts/PreserveNoEOL'
Plug 'godlygeek/tabular'
Plug 'jreybert/vimagit'
Plug 'junegunn/vim-peekaboo'
Plug 'keith/investigate.vim'
Plug 'mileszs/ack.vim'
Plug 'raimondi/delimitmate'
Plug 'sickill/vim-pasta'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-fugitive-blame-ext' " Requires tpope/vim-fugitive
Plug 'tomtom/tcomment_vim'
Plug 'tonchis/vim-to-github'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vitalk/vim-simple-todo'
Plug 'w0rp/ale'
"" Movement Plugs
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
"" Navigation Plugs
Plug 'junegunn/fzf'
Plug 'scrooloose/nerdtree'
Plug 'tyok/nerdtree-ack'
"" Autocompletion Plugs
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neco-vim'
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'mhartington/nvim-typescript', { 'do': ':UpdateRemotePlugins' }
Plug 'wokalski/autocomplete-flow'
"" Version Control Plugs
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
"" Language Plugs
Plug 'hail2u/vim-css3-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown' " requires 'godlygeek/tabular'
Plug 'racer-rust/vim-racer'
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
  \:call repeat#set("dsf")<CR>
"" FZF
nmap <C-p> :FZF<CR>
nmap <leader>F :FZF<CR>
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
" let g:ackprg='ag --vimgrep' " The Silver Searcher
let g:ackprg='rg --vimgrep --no-heading' " ripgrep
noremap <leader>f :Ack!<Space>''<Left>
"" ALE
let g:ale_open_list = 1
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
"" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
  function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" let g:ale_completion_enabled = 1 " currently beta
"" vim-markdown
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_level = 6
"" sideways.vim
nnoremap <leader>H :SidewaysLeft<cr>
nnoremap <leader>L :SidewaysRight<cr>
"" vim-gitgutter
" nmap <leader>hs <Plug>GitGutterStageHunk " Default binding
" nmap <leader>hu <Plug>GitGutterUndoHunk " Default binding
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
"" vim-fugitive
nmap <leader>b :Gblame<cr>
