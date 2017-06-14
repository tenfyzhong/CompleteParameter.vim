"==============================================================
"    file: c.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-13 19:52:45
"==============================================================

function! cm_parser#c#parameters(completed_item) "{{{
    let kind = get(a:completed_item, 'kind', '')
    let abbr = get(a:completed_item, 'abbr', '')
    if kind !=# 'f' || empty(abbr)
        return []
    endif
    let param = substitute(abbr, '\m\w\+\((.*)\)', '\1', '')
    let param = substitute(param, '\m\([(,]\)\s*\%(\w\+\s\+\)*\s*\(\w\+\s*\)\s*\(\**\)\(\s*[,)]\)', '\1\2 \3\2\4', 'g')
    let param = substitute(param, '\m\s*\%(\w\+\s\+\)*\s*\(\**\s*\%(\w\+\)\s*[,)]\)', '\1', 'g')
    let param = substitute(param, '\s\+', '', 'g')
    let param = substitute(param, '\m,', ', ', 'g')
    return [param]
endfunction "}}}

function! cm_parser#c#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#c#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#c#parameter_end() "{{{
    return ')'
endfunction "}}}
