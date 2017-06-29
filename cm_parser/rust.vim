"==============================================================
"    file: rust.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 19:32:37
"==============================================================

" ycm
"
" deoplete
" {'word': 'from_raw_parts', 'menu': '[Rust] pub unsafe fn from_raw_parts(ptr: *mut T', 'info': ub unsafe fn from_raw_partsptr: *mut T, length: usize, capacity: usize) -> Vec<T>', ('kind': 'Function', 'abbr': 'from_raw_parts'})'
function! s:parse(word, param) "{{{
    " check is fn or not
    let param = substitute(a:param, '\m.*'.a:word.'\(([^)]*)\).*', '\1', '')
    while param =~# '\m<.*>'
        let param = substitute(param, '\m<[^>]*>', '', 'g')
    endwhile
    let param = substitute(param, '\m:\s*[^,)]*', '', 'g')
    return [param]
endfunction "}}}

" TODO support template
function! cm_parser#rust#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    let word = get(a:completed_item, 'word', '')
    let kind = get(a:completed_item, 'kind', '')
    let info = get(a:completed_item, 'info', '')
    if kind ==# 'f' && !empty(word) && menu =~# '(.*)' && empty(info)
        return <SID>parse(word, menu)
    elseif kind ==# 'Function' && !empty(word) && info =~# '(.*)'
        return <SID>parse(word, info)
    endif
    return []
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
