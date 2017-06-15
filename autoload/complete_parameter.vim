"==============================================================
"    file: complete_parameter.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 20:29:10
"==============================================================

let s:complete_parameter = {'index': 0, 'items': [], 'complete_pos': [], 'success': 0}
let s:complete_parameter_mapping_complete_for_ft = {'cpp': {'(': '()', '<': "<"}}

function! s:init_filetype_mapping() "{{{
    let filetype = &ft
    if !<SID>filetype_func_exist(filetype)
        return
    endif

    let mapping_complete = get(s:complete_parameter_mapping_complete_for_ft, filetype, {})
    if empty(mapping_complete)
        let mapping = s:complete_parameter_mapping_complete
        exec 'inoremap <silent><buffer> ' . mapping . ' <C-R>=complete_parameter#complete("'.s:complete_parameter_failed_insert.'")<cr><ESC>:call complete_parameter#goto_first_param("'.mapping.'")<cr>'
    else
        for [k, v] in items(mapping_complete)
            exec 'inoremap <silent><buffer> ' . k . ' <C-R>=complete_parameter#complete("'.v.'")<cr><ESC>:call complete_parameter#goto_first_param("'.k.'")<cr>'
        endfor
    endif
endfunction "}}}

augroup complete_parameter_init "{{{
    autocmd!
    autocmd FileType * call <SID>init_filetype_mapping()
augroup END "}}}

