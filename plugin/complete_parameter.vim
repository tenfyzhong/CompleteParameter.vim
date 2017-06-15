"==============================================================
"    file: complete_parameter.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 20:27:49
"==============================================================

if version < 704 || &compatible || exists('g:load_complete_parameter') 
    finish
endif

let g:load_complete_parameter = 1

call complete_parameter#init()

