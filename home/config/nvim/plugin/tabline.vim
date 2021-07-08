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
      if tab_name =~ 'NvimTree' && len(buflist) > 1
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