function! complete_parameter#init() "{{{
    runtime! cm_parser/*.vim

    if exists('g:complete_parameter_mapping_complete_for_ft') && type('g:complete_parameter_mapping_complete_for_ft') == 3
        let s:complete_parameter_mapping_complete_for_ft = extend(s:complete_parameter_mapping_complete_for_ft, g:complete_parameter_mapping_complete_for_ft, 'force')
    endif

    " 4 error
    " 2 error + debug
    " 1 erro + debug + trace
    let g:complete_parameter_log_level = get(g:, 'complete_parameter_log_level', 4)

    let g:complete_parameter_mapping_complete = get(g:, 'complete_parameter_mapping_complete', '')
    let s:complete_parameter_mapping_complete = g:complete_parameter_mapping_complete != '' ? g:complete_parameter_mapping_complete : '('

    let s:complete_parameter_failed_insert = get(g:, 'complete_parameter_failed_insert', '()')

    let g:complete_parameter_mapping_goto_next = get(g:, 'complete_parameter_mapping_goto_next', '')
    let s:complete_parameter_mapping_goto_next = g:complete_parameter_mapping_goto_next != '' ? g:complete_parameter_mapping_goto_next : '<m-n>'
    let g:complete_parameter_mapping_goto_previous = get(g:, 'complete_parameter_mapping_goto_previous', '')
    let s:complete_parameter_mapping_goto_previous = g:complete_parameter_mapping_goto_previous != '' ? g:complete_parameter_mapping_goto_previous : '<m-p>'

    let g:complete_parameter_mapping_overload_up = get(g:, 'complete_parameter_mapping_overload_up', '<m-u>')
    let s:complete_parameter_mapping_overload_up = g:complete_parameter_mapping_overload_up != '' ? g:complete_parameter_mapping_overload_up : '<m-u>'
    let g:complete_parameter_mapping_overload_down = get(g:, 'complete_parameter_mapping_overload_down', '<m-d>')
    let s:complete_parameter_mapping_overload_down = g:complete_parameter_mapping_overload_down != '' ? g:complete_parameter_mapping_overload_down : '<m-d>'
 
    exec 'inoremap <silent>' . s:complete_parameter_mapping_complete . ' <C-R>=complete_parameter#complete(''()'')<cr><ESC>:call complete_parameter#goto_first_param("'.s:complete_parameter_mapping_complete.'")<cr>'

    exec 'inoremap <silent>' . s:complete_parameter_mapping_goto_next . ' <ESC>:call complete_parameter#goto_next_param(1)<cr>'
    exec 'nnoremap <silent>' . s:complete_parameter_mapping_goto_next . ' <ESC>:call complete_parameter#goto_next_param(1)<cr>'
    exec 'xnoremap <silent>' . s:complete_parameter_mapping_goto_next . ' <ESC>:call complete_parameter#goto_next_param(1)<cr>'
    exec 'vnoremap <silent>' . s:complete_parameter_mapping_goto_next . ' <ESC>:call complete_parameter#goto_next_param(1)<cr>'

    exec 'inoremap <silent>' . s:complete_parameter_mapping_goto_previous . ' <ESC>:call complete_parameter#goto_next_param(0)<cr>'
    exec 'nnoremap <silent>' . s:complete_parameter_mapping_goto_previous . ' <ESC>:call complete_parameter#goto_next_param(0)<cr>'
    exec 'xnoremap <silent>' . s:complete_parameter_mapping_goto_previous . ' <ESC>:call complete_parameter#goto_next_param(0)<cr>'
    exec 'vnoremap <silent>' . s:complete_parameter_mapping_goto_previous . ' <ESC>:call complete_parameter#goto_next_param(0)<cr>'

    exec 'inoremap <silent>' . s:complete_parameter_mapping_overload_down . ' <ESC>:call complete_parameter#overload_next(1)<cr>'
    exec 'nnoremap <silent>' . s:complete_parameter_mapping_overload_down . ' <ESC>:call complete_parameter#overload_next(1)<cr>'
    exec 'xnoremap <silent>' . s:complete_parameter_mapping_overload_down . ' <ESC>:call complete_parameter#overload_next(1)<cr>'
    exec 'vnoremap <silent>' . s:complete_parameter_mapping_overload_down . ' <ESC>:call complete_parameter#overload_next(1)<cr>'

    exec 'inoremap <silent>' . s:complete_parameter_mapping_overload_up . ' <ESC>:call complete_parameter#overload_next(0)<cr>'
    exec 'nnoremap <silent>' . s:complete_parameter_mapping_overload_up . ' <ESC>:call complete_parameter#overload_next(0)<cr>'
    exec 'xnoremap <silent>' . s:complete_parameter_mapping_overload_up . ' <ESC>:call complete_parameter#overload_next(0)<cr>'
    exec 'vnoremap <silent>' . s:complete_parameter_mapping_overload_up . ' <ESC>:call complete_parameter#overload_next(0)<cr>'
endfunction "}}}

let s:ftfunc_prefix = 'cm_parser#'
let s:ftfunc = {'ft': ''}
function! s:new_ftfunc(filetype) "{{{
    if empty(a:filetype)
        throw 'filetype is empty'
    endif

    let ftfunc = deepcopy(s:ftfunc)
    let ftfunc['ft'] = a:filetype
    try
        let ftfunc['parameters'] = function(s:ftfunc_prefix . a:filetype .'#parameters')
        let ftfunc['parameter_delim'] = function(s:ftfunc_prefix . a:filetype . '#parameter_delim')
        let ftfunc['parameter_begin'] = function(s:ftfunc_prefix. a:filetype . '#parameter_begin')
        let ftfunc['parameter_end'] = function(s:ftfunc_prefix . a:filetype . '#parameter_end')
    catch /^E700/
        throw 'the function should be defined: ' . v:exception
    endtry

    return ftfunc
endfunction "}}}

function! s:filetype_func_exist(filetype) "{{{
    let filetype_func_prefix = s:ftfunc_prefix.a:filetype.'#'
    let parameters_func_name = filetype_func_prefix.'parameters'
    let parameter_delim_func_name = filetype_func_prefix.'parameter_delim'
    let parameter_begin_func_name = filetype_func_prefix.'parameter_begin'
    let parameter_end_func_name = filetype_func_prefix.'parameter_end'
    
    if !exists('*'.parameters_func_name) ||
                \!exists('*'.parameter_delim_func_name) ||
                \!exists('*'.parameter_begin_func_name) ||
                \!exists('*'.parameter_end_func_name)
        return 0
    endif
    return 1
endfunction "}}}

function! complete_parameter#filetype_func_check(ftfunc) "{{{
    if !<SID>filetype_func_exist(a:ftfunc['ft'])
        return 0
    endif

    " let parameters = a:ftfunc.parameters(v:completed_item)
    " if type(parameters) != 3
    "     return 0
    " endif

    if !exists('*'.string(a:ftfunc.parameter_delim))
        return 0
    endif
    let delim = a:ftfunc.parameter_delim()
    if type(delim) != 1 || empty(delim)
        return 0
    endif

    if !exists('*'.string(a:ftfunc.parameter_begin))
        return 0
    endif
    let begin = a:ftfunc.parameter_begin()
    if type(begin) != 1 || empty(begin)
        return 0
    endif

    if !exists('*'.string(a:ftfunc.parameter_end))
        return 0
    endif
    let end = a:ftfunc.parameter_end()
    if type(end) != 1 || empty(end)
        return 0
    endif
    return 1
endfunction "}}}

function! complete_parameter#complete(insert) "{{{
    call <SID>trace_log(string(v:completed_item))
    if empty(v:completed_item)
        return a:insert 
    endif
    " if v:completed_item['kind'] != 'f'
    "     return a:insert
    " endif

    let filetype = &ft
    if empty(filetype)
        return a:insert
    endif

    try
        let ftfunc = <SID>new_ftfunc(filetype)
    catch
        return a:insert
    endtry
    if !complete_parameter#filetype_func_check(ftfunc)
        return a:insert
    endif


    " example: the complete func like this`func Hello(param1 int, param2 string) int`
    " the parsed must be a list and the element of the list is a dictional,
    " the dictional must have the below keys
    " text: the text to be complete -> `(param1, param2)`
    " delim: the delim of parameters -> `,`
    " prefix: the begin of text -> `(`
    " suffix: the end of the text -> `)`
    let parseds = ftfunc.parameters(v:completed_item)
    call <SID>debug_log(string(parseds))
    if type(parseds) != 3
        call <SID>error_log('return type error')
        return a:insert
    endif

    if empty(parseds) || parseds[0] == ''
        return a:insert
    endif

    let s:complete_parameter['index'] = 0
    let s:complete_parameter['items'] = parseds

    let s:complete_parameter['complete_pos'] = [line('.'), col('.')]
    let col = s:complete_parameter['complete_pos'][1]
    let content = getline(line('.'))
    let s:complete_parameter['success'] = 1
    
    let parameter = s:complete_parameter['items'][0]
    if col > 1
        if content[col-1] ==# parameter[0]
            let parameter = substitute(parameter, '\m.\(.*\)', '\1', '')
        endif
    endif
    return parameter
endfunction "}}}

function! complete_parameter#goto_first_param(key) "{{{
    if s:complete_parameter['success']
        let complete_pos = s:complete_parameter['complete_pos']
        call cursor(complete_pos[0], complete_pos[1])
        let s:complete_parameter['success'] = 0
        call complete_parameter#goto_next_param(1)
    else
        startinsert
        " if insert one char, go right
        let ft = &filetype
        let mapping_complete = get(s:complete_parameter_mapping_complete_for_ft, ft, {})
        let inserted = get(mapping_complete, a:key, '')
        if len(inserted) == 1
            call feedkeys("\<RIGHT>", 'n')
        endif
    endif
endfunction "}}}

function! complete_parameter#goto_next_param(forward) "{{{
    let filetype = &ft
    if empty(filetype)
        return
    endif

    try
        let ftfunc = <SID>new_ftfunc(filetype)
    catch
        return
    endtry
    if !complete_parameter#filetype_func_check(ftfunc)
        return
    endif


    let lnum = line('.')
    let content = getline(lnum)
    let current_col = col('.')

    let step = a:forward ? 1 : -1

    let delim = ftfunc.parameter_delim()
    let border_begin = a:forward ? ftfunc.parameter_begin() : ftfunc.parameter_end()
    let border_end = a:forward ? ftfunc.parameter_end() : ftfunc.parameter_begin()

    let [word_begin, word_end] = complete_parameter#parameter_position(content, current_col, delim, border_begin, border_end, step)
    call <SID>trace_log('word_begin:'.word_begin.' word_end:'.word_end)
    if word_begin == 0 && word_end == 0
        return
    endif
    let word_len = word_end - word_begin
    call <SID>trace_log('word_len:'.word_len)
    if word_len == 0
        if a:forward
            call cursor(lnum, word_begin)
            startinsert
            call feedkeys("\<RIGHT>", 'n')
        endif
    else
        call cursor(lnum, word_begin)
        startinsert
        " BUG added by tenfyzhong 2017-06-10 20:13 
        " when call the `gh` key, it will select more the word_len letter
        " I don't know why.
        " call feedkeys("\<ESC>l".word_len.'gh', 'n')
        let keys = "\<ESC>lv"
        let right_len = word_len - 1
        if right_len > 0
            let keys .= right_len
            let keys .= "l"
        endif
        let keys .= "\<C-G>"
        call feedkeys(keys, 'n')
    endif
endfunction "}}}

" items: all overload complete function parameters
" current_line: current line content
" complete_pos: the pos where called complete
" forward: down or up
" [success, item, next_index, old_item_len]
function! complete_parameter#next_overload_content(items, current_index, current_line, complete_pos, forward) "{{{
    if len(a:items) <= 1 || 
                \a:current_index >= len(a:items) || 
                \empty(a:current_line) || 
                \len(a:current_line) < a:complete_pos[1]
        return [0]
    endif

    let current_overload_len = len(a:items[a:current_index])

    let pos = a:complete_pos[1] - 1
    let pos_end = pos+current_overload_len-1
    let content = a:current_line[ pos : pos_end ]
    if content !=# a:items[a:current_index]
        return [0]
    endif
    let overload_len = len(a:items)
    if a:forward
        let next_index = (a:current_index + 1) % overload_len
    else
        let next_index = (a:current_index+overload_len-1)%overload_len
    endif
    return [1, a:items[next_index], next_index, len(a:items[a:current_index])]
endfunction "}}}

function! complete_parameter#overload_next(forward) "{{{
    let overload_len = len(s:complete_parameter['items'])
    if overload_len <= 1
        return
    endif
    let complete_pos = s:complete_parameter['complete_pos']
    let current_line = line('.')
    let current_col = col('.')
    " if no in the complete content
    " then return
    if current_line != complete_pos[0] || current_col < complete_pos[1]
        return
    endif

    let current_index = s:complete_parameter['index']
    let current_line = getline(current_line)
    let result = complete_parameter#next_overload_content(
                \s:complete_parameter['items'], 
                \current_index, 
                \current_line, 
                \s:complete_parameter['complete_pos'], 
                \a:forward)
    if result[0] == 0
        return
    endif

    let current_overload_len = result[3]

    call cursor(complete_pos[0], complete_pos[1])

    exec 'normal! d'.current_overload_len.'l'

    let next_content = result[1]

    let s:complete_parameter['index'] = result[2]
    let s:complete_parameter['success'] = 1
    exec 'normal! a'.next_content
    stopinsert
    call complete_parameter#goto_first_param('')
endfunction "}}}

let s:stack = {'data':[]}

function! s:new_stack() "{{{
    return deepcopy(s:stack)
endfunction "}}}

function! s:stack.push(e) dict "{{{
    call add(self.data, a:e)
endfunction "}}}

function! s:stack.len() dict "{{{
    return len(self.data)
endfunction "}}}

function! s:stack.empty() dict "{{{
    return self.len() == 0
endfunction "}}}

function! s:stack.top() dict "{{{
    if self.empty()
        throw "stack is empty"
    endif
    return self.data[-1]
endfunction "}}}

function! s:stack.pop() dict "{{{
    if self.empty()
        throw "stack is empty"
    endif
    call remove(self.data, -1)
endfunction "}}}

function! s:stack.str() dict "{{{
    let str = 'stack size:'.self.len()
    for d in self.data
        let str .= "\n"
        let str .= 'stack elem:'.d
    endfor
    return str
endfunction "}}}

" content: string, the content to parse
" current_col: int, current col
" delim:  string, split the paramter letter
" return: [int, int] begin_col, end_col
function! complete_parameter#parameter_position(content, current_col, delim, border_begin, border_end, step) "{{{
    "{{{2
    if empty(a:content) || 
                \a:current_col==0 ||
                \empty(a:delim) ||
                \empty(a:border_begin) ||
                \empty(a:border_end) ||
                \len(a:border_begin) != len(a:border_end) ||
                \a:step==0
        return [0, 0]
    endif "}}}2
    let step = a:step > 0 ? 1 : -1
    let current_pos = a:current_col - 1
    let content_len = len(a:content)
    let end = a:step > 0 ? content_len : -1
    if current_pos >= content_len
        return [0, 0]
    endif

    let stack = <SID>new_stack()
    let pos = current_pos

    let border_matcher = {}
    let border_begin_chars = split(a:border_begin, '\zs')
    let border_end_chars = split(a:border_end, '\zs')
    let i = 0
    while i < len(border_end_chars)
        let border_matcher[border_begin_chars[i]] = '\m['.a:delim.border_end_chars[i].']'
        let i += 1
    endwhile

    " let border_matcher[a:border_begin] = '\m['.a:delim.a:border_end.']'
    let border_matcher[a:delim] = '\m['.a:delim.a:border_end.']'
    let border_matcher['"'] = '"'
    let border_matcher["'"] = "'"
    let border_matcher["`"] = "`"
    let begin_pos = 0
    let end_pos = 0

    " check has previous quote
    let quote_test_content = a:content[:pos-1]
    let quote_test_content = substitute(quote_test_content, '\m\\.', '', 'g')
    let quote_test_content = substitute(quote_test_content, '\m[^"''`]', '', 'g')
    let quotes = split(quote_test_content, '\zs')
    for quote in quotes
        if stack.empty()
            call stack.push(quote)
        elseif border_matcher[stack.top()] ==# quote
            call stack.pop()
        endif
    endfor

    while pos != end "{{{2
        if step < 0
            if pos + step != end && a:content[pos+step] == '\'
                let pos += 2*step 
                continue
            endif
        endif

        " if top of stack is quote and current letter is not a quote
        " the letter should be ignore
        if !stack.empty() && stack.top() =~# '\m["`'']' && a:content[pos] !~# '\m["`''\\]'
            let pos += step
            continue
        endif

        if a:content[pos] ==# '"' || a:content[pos] ==# "'" || a:content[pos] ==# '`'
            if stack.empty() || border_matcher[stack.top()] !=# a:content[pos]
                call stack.push(a:content[pos])
            else
                call stack.pop()
            endif
        elseif a:content[pos] ==# '\'
            let pos += step
        elseif stridx(a:border_begin, a:content[pos]) != -1
            call stack.push(a:content[pos])
            if stack.len() == 1
                " begin
                let pos += step
                let pos = <SID>find_first_not_space(a:content, pos, end, step)
                if pos == end
                    break
                endif
                let begin_pos = pos
                " no need to step forward
                " goto the beginning of the loop
                continue
            endif
        elseif a:content[pos] ==# a:delim
            if stack.empty()
                call stack.push(a:content[pos])
                let pos += step
                let pos = <SID>find_first_not_space(a:content, pos, end, step)
                if pos == end
                    break
                endif
                let begin_pos = pos
                " no need to step forward
                " goto the beginning of the loop
                continue
            elseif stack.len() == 1 && a:content[pos] =~# border_matcher[stack.top()]
                call stack.pop()
                if stack.empty()
                    " match delim
                    break
                endif
            endif
        elseif stridx(a:border_end, a:content[pos]) != -1
            if stack.empty()
                let begin_pos = pos
                let end_pos = pos
            else
                if a:content[pos] =~# border_matcher[stack.top()]
                    " border match, then pop
                    call stack.pop()
                    if stack.empty()
                        " match delim
                        break
                    endif
                endif
            endif
        endif
        let pos += step
    endwhile "}}}2
    if pos == end
        if begin_pos != 0 && end_pos != 0
            return [begin_pos+1,end_pos+1]
        else
            return [0, 0]
        endif
    endif

    if begin_pos != pos
        let pos -= step
        " find previous no space
        while pos != begin_pos && a:content[pos] =~# '\s'
            let pos -= step
        endwhile
    endif

    let end_pos = pos
    if begin_pos == end_pos && stridx(a:border_end, a:content[end_pos]) != -1
        return [begin_pos+1, end_pos+1]
    endif

    if end_pos < begin_pos
        let [begin_pos, end_pos] = [end_pos, begin_pos]
    endif
    return [begin_pos+1, end_pos+2]
endfunction "}}}

function! s:find_first_not_space(content, pos, end, step) "{{{
    let pos = a:pos
    if pos == -1 ||
                \pos==len(a:content)
        return pos == a:end
    endif
    if a:step == 0
        throw 'step is 0'
    endif
    while pos != a:end && a:content[pos] =~# '\s'
        let pos += a:step
    endwhile
    return pos
endfunction "}}}

function! s:error_log(msg) "{{{
    if g:complete_parameter_log_level <= 4
        echohl ErrorMsg | echom a:msg | echohl None
    endif
endfunction "}}}

function! s:debug_log(msg) "{{{
    if g:complete_parameter_log_level <= 2
        echom a:msg
    endif
endfunction "}}}

function! s:trace_log(msg) "{{{
    if g:complete_parameter_log_level <= 1
        echom a:msg
    endif
endfunction "}}}


