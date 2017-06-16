"==============================================================
"    file: complete_parameter.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 20:27:49
"==============================================================

if version < 704 || (version == 704 && !has('patch2367')) || &compatible || exists('g:load_complete_parameter') 
    finish
endif
let g:load_complete_parameter = 1

let save_cpo = &cpo
set cpo&vim

call complete_parameter#init()

let &cpo = save_cpo
