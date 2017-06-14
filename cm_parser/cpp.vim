"==============================================================
"    file: cpp.vim
"   brief: 
" VIM Version: 8.0
"  author: zhongtenghui
"   email: zhongtenghui@gf.com.cn
" created: 2017-06-13 08:58:09
"==============================================================

function! s:parse_function(word, info) "{{{
    let result = []
    let decls = split(a:info, "\n")
    for decl in decls
        if empty(decl) || decl =~# '^\s*'.a:word.'\s*$'
            continue
        endif
        let param = substitute(decl, '\m^.*\<'.a:word.'\((.*)\).*', '\1', '')
        " remove <.*>
        while param =~# '<.*>'
            let param = substitute(param, '\m<[^<>]*>', '', 'g')
        endwhile
        let param = substitute(param, '\m\%(\s*[^(,)]*\s\)*\s*[&*]\?\s*\(\%(\w\+\)\|\%([*&]\)\)\s*\([,)]\)', '\1\2', 'g') 
        let param = substitute(param, ',', ', ', 'g')
        call add(result, param)
    endfor
    return result
endfunction "}}}

function! s:parse_class(word, info) "{{{
    let result = []
    let decls = split(a:info, "\n")
    for decl in decls
        if empty(decl) || decl =~# '^\s*'.a:word.'\s*$'
            continue
        endif
        let param = substitute(decl, '\m^.*\<'.a:word.'\(<.*>\).*', '\1', '')
        let param = substitute(param, '\m\%(\w\+\)\?\s*\(\w\+\s*[,>]\)', '\1', 'g')
        call add(result, param)
    endfor
    return result
endfunction "}}}

function! cm_parser#cpp#parameters(completed_item) "{{{
    let kind = get(a:completed_item, 'kind', '')
    let word = get(a:completed_item, 'word', '')
    let info = get(a:completed_item, 'info', '')
    if (kind !=# 'f' && kind != 'c') || empty(word) || empty(info)
        return []
    endif
    if kind ==# 'f'
        return <SID>parse_function(word, info)
    elseif kind ==# 'c'
        return <SID>parse_class(word, info)
    else
        return []
    endif
endfunction "}}}

function! cm_parser#cpp#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#cpp#parameter_begin() "{{{
    return '(<'
endfunction "}}}

function! cm_parser#cpp#parameter_end() "{{{
    return ')>'
endfunction "}}}
