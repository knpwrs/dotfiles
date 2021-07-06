"" Status Line
let s:modemap={ 'n': 'NORMAL', 'i': 'INSERT', 'v': 'VISUAL' }
function! CurrentModeString()
  return get(s:modemap, mode(), '')
endfunction
set noshowmode
set statusline=%{CurrentModeString()}
set statusline+=%=%l,%c " ruler
set statusline+=\ %f
