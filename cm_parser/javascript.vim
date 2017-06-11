"==============================================================
"    file: javascript.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 21:14:37
"==============================================================

function! cm_parser#javascript#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    if empty(menu) || menu !~# '\m^fn'
        return []
    endif

    let param = substitute(menu, '\m^fn\((.*)\)\%(\s*->.*\)\?', '\1', '')
    " remove fn
    while param =~# '\<fn('
        let param = substitute(param, '\m\<fn([^)]*)', '', 'g')
    endwhile
    let param = substitute(param, '\m?\?:\s*[^,)]*', '', 'g')
    return [param]
endfunction "}}}

function! cm_parser#javascript#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#javascript#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#javascript#parameter_end() "{{{
    return ')'
endfunction "}}}
