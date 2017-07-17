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
let g:complete_parameter_last_failed_insert = ''

let s:log_index = 0

" mapping complete key
function! s:mapping_complete(key, failed_insert) "{{{
    let mapping = printf('imap <silent><expr><buffer> %s complete_parameter#pre_complete("%s")', a:key, a:failed_insert)
    exec mapping
endfunction "}}}

" mapping goto parameter and select overload function
function! complete_parameter#mapping_action(key, action, mode) "{{{
    let l:mode = a:mode
    if empty(l:mode)
        return
    endif
    let mode_list = split(l:mode, '\zs')
    for m in mode_list
        if m !~# '[inv]'
            continue
        endif
        exec m.'noremap <silent>' . a:key . ' ' . a:action
    endfor
endfunction "}}}

function! s:init_filetype_mapping() "{{{
    let filetype = &ft
    if !<SID>filetype_func_exist(filetype)
        return
    endif

    let mapping_complete = get(s:complete_parameter_mapping_complete_for_ft, filetype, {})
    if empty(mapping_complete)
        let mapping = s:complete_parameter_mapping_complete
        call <SID>mapping_complete(mapping, s:complete_parameter_failed_insert)
    else
        for [k, v] in items(mapping_complete)
            call <SID>mapping_complete(k, v)
        endfor
    endif
endfunction "}}}

function! s:default_failed_event_handler() "{{{
    if g:complete_parameter_last_failed_insert ==# '()' 
        call feedkeys("\<LEFT>", 'n') 
    endif
endfunction "}}}

augroup complete_parameter_init "{{{
    autocmd!
    autocmd FileType * call <SID>init_filetype_mapping()
    autocmd User CompleteParameterFailed call <SID>default_failed_event_handler()
augroup END "}}}

