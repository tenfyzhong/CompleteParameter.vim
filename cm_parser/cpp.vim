"==============================================================
"    file: cpp.vim
"   brief: 
" VIM Version: 8.0
"  author: zhongtenghui
"   email: zhongtenghui@gf.com.cn
" created: 2017-06-13 08:58:09
"==============================================================

function! cm_parser#cpp#parameters(completed_item) "{{{
    let kind = get(a:completed_item, 'kind', '')
    let word = get(a:completed_item, 'word', '')
    let info = get(a:completed_item, 'info', '')
    if kind !=# 'f' || empty(word) || empty(info)
        return []
    endif

    let result = []
    let decls = split(info, '\n')
    for decl in decls
        let param = substitute(decl, '\m^.*\<'.word.'\((.*)\).*', '\1', '')
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

function! cm_parser#cpp#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#cpp#parameter_begin() "{{{
    return '(<'
endfunction "}}}

function! cm_parser#cpp#parameter_end() "{{{
    return ')>'
endfunction "}}}
