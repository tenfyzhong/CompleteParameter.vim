"==============================================================
"    file: python.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-11 18:11:12
"==============================================================

" deoplete
" {'word': 'call_tracing(', 'menu': '', 'info': 'call_tracing(func, args) -> object^@^@Call func(*args), while tracing is enabled.  The tracing state is^@saved, and restored afterwards.  This is intended to be called from^@a debugger from a checkpoint, to recursively debug some other code.', 'kind': '', 'abbr': 'call_tracing(func, args)'}
function! cm_parser#python#parameters(completed_item) "{{{
    let menu = get(a:completed_item, 'menu', '')
    let info = get(a:completed_item, 'info', '')
    let word = get(a:completed_item, 'word', '')
    if (menu !~# '\m^\%(function:\|def \)' && word !~# '\m^\w\+($') || empty(info)
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
