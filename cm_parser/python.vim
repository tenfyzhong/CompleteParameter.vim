"==============================================================
"    file: python.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 18:11:12
"==============================================================

function! cm_parser#python#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    let info = get(a:completed_item, 'info', '')
    if menu !~# '^function:' || empty(info)
        return []
    endif

    let info = a:completed_item['info']
    let func = split(info, '\n')[0]
    let param = substitute(func, '\m[^(]*\(([^)]*)\).*', '\1', '')
    let param = substitute(param, '\s*=\s*[^,()]*', '', 'g')
    return [param]
endfunction "}}}

function! cm_parser#python#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#python#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#python#parameter_end() "{{{
    return ')'
endfunction "}}}
