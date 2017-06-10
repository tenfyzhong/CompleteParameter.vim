"==============================================================
"    file: go.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-10 09:59:22
"==============================================================

function! cm_parser#go#parameters(completed_item) "{{{
    let menu = a:completed_item['menu']
    let param = matchlist(menu, '\m[^(]*(\([^(]*\)).*')[1]
    let params = split(param, '\s*,\s*')
    let trim_param = []
    for p in params
        let not_type = substitute(p, '\(\w\+\)\s.*', '\1', '')
        call add(trim_param, not_type)
    endfor
    let param = join(trim_param, ', ')
    let text = '(' . param . ')'
    return [text]
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
