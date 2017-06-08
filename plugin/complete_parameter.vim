"==============================================================
"    file: complete_parameter.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 20:27:49
"==============================================================

if version < 704
    finish
endif

call complete_parameter#init()

augroup cp_in
    au!
    au FileType go inoremap ( <C-R>=complete_parameter#complete('(')<cr><ESC>:call complete_parameter#goto_first_param()<cr>
    au FileType go inoremap <m-n> <ESC>:call complete_parameter#goto_next_param()<cr>
    au FileType go nnoremap <m-n> <ESC>:call complete_parameter#goto_next_param()<cr>
    au FileType go xnoremap <m-n> <ESC>:call complete_parameter#goto_next_param()<cr>
    au FileType go vnoremap <m-n> <ESC>:call complete_parameter#goto_next_param()<cr>
augroup END
