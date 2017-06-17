"==============================================================
"    file: typescript.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-17 08:56:21
"==============================================================

function! cm_parser#typescript#parameters(completed_item) "{{{
    let kind = get(a:completed_item, 'kind', '')
    let l:abbr = get(a:completed_item, 'abbr', '')
    if empty(kind) || kind !=# 'm' || empty(l:abbr)
        return []
    endif
    let word = get(a:completed_item, 'word', '')
    if l:abbr !~# '\m^'.word.'\s*(method)'
        return []
    endif

    let param = l:abbr

    " remove ()
    while param =~# '\m: ([^()]*)' 
        let param = substitute(param, '\m: \zs([^()]*)', '', 'g')
    endwhile

    " remove []
    while param =~# '\m\[[^[]*\]'
        let param = substitute(param, '\m\[[^[]*\]', '', 'g')
    endwhile

    " fun      (method) A.fun()
    let pattern = printf('\m^%s\s*(method)\s*.*%s\%%(<[^()<>]*>\)\?(\([^()]*\)).*', word, word)
    let param = substitute(param, pattern, '\1', '')
    let param = substitute(param, ':[^,)]*', '', 'g')
    let param = '('.param.')'
    return [param]
endfunction "}}}

function! cm_parser#typescript#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#typescript#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#typescript#parameter_end() "{{{
    return ')'
endfunction "}}}
