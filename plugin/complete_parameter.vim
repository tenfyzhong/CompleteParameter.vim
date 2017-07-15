"==============================================================
"    file: complete_parameter.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 20:27:49
"==============================================================

if (!has('nvim')&&version < 704) || (!has('nvim')&&version==704&&!has('patch774')) || &compatible || exists('g:complete_parameter_version') 
    finish
endif
let g:complete_parameter_version = "0.2.2"
lockvar g:complete_parameter_version

let save_cpo = &cpo
set cpo&vim

call complete_parameter#init()

" set rtp+=expand('<sfile>:h:h:p').'/after'
" runtime expand('<sfile>:h:h:p').'/after/*.vim'

let &cpo = save_cpo
