"==============================================================
"    file: javascript.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 21:14:37
"==============================================================

" ycm
function! s:parser0(menu) "{{{
    let param = substitute(a:menu, '\m^fn\((.*)\)\%(\s*->.*\)\?', '\1', '')
    " remove fn
    while param =~# '\<fn('
        let param = substitute(param, '\m\<fn([^)]*)', '', 'g')
    endwhile
    while param =~# '\w\+\s*:\s*{[^{}]*}'
        let param = substitute(param, '\m\(\w\+\):\s{[^{}]*}', '\1', 'g')
    endwhile
    let param = substitute(param, '\m?\?:\s*[^,)]*', '', 'g')
    return [param]
endfunction "}}}

" deoplete
function! s:check_parentheses_pairs(line) "{{{
    let left = 0
    let right = 0
    let i = 0
    while i < len(a:line)
        if a:line[i] ==# '('
            let left += 1
        elseif a:line[i] ==# ')'
            let right += 1
        endif
        let i += 1
    endwhile
    return left == right
endfunction "}}}

function! s:parser1(info) "{{{
    let info_lines = split(a:info, '\n')
    let func = info_lines[0]
    for line in info_lines[1:]
        if <SID>check_parentheses_pairs(func)
            break
        endif
        let func .= line
    endfor
    let param = substitute(func, '\m^fn\((.*)\)\%(\s*->.*\)\?', '\1', '')
    " remove fn
    while param =~# '\<fn('
        let param = substitute(param, '\m\<fn([^)]*)', '', 'g')
    endwhile
    while param =~# '\w\+\s*:\s*{[^{}]*}'
        let param = substitute(param, '\m\(\w\+)\s*:{[^{}]*}', '\1', 'g')
    endwhile
    let param = substitute(param, '\m?\?:\s*[^,)]*', '', 'g')
    return [param]
endfunction "}}}

function! cm_parser#javascript#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    let info = get(a:completed_item, 'info', '')
    if menu =~# '\m^fn('
        return <SID>parser0(menu)
    elseif info =~# '\m^fn('
        return <SID>parser1(info)
    endif
    return []
endfunction "}}}

function! cm_parser#javascript#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#javascript#parameter_begin() "{{{
    return '({'
endfunction "}}}

function! cm_parser#javascript#parameter_end() "{{{
    return ')}'
endfunction "}}}
