"==============================================================
"    file: lua.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfy@tenfy.cn
" created: 2018-12-18 09:05:44
"==============================================================

" {'word': 'string.sub', 'menu': 'string.sub(s, i [, j])', 'user_data': '', 'info': '', 'kind': 'f', 'abbr': ''}
function! cm_parser#lua#parameters(completed_item) "{{{
  let menu = get(a:completed_item, 'menu', '')
  let kind = get(a:completed_item, 'kind', '')
  if kind == 'f'
    let param = substitute(menu, '.*\((.*)\)', '\1', 'g') " remove function name
    let param = substitute(param, '\s*\[.*\]', '', 'g') " remove default param
    return [param]
  endif
  return []
endfunction "}}}

function! cm_parser#lua#parameter_delim() "{{{
  return ','
endfunction "}}}

function! cm_parser#lua#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#lua#parameter_end() "{{{
    return ')'
endfunction "}}}

function! cm_parser#lua#echos(completed_item) "{{{
  let menu = get(a:completed_item, 'menu', '')
  let kind = get(a:completed_item, 'kind', '')
  if kind == 'f'
    return [menu]
  endif
  return []
endfunction "}}}
