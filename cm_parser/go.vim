"==============================================================
"    file: go.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-10 09:59:22
"==============================================================

function! cm_parser#go#parameters(completed_item) "{{{
    let kind = get(a:completed_item, 'kind', '')
    let menu = get(a:completed_item, 'menu', '')
    if kind !=# 'f' || empty(menu)
        return []
    endif
    let param = substitute(menu, '\mfunc\(([^(]*)\).*', '\1', '')
    let param = substitute(param, '\m\(\w\+\)\s*[^,)]*', '\1', 'g')
    return [param]
endfunction "}}}

function! cm_parser#go#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#go#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#go#parameter_end() "{{{
    return ')'
endfunction "}}}
