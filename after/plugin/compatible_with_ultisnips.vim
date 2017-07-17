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
        return complete_parameter#goto_next_param(a:forward)
    else
        exec printf('let g:%s=0', a:check_val)
        if getchar(1) == 0
            call feedkeys('a', 'n')
        endif
        return ''
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

            endif
        endif
    else
        if g:UltiSnipsJumpForwardTrigger == g:complete_parameter_mapping_goto_next
            if match(g:complete_parameter_goto_next_mode, 'i') != -1
                exec "inoremap <silent> " . g:UltiSnipsJumpForwardTrigger . " <C-R>=UltiSnips#JumpForwards()<cr><C-R>=<SID>wrap_next('ulti_jump_forwards_res', 1)<cr>"
            endif

            if match(g:complete_parameter_goto_next_mode, 'v') != -1 || match(g:complete_parameter_goto_next_mode, 's') != -1
                exec "snoremap <silent> " . g:UltiSnipsJumpForwardTrigger . " <ESC>:call UltiSnips#JumpForwards()<cr><ESC>:call <SID>wrap_next('ulti_jump_forwards_res', 1)<cr>"
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
