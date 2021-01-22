
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
"" Use <C-d> as escape sequence
imap <C-d> <Esc>
cmap <C-d> <Esc>
vmap <C-d> <Esc>
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
"" Swapfile write time
set updatetime=300
"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"" Show incremental live substitution
set inccommand=nosplit

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

"" Execute macro over lines in visual mode
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"" \, edits the vi config file.
nnoremap <leader>, :tabedit $MYVIMRC<CR>
"" :bufo closes all open buffers except the current buffer
cnoreabbrev bufo %bd\|e#\|bd#<CR>\|'"
"" allow executing local nvimrc files
set exrc
"" disable :autocmd, shell, and write commands in local vimrc files
set secure

"" \r replaces the word under the cursor
nmap <leader>r :%s/<C-r><C-w>//g<Left><Left>

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"" Do not jump on invocation of *
nnoremap * :keepjumps normal! mi*`i<CR>

"" Spell check settings
set spelllang=en
set spellfile=$DOTLIB/spell/en.utf-8.add
noremap <leader>s :set spell!<CR>
" The following is from https://stackoverflow.com/a/38742983/355325
for d in glob("$DOTLIB/spell/*.add", 1, 1)
  if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor

"" Toggle paste mode
noremap <leader>P :set paste!<cr>

"" Split mappings
noremap <leader>- :<C-u>split<CR>
noremap <leader>\| :<C-u>vsplit<CR>

"" Close quickfix
noremap <leader>c :ccl<CR>

"" Copy file paths
nmap cp :let @*=expand("%")<CR>
nmap cP :let @*=expand("%:p")<CR>

"" Tab mappings
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
noremap <leader>[ :tabm -1<cr>
noremap <leader>] :tabm +1<cr>

" Show tab numbers and disambiguate tab names.
" Based on:
"  - https://stackoverflow.com/q/5927952/355325
"  - https://stackoverflow.com/a/49080456/355325
if exists("+showtabline")
  set tabline=%!GetTabLine()

  function! GetTabLine()
    let tabs = BuildTabs()
    let line = ''
    for i in range(len(tabs))
      let line .= (i+1 == tabpagenr()) ? '%#TabLineSel#' : '%#TabLine#'
      let line .= '%' . (i + 1) . 'T'
      let line .= (i + 1)
      let line .= ': ' . tabs[i].uniq_name . ' '
    endfor
    let line .= '%#TabLineFill#%T'
    return line
  endfunction

  function! BuildTabs()
    let tabs = []
    for i in range(tabpagenr('$'))
      let tabnum = i + 1
      let buflist = tabpagebuflist(tabnum)
      let file_path = ''
      let tab_name = bufname(buflist[0])
      if tab_name =~ 'NERD_tree' && len(buflist) > 1
        let tab_name = bufname(buflist[1])
      end
      let is_custom_name = 0
      if tab_name == ''
        let tab_name = '[No Name]'
        let is_custom_name = 1
      elseif tab_name =~ 'fzf'
        let tab_name = 'FZF'
        let is_custom_name = 1
      else
        let file_path = fnamemodify(tab_name, ':p')
        let tab_name = fnamemodify(tab_name, ':p:t')
      end
      let tab = {
        \ 'name': tab_name,
        \ 'uniq_name': tab_name,
        \ 'file_path': file_path,
        \ 'is_custom_name': is_custom_name
        \ }
      call add(tabs, tab)
    endfor
    call CalculateTabUniqueNames(tabs)
    return tabs
  endfunction

  function! CalculateTabUniqueNames(tabs)
    for tab in a:tabs
      if tab.is_custom_name | continue | endif
      let tab_common_path = ''
      for other_tab in a:tabs
        if tab.name != other_tab.name || tab.file_path == other_tab.file_path
          \ || other_tab.is_custom_name
          continue
        endif
        let common_path = GetCommonPath(tab.file_path, other_tab.file_path)
        if tab_common_path == '' || len(common_path) < len(tab_common_path)
          let tab_common_path = common_path
        endif
      endfor
      if tab_common_path == '' | continue | endif
      let common_path_has_immediate_child = 0
      for other_tab in a:tabs
        if tab.name == other_tab.name && !other_tab.is_custom_name
          \ && tab_common_path == fnamemodify(other_tab.file_path, ':h')
          let common_path_has_immediate_child = 1
          break
        endif
      endfor
      if common_path_has_immediate_child
        let tab_common_path = fnamemodify(common_path, ':h')
      endif
      let path = tab.file_path[len(tab_common_path)+1:-1]
      let path = fnamemodify(path, ':~:.:h')
      let dirs = split(path, '/', 1)
      if len(dirs) >= 5
        let path = dirs[0] . '/.../' . dirs[-1]
      endif
      let tab.uniq_name = tab.name . ' - ' . path
    endfor
  endfunction

  function! GetCommonPath(path1, path2)
    let dirs1 = split(a:path1, '/', 1)
    let dirs2 = split(a:path2, '/', 1)
    let i_different = 0
    for i in range(len(dirs1))
      if get(dirs1, i) != get(dirs2, i)
        let i_different = i
        break
      endif
    endfor
    return join(dirs1[0:i_different-1], '/')
  endfunction
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

"" Write with sudo
"" https://github.com/neovim/neovim/issues/1716
"" https://github.com/lambdalisue/suda.vim
" command! -nargs=0 WriteWithSudo :w !sudo tee % > /dev/null
" cnoreabbrev ww WriteWithSudo
cnoreabbrev ww SudaWrite

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
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-bufferline'
Plug 'w0ng/vim-hybrid'
"" Enhancement Plugs
Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'danro/rename.vim'
Plug 'editorconfig/editorconfig-vim' | Plug 'vim-scripts/PreserveNoEOL'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'jreybert/vimagit'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'lambdalisue/suda.vim' " Temporary, see above
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mileszs/ack.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'sickill/vim-pasta'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-fugitive-blame-ext' " requires tpope/vim-fugitive
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vitalk/vim-simple-todo'
"" Movement Plugs
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
"" Navigation Plugs
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tyok/nerdtree-ack'
Plug 'Xuyuanp/nerdtree-git-plugin'
"" Language Plugs
Plug 'hail2u/vim-css3-syntax'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown' " requires 'godlygeek/tabular'
Plug 'rhysd/vim-wasm'
Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'
"" Motions
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent' "| Plug 'kana/vim-textobj-user'

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
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
set laststatus=2
"" IndentLine
let g:indentLine_char = '⦙'
"" Misc Key bindings
nmap <silent> dsf ds(db
  \:call repeat#set("dsf")<CR>
"" FZF
nmap <C-t> :FZF<CR>
nmap <leader>F :FZF<CR>
"" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>T :NERDTreeFind<CR>
"" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus=1
"" delimitMate
let delimitMate_expand_cr=1
"" ack.vim
let g:ackprg='rg --vimgrep --no-heading --smart-case' " ripgrep
noremap <leader>f :Ack!<Space>''<Left>
noremap <leader>* :Ack! <cword><CR>

"" coc.nvim
let g:coc_global_extensions = [
  \'coc-eslint',
  \'coc-git',
  \'coc-json',
  \'coc-rust-analyzer',
  \'coc-snippets',
  \'coc-tsserver',
  \'coc-yaml',
  \'coc-yank',
  \]
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlights
hi CocCodeLens ctermfg=242

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gY :call CocAction('jumpTypeDefinition', 'tab drop')<CR>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gI :call CocAction('jumpImplementation', 'tab drop')<CR>
nmap <silent> gr <Plug>(coc-references)
" Diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-prev)
nmap <leader>qf <Plug>(coc-fix-current)
" coc-git
nmap <leader>hs :CocCommand git.chunkStage<cr>
nmap <leader>hu :CocCommand git.chunkUndo<cr>
nmap ]h <Plug>(coc-git-nextchunk)
nmap [h <Plug>(coc-git-prevchunk)
" coc-list
nmap <silent><nowait> <space>d :<C-u>CocList diagnostics<cr>
nmap <silent><nowait> <space>c :<C-u>CocList commands<cr>
nmap <silent><nowait> <space>o :<C-u>CocList outline<cr>
nmap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
" coc-snippet
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
nmap <leader>cs :CocCommand snippets.editSnippets<cr>
nmap <leader>cf :CocCommand snippets.openSnippetFiles<cr>
" formatting
xmap <leader>q  <Plug>(coc-format-selected)
nmap <leader>q  <Plug>(coc-format-selected)

"" vim-markdown
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = [
   \ 'js=javascript',
   \ 'rb=ruby',
   \ 'rs=rust',
   \ 'ts=typescript',
   \ 'py=python',
   \]
"" sideways.vim
nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>
"" vim-fugitive
nmap <leader>b :Gblame<cr>
"" vim-simple-todo
let g:simple_todo_map_keys = 0
nmap <leader>i <Plug>(simple-todo-new-list-item-start-of-line)
nmap <leader>o <Plug>(simple-todo-below)
nmap <leader>O <Plug>(simple-todo-above)
nmap <leader>x <Plug>(simple-todo-mark-as-done)
nmap <leader>X <Plug>(simple-todo-mark-as-undone)
nmap <leader>m <Plug>(simple-todo-mark-switch)
vmap <leader>x <Plug>(simple-todo-mark-as-done)
vmap <leader>X <Plug>(simple-todo-mark-as-undone)
vmap <leader>m <Plug>(simple-todo-mark-switch)
"" vim-prettier
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
"" rust.vim
let g:rustfmt_autosave = 1
"" vim-sneak
let g:sneak#label = 1
