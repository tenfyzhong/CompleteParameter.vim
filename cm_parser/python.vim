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
    if menu !~# '\m^\%(function:\|def \)' || empty(info)
        return []
    endif

    let info = a:completed_item['info']
    let info_lines = split(info, '\n')
    let func = ''
    for line in info_lines
        if func =~# ')'
            break
        endif
        let func .= line
    endfor

    let param = substitute(func, '\m[^(]*\(([^)]*)\).*', '\1', '')
    let param = substitute(param, '\m\s*=\s*[^,()]*', '', 'g')
    " remove self,cls
    let param = substitute(param, '\m(\s*\<self\>\s*,', '(', '')
    let param = substitute(param, '\m(\s*\<cls\>\s*,', '(', '')
    " remove space
    let param = substitute(param, '\m\s\+', ' ', 'g')
    let param = substitute(param, '\m(\s', '(', '')
    let param = substitute(param, '\m,\s*)', ')', '')
    let param = substitute(param, '\m,\(\S\)', ', \1', 'g')
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
