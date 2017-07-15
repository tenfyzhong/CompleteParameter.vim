"==============================================================
"    file: compatible_with_ultisnips.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-07-14 22:08:37
"==============================================================

function! s:wrap_next(check_val, forward)
    if get(g:, a:check_val, 0) == 0
        echom 'failed'
        return complete_parameter#goto_next_param(a:forward)
    else
        echom 'success:' . mode() . ' pos: ' . string(col('.'))
        exec printf('let g:%s=0', a:check_val)
        " if mode() ==# 'n'
        "     call feedkeys('', 'ix!')
        " endif
        return ''
    endif
endfunction

function! s:wrap_s(funcname, check_val, forward)
    let Ultifunc = function(a:funcname)
    call Ultifunc()
    " call UltiSnips#ExpandSnippetOrJump()
    if get(g:, a:check_val, 0)
        echom 'failed'
        call complete_parameter#goto_next_param(a:forward)
    else
        echom 'success'
        exec printf('let g:%s=0', a:check_val)
    endif
endfunction

if exists(':UltiSnipsEdit')
" g:complete_parameter_mapping_goto_next
" g:complete_parameter_mapping_goto_previous
"
" g:complete_parameter_goto_next_mode
" g:complete_parameter_goto_previous_mode
"
" g:UltiSnipsJumpForwardTrigger 
" g:UltiSnipsJumpBackwardTrigger
" g:UltiSnipsExpandTrigger

    if g:UltiSnipsExpandTrigger == g:UltiSnipsJumpForwardTrigger
        if g:UltiSnipsExpandTrigger == g:complete_parameter_mapping_goto_next 
            if match(g:complete_parameter_goto_next_mode, 'i') != -1
                exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=UltiSnips#ExpandSnippetOrJump()<cr><C-R>=<SID>wrap_next('ulti_expand_or_jump_res', 1)<cr>"
            endif

            if match(g:complete_parameter_goto_next_mode, 'v') != -1 || match(g:complete_parameter_goto_next_mode, 's') != -1
                exec "snoremap <silent> " . g:UltiSnipsExpandTrigger . " <ESC>:call UltiSnips#ExpandSnippetOrJump()<cr><ESC>:call <SID>wrap_next('ulti_expand_or_jump_res', 1)<cr>"
                " exec "snoremap <silent> " . g:UltiSnipsExpandTrigger . " <ESC>:call <SID>wrap_s('UltiSnips#ExpandSnippetOrJump', 'ulti_expand_or_jump_res', 1)<cr>"

            endif
        endif
    else
        if g:UltiSnipsJumpForwardTrigger == g:complete_parameter_mapping_goto_next
            if match(g:complete_parameter_goto_next_mode, 'i') != -1
                exec "inoremap <silent> " . g:UltiSnipsJumpForwardTrigger . " <C-R>=UltiSnips#JumpForwards()<cr><C-R>=<SID>wrap_next('ulti_jump_forwards_res', 1)<cr>"
            endif

            if match(g:complete_parameter_goto_next_mode, 'v') != -1 || match(g:complete_parameter_goto_next_mode, 's') != -1
                " exec "snoremap <silent> " . g:UltiSnipsJumpForwardTrigger . " <ESC>:call UltiSnips#JumpForwards()<cr><ESC>:call <SID>wrap_next('ulti_jump_forwards_res', 1)<cr>"
                exec "snoremap <silent> " . g:UltiSnipsExpandTrigger . " <ESC>:call <SID>wrap_s('UltiSnips#JumpForwards', 'ulti_jump_forwards_res', 1)<cr>"
            endif
        endif
    endif

    if g:UltiSnipsJumpBackwardTrigger == g:complete_parameter_mapping_goto_previous
        if match(g:complete_parameter_goto_previous_mode, 'i') != -1
            exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=UltiSnips#JumpBackwards()<cr><C-R>=<SID>wrap_next('ulti_jump_backwards_res', 0)<cr>"
        endif
        if match(g:complete_parameter_goto_previous_mode, 'v') != -1 || match(g:complete_parameter_goto_previous_mode, 's') != -1
            exec "snoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <ESC>:call UltiSnips#JumpBackwards()<cr><ESC>:call <SID>wrap_next('ulti_jump_backwards_res', 0)<cr>"
        endif
    endif
endif
