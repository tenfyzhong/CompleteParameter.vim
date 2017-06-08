"==============================================================
"    file: complete_parameter.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 20:29:10
"==============================================================

let s:complete_parameter_parse_func = {}
let s:complete_parameter = {'index': 0, 'items': [], 'insert_col': 0}
let g:complete_parameter_parse_func = get(g:, 'complete_parameter_parse_func', {})

function! complete_parameter#init() "{{{
    let s:complete_parameter_parse_func['go'] = 'complete_parameter#parse#go'
    for [ft, func] in items(g:complete_parameter_parse_func)
        let s:complete_parameter_parse_func[ft] = func
    endfor
endfunction "}}}

function! complete_parameter#complete(insert) "{{{
    call <SID>trace_log('begin complete')
    if empty(v:completed_item)
        return a:insert . ')'
    endif
    if v:completed_item['kind'] != 'f'
        return a:insert . ')'
    endif

    let filetype = &ft
    let parse_func_name = get(s:complete_parameter_parse_func, filetype, '')
    if parse_func_name == ''
        return a:insert . ')'
    endif

    let s:parse_func = function(parse_func_name)
    " example: the complete func like this`func Hello(param1 int, param2 string) int`
    " the parsed must be a list and the element of the list is a dictional,
    " the dictional must have the below keys
    " text: the text to be complete -> `(param1, param2)`
    " delim: the delim of parameters -> `,`
    " prefix: the begin of text -> `(`
    " suffix: the end of the text -> `)`
    let parseds = call(s:parse_func, [v:completed_item])
    if type(parseds) != 3 
        call <SID>error_log('return type error')
        return a:insert
    endif

    if empty(parseds)
        return a:insert . ')'
    endif

    for parsed in parseds
        if get(parsed, 'text', '') ==# '' ||
                    \get(parsed, 'delim', '') ==# '' ||
                    \get(parsed, 'prefix', '') ==# ''||
                    \get(parsed, 'suffix', '') ==# ''
            return a:insert . ')'
        endif
    endfor

    let s:complete_parameter['index'] = 0
    let s:complete_parameter['items'] = parseds
    let s:complete_parameter['insert_col'] = col('.')

    return s:complete_parameter['items'][0]['text']
endfunction "}}}

function! complete_parameter#goto_first_param() "{{{
    let lnum = line('.')
    call cursor(lnum, s:complete_parameter['insert_col']-1)
    call complete_parameter#goto_next_param()
endfunction "}}}

function! complete_parameter#goto_next_param() "{{{
    let lnum = line('.')
    let current_index = s:complete_parameter['index']
    let item = s:complete_parameter['items'][current_index]
    let delim = item['delim']
    let prefix = item['prefix']
    let suffix = item['suffix']
    let content = getline(lnum)
    " find next `,` or `)`
    " the first index of match is 0
    " the first col of col() is 1
    " I will to match next col, so it's not need to -1
    let current_col = col('.')
    let current_end = match(content, '\m['.delim.prefix.suffix.']', current_col)
    if content[current_end] == suffix
        " finish
        call cursor(lnum, current_end+1)
        startinsert
        call feedkeys("\<RIGHT>", 'n')
        return
    endif

    " find the word begin and end position
    let word_begin = match(content, '\m\S', current_end+1)
    let word_end = match(content, '\m['.delim.suffix.']', word_begin)
    let word_len = word_end - word_begin
    if word_len == 0
        " no next item
        call cursor(lnum, word_end+1)
        startinsert
        call feedkeys("\<RIGHT>", 'n')
        return
    endif
    call cursor(lnum, word_begin+1)
    exec 'normal '.word_len.'gh'
endfunction "}}}

function! s:error_log(msg) "{{{
    echohl ErrorMsg | echom a:msg | echohl None
endfunction "}}}

function! s:trace_log(msg) "{{{
    echom a:msg
endfunction "}}}