function! complete_parameter#init() "{{{
    runtime! cm_parser/*.vim

    " ultisnips will remove all smaps, this will without this plugin
    let g:UltiSnipsMappingsToIgnore = get(g:, 'UltiSnipsMappingsToIgnore', []) + ["complete_parameter"]
    " neosnippet will remove all smaps
    let g:neosnippet#disable_select_mode_mappings = 0

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
    let g:complete_parameter_mapping_goto_next = g:complete_parameter_mapping_goto_next != '' ? g:complete_parameter_mapping_goto_next : '<c-j>'
    let g:complete_parameter_goto_next_mode = get(g:, 'complete_parameter_goto_next_mode', '')
    let g:complete_parameter_goto_next_mode = g:complete_parameter_goto_next_mode != '' ? g:complete_parameter_goto_next_mode : 'iv'

    let g:complete_parameter_mapping_goto_previous = get(g:, 'complete_parameter_mapping_goto_previous', '')
    let g:complete_parameter_mapping_goto_previous = g:complete_parameter_mapping_goto_previous != '' ? g:complete_parameter_mapping_goto_previous : '<c-k>'
    let g:complete_parameter_goto_previous_mode = get(g:, 'complete_parameter_goto_previous_mode', '')
    let g:complete_parameter_goto_previous_mode = g:complete_parameter_goto_previous_mode != '' ? g:complete_parameter_goto_previous_mode : 'iv'

    let g:complete_parameter_mapping_overload_up = get(g:, 'complete_parameter_mapping_overload_up', '<m-u>')
    let g:complete_parameter_mapping_overload_up = g:complete_parameter_mapping_overload_up != '' ? g:complete_parameter_mapping_overload_up : '<m-u>'
    let g:complete_parameter_mapping_overload_up_mode = get(g:, 'complete_parameter_mapping_overload_up_mode', '')
    let g:complete_parameter_mapping_overload_up_mode = g:complete_parameter_mapping_overload_up_mode != '' ? g:complete_parameter_mapping_overload_up_mode : 'iv'

    let g:complete_parameter_mapping_overload_down = get(g:, 'complete_parameter_mapping_overload_down', '<m-d>')
    let g:complete_parameter_mapping_overload_down = g:complete_parameter_mapping_overload_down != '' ? g:complete_parameter_mapping_overload_down : '<m-d>'
    let g:complete_parameter_mapping_overload_down_mode = get(g:, 'complete_parameter_mapping_overload_down_mode', '')
    let g:complete_parameter_mapping_overload_down_mode = g:complete_parameter_mapping_overload_down_mode != '' ? g:complete_parameter_mapping_overload_down_mode : 'iv'

    call <SID>mapping_complete(s:complete_parameter_mapping_complete, s:complete_parameter_failed_insert)
    call complete_parameter#mapping_action(g:complete_parameter_mapping_goto_next, '<ESC>:call complete_parameter#goto_next_param(1)<cr>', g:complete_parameter_goto_next_mode)
    call complete_parameter#mapping_action(g:complete_parameter_mapping_goto_previous,  '<ESC>:call complete_parameter#goto_next_param(0)<cr>', g:complete_parameter_goto_previous_mode)
    call complete_parameter#mapping_action(g:complete_parameter_mapping_overload_up, '<ESC>:call complete_parameter#overload_next(0)<cr>', g:complete_parameter_mapping_overload_up_mode)
    call complete_parameter#mapping_action(g:complete_parameter_mapping_overload_down, '<ESC>:call complete_parameter#overload_next(1)<cr>', g:complete_parameter_mapping_overload_down_mode)
endfunction "}}}

let s:ftfunc_prefix = 'cm_parser#'
let s:ftfunc = {'ft': ''}
function! complete_parameter#new_ftfunc(filetype) "{{{
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

" check v:completed_item is empty or not
function! s:empty_completed_item() "{{{
    let completed_item = v:completed_item
    if empty(completed_item)
        return 1
    endif
    let menu = get(completed_item, 'menu', '')
    let info = get(completed_item, 'info', '')
    let kind = get(completed_item, 'kind', '')
    let abbr = get(completed_item, 'abbr', '')
    return empty(menu) && empty(info) && empty(kind) && empty(abbr)
endfunction "}}}

function! s:insert_mode_call_complete_func(failed_insert) "{{{
    return printf("\<C-r>=complete_parameter#complete('%s')\<ENTER>", a:failed_insert)
endfunction "}}}

" select an item if need, and the check need to revert or not
" else call the complete function
function! complete_parameter#pre_complete(failed_insert) "{{{
    let s:log_index += 1
    let completed_word = get(v:completed_item, 'word', '')

    if <SID>empty_completed_item() && pumvisible()
        let feed = printf("\<C-r>=complete_parameter#check_revert_select('%s', '%s')\<ENTER>", a:failed_insert, completed_word)
        call feedkeys(feed, 'n')
        return "\<C-n>"
    else
        let feed = <SID>insert_mode_call_complete_func(a:failed_insert)
        call feedkeys(feed, 'n')
        return ''
    endif
endfunction "}}}

function! s:failed_event(return_text, failed_insert) "{{{ return the text to insert and toggle event
    let g:complete_parameter_last_failed_insert = a:failed_insert
    call feedkeys("\<C-O>:doautocmd User CompleteParameterFailed\<ENTER>", 'n')
    return a:return_text
endfunction "}}}

" if the select item is not match with completed_word, the revert
" else call the complete function
function! complete_parameter#check_revert_select(failed_insert, completed_word) "{{{
    let select_complete_word = get(v:completed_item, 'word', '')
    call <SID>trace_log('s:completed_word: ' . a:completed_word)
    call <SID>trace_log('select_complete_word: ' . select_complete_word)
    if select_complete_word !=? a:completed_word
        call feedkeys(a:failed_insert, 'n')
        return <SID>failed_event("\<C-p>", a:failed_insert)
    else
        let feed = <SID>insert_mode_call_complete_func(a:failed_insert)
        call feedkeys(feed, 'n')
        return ''
    endif
endfunction "}}}

function! complete_parameter#check_parameter_return(parameter, parameter_begin, parameter_end)
    if len(a:parameter) < 2
        return 0
    endif
    " echom printf('mb, begin: %s, p[0]: %s, result: %d', a:parameter_begin, a:parameter[0], match(a:parameter_begin, a:parameter[0]) != -1)
    " echom printf('me, end: %s, p[-1]: %s, result: %d', a:parameter_end, a:parameter[-1], match(a:parameter_end, a:parameter[len(a:parameter)-1]) != -1)
    return match(a:parameter_begin, a:parameter[0]) != -1 &&
                \match(a:parameter_end, a:parameter[len(a:parameter)-1]) != -1
endfunction

function! complete_parameter#complete(failed_insert) "{{{
    call <SID>trace_log(string(v:completed_item))
    if <SID>empty_completed_item()
        call <SID>debug_log('v:completed_item is empty')
        return <SID>failed_event(a:failed_insert, a:failed_insert)
    endif

    let filetype = &ft
    if empty(filetype)
        call <SID>debug_log('filetype is empty')
        return <SID>failed_event(a:failed_insert, a:failed_insert)
    endif

    try
        let ftfunc = complete_parameter#new_ftfunc(filetype)
    catch
        call <SID>debug_log('new_ftfunc failed. '.string(v:exception))
        return <SID>failed_event(a:failed_insert, a:failed_insert)
    endtry
    if !complete_parameter#filetype_func_check(ftfunc)
        call <SID>error_log('ftfunc check failed')
        return <SID>failed_event(a:failed_insert, a:failed_insert)
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
        return <SID>failed_event(a:failed_insert, a:failed_insert)
    endif

    let parameter_begin = ftfunc.parameter_begin()
    let parameter_end = ftfunc.parameter_end()

    if empty(parseds) || len(parseds[0]) < 2 || !complete_parameter#check_parameter_return(parseds[0], parameter_begin, parameter_end)
        call <SID>debug_log("parseds is empty")
        return <SID>failed_event(a:failed_insert, a:failed_insert)
    endif

    let s:complete_parameter['index'] = 0
    let s:complete_parameter['items'] = parseds

    let s:complete_parameter['complete_pos'] = [line('.'), col('.')]
    let col = s:complete_parameter['complete_pos'][1]
    let s:complete_parameter['success'] = 1
    
    " if the first char of parameter was inserted, remove it from the parameter
    let content = getline(line('.'))
    let parameter = s:complete_parameter['items'][0]
    if col > 1
        if content[col-2] ==# parameter[0]
            let parameter = substitute(parameter, '\m.\(.*\)', '\1', '')
            let s:complete_parameter['complete_pos'][1] = col - 1
        endif
    endif

    let keys = "\<ESC>".':call complete_parameter#goto_first_param()'."\<ENTER>"
    call feedkeys(keys, 'n')
    return parameter
endfunction "}}}

function! complete_parameter#goto_first_param() "{{{
    if s:complete_parameter['success']
        let complete_pos = s:complete_parameter['complete_pos']
        call cursor(complete_pos[0], complete_pos[1])
        let s:complete_parameter['success'] = 0
        call complete_parameter#goto_next_param(1)
    endif
endfunction "}}}

function! complete_parameter#goto_next_param(forward) "{{{
    let filetype = &ft
    if empty(filetype)
        call <SID>debug_log('filetype is empty')
        return ''
    endif

    try
        let ftfunc = complete_parameter#new_ftfunc(filetype)
    catch
        call <SID>debug_log('new ftfunc failed')
        return ''
    endtry
    if !complete_parameter#filetype_func_check(ftfunc)
        return ''
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
        call <SID>debug_log('word_begin and word_end is 0')
        return ''
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
    return ''
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
        call <SID>trace_log('no more overload')
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
        call <SID>debug_log('get overload content failed')
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
    call complete_parameter#goto_first_param()
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

function! s:in_scope(content, pos, border, step, end)
    " echom printf('content: %s, pos: %d, border: %s, step: %d, end: %d', a:content, a:pos, a:border, a:step, a:end)
    let i = a:pos
    while i != a:end
        if a:content[i] =~# '\m['.a:border.']'
            return 1
        endif
        let i += a:step
    endwhile
    return 0
endfunction

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
        call <SID>debug_log('parameter_position param error')
        return [0, 0]
    endif "}}}2
    let step = a:step > 0 ? 1 : -1
    let current_pos = a:current_col - 1
    if mode() ==# 'i'
        let current_pos -= 1
    endif
    let content_len = len(a:content)
    let end = a:step > 0 ? content_len : -1
    if current_pos >= content_len
        call <SID>error_log('current_pos is large than content_len')
        return [0, 0]
    endif

    " check current pos is in the scope or not
    let score_end = step > 0 ? -1 : content_len
    if !<SID>in_scope(a:content, current_pos, a:border_begin, -step, score_end)
        call <SID>trace_log("no in scope")
        retur [0, 0]
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
    let quote_test_content_pos = pos
    if a:content[quote_test_content_pos] =~# '\m["''`]'
        let quote_test_content_pos -= step
    endif
    let quote_test_content = a:content[:quote_test_content_pos]
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

function! s:log(level, msg) "{{{
    echom a:level . ':' . s:log_index . ':' a:msg
endfunction "}}}

function! s:error_log(msg) "{{{
    if g:complete_parameter_log_level <= 4
        echohl ErrorMsg 
        call <SID>log('ERROR', a:msg)
        echohl None
    endif
endfunction "}}}

function! s:debug_log(msg) "{{{
    if g:complete_parameter_log_level <= 2
        call <SID>log('DEBUG', a:msg)
    endif
endfunction "}}}

function! s:trace_log(msg) "{{{
    if g:complete_parameter_log_level <= 1
        call <SID>log('TRACE', a:msg)
    endif
endfunction "}}}


