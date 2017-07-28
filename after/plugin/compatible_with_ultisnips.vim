"==============================================================
"    file: compatible_with_ultisnips.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-07-14 22:08:37
"==============================================================
if !exists(':UltiSnipsEdit') && !g:complete_parameter_use_ultisnips_mappings
    finish
endif

if g:UltiSnipsExpandTrigger == g:UltiSnipsJumpForwardTrigger
    exec printf('inoremap <silent> %s <c-r>=UltiSnips#ExpandSnippetOrJump()<cr><c-r>=complete_parameter#ultisnips#ExpandTrigger()<cr>', g:UltiSnipsExpandTrigger)
    exec printf('snoremap <silent> %s <ESC>:call UltiSnips#ExpandSnippetOrJump()<cr><ESC>:call complete_parameter#ultisnips#ExpandTrigger()<cr>', g:UltiSnipsExpandTrigger)
else
    exec printf('inoremap <silent> %s <c-r>=UltiSnips#JumpForwards()<cr><c-r>=complete_parameter#ultisnips#JumpForward()<cr>', g:UltiSnipsJumpForwardTrigger)
    exec printf('snoremap <silent> %s <ESC>:call UltiSnips#JumpForwards()<cr><ESC>:call complete_parameter#ultisnips#JumpForward()<cr>', g:UltiSnipsJumpForwardTrigger)
endif
exec printf("inoremap <silent> %s <c-r>=UltiSnips#JumpBackwards()<cr><c-r>=complete_parameter#ultisnips#JumpBackward()<cr>", g:UltiSnipsJumpBackwardTrigger)
exec printf("snoremap <silent> %s <ESC>:call UltiSnips#JumpBackwards()<cr><ESC>:call complete_parameter#ultisnips#JumpBackward()<cr>", g:UltiSnipsJumpBackwardTrigger)

