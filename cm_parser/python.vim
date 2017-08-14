"==============================================================
"    file: python.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 18:11:12
"==============================================================

function! s:parser0(info) "{{{
    let info_lines = split(a:info, '\n')
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
    let param = substitute(param, '\m(\s*\<self\>\s*,\?', '(', '')
    let param = substitute(param, '\m(\s*\<cls\>\s*,\?', '(', '')
    " remove space
    let param = substitute(param, '\m\s\+', ' ', 'g')
    let param = substitute(param, '\m(\s', '(', '')
    let param = substitute(param, '\m,\s*)', ')', '')
    let param = substitute(param, '\m,\(\S\)', ', \1', 'g')
    return [param]
endfunction "}}}

" deoplete
" {'word': 'call_tracing(', 'menu': '', 'info': 'call_tracing(func, args) -> object^@^@Call func(*args), while tracing is enabled.  The tracing state is^@saved, and restored afterwards.  This is intended to be called from^@a debugger from a checkpoint, to recursively debug some other code.', 'kind': '', 'abbr': 'call_tracing(func, args)'}
function! cm_parser#python#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    let info = get(a:completed_item, 'info', '')
    let word = get(a:completed_item, 'word', '')
    let abbr = get(a:completed_item, 'abbr', '')
    let kind = get(a:completed_item, 'kind', '')
    if (menu =~# '\m^\%(function:\|def \)' || word =~# '\m^\w\+($') && !empty(info)
        return s:parser0(info)
    elseif word ==# '(' && empty(menu) && info ==# ' ' && empty(kind) && !empty(abbr)
        " ycm omni called
        " {'word': '(', 'menu': '', 'info': ' ', 'kind': '', 'abbr': 'add(a,b)'}
        return s:parser0(abbr)
    endif
    return []
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
