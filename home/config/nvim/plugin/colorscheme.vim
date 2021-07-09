let base16colorspace=256
colorscheme base16-bright
hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=grey ctermbg=bg
hi StatusLine ctermfg=white ctermbg=bg cterm=bold
hi StatusLineNC ctermfg=235 ctermbg=bg
hi TabLineFill ctermfg=bg ctermbg=bg
hi TabLine ctermfg=fg ctermbg=bg
hi TabLineSel ctermfg=red ctermbg=bg
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=bg
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
set laststatus=2

" Highlight yanked regions
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" LSP
hi LspDiagnosticsSignError ctermfg=red ctermbg=bg
hi LspDiagnosticsVirtualTextError ctermfg=red ctermbg=bg
hi LspDiagnosticsSignWarn ctermfg=yellow ctermbg=bg
hi LspDiagnosticsVirtualTextWarn ctermfg=yellow ctermbg=bg
hi LspDiagnosticsSignInformation ctermfg=blue ctermbg=bg
hi LspDiagnosticsVirtualTextInformation ctermfg=blue ctermbg=bg
