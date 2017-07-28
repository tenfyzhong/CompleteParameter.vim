"==============================================================
"    file: ultisnips.vim
"   brief: 
" VIM Version: 8.0
"  author: zhongtenghui
"   email: zhongtenghui@gf.com.cn
" created: 2017-07-28 14:37:19
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

function! complete_parameter#ultisnips#ExpandTrigger()
    return <SID>wrap_next('ulti_expand_or_jump_res', 1)
endfunction

function! complete_parameter#ultisnips#JumpForward()
    return <SID>wrap_next('ulti_jump_forwards_res', 1)
endfunction

function! complete_parameter#ultisnips#JumpBackward()
    return <SID>wrap_next('ulti_jump_backwards_res', 0)
endfunction

