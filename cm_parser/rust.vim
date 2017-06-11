"==============================================================
"    file: rust.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 19:32:37
"==============================================================

" TODO support template
function! cm_parser#rust#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    let word = get(a:completed_item, 'word', '')
    if empty(menu) || empty(word)
        return []
    endif

    " check is fn or not
    if menu !~# '\m\<fn ' . word . '('
        return []
    endif
    let param = substitute(menu, '\m.*'.word.'\(([^)]*)\).*', '\1', '')
    while param =~# '\m<.*>'
        let param = substitute(param, '\m<[^>]*>', '', 'g')
    endwhile
    let param = substitute(param, '\m:\s*[^,)]*', '', 'g')
    return [param]
endfunction "}}}

function! cm_parser#rust#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#rust#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#rust#parameter_end() "{{{
    return ')'
endfunction "}}}
