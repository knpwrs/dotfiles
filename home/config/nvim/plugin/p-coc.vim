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
nmap <silent> ]d <Plug>(coc-diagnostic-next)
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

" Float scrolling
nnoremap <nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
inoremap <nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
