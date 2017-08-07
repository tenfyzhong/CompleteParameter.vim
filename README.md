# CompleteParameter.vim

[![Join the chat at https://gitter.im/tenfyzhong/CompleteParameter.vim](https://badges.gitter.im/tenfyzhong/CompleteParameter.vim.svg)](https://gitter.im/tenfyzhong/CompleteParameter.vim?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/tenfyzhong/CompleteParameter.vim.svg?branch=master)](https://travis-ci.org/tenfyzhong/CompleteParameter.vim)
[![GitHub tag](https://img.shields.io/github/tag/tenfyzhong/CompleteParameter.vim.svg)](https://github.com/tenfyzhong/CompleteParameter.vim/tags)
![Vim Version](https://img.shields.io/badge/support-Vim%207.4.774%E2%86%91or%20NVIM-yellowgreen.svg?style=flat)
[![doc](https://img.shields.io/badge/doc-%3Ah%20CompleteParameter-yellow.svg?style=flat)](https://github.com/tenfyzhong/CompleteParameter.vim/blob/develop/doc/complete_parameter.txt)


CompleteParameter is a plugin for complete function's parameters after complete
a function.  

If you like this plugin, please star it. 


# Screenshots
Without CompleteParameter, only insert the function name. 
![ycm_only](http://wx4.sinaimg.cn/mw690/69472223gy1fhyjw7996cg20hs0a0n1b.gif)

With CompleteParameter, insert the function name and parameters. You can jump to 
the next parameter use `<c-j>` and jump to the previous parameter use `<c-k>`. 
![ycm_with_cp](http://wx4.sinaimg.cn/mw690/69472223gy1fhyjvrjhr3g20hs0a0qby.gif)


# Features
- Complete parameters after select a complete item from the completion popup menu. 
- After complete the parameters, jump to the first parameter and the select it. 
- Jump to next parameter. 
- Jump to previous parameter. 
- Select next overload function. 
- Select previous overload function. 
- Select the first item in the completion popup menu. 


# Install
I suggest you to use a plugin manager, such vim-plug or other.
- [vim-plug][]
```viml
Plug 'tenfyzhong/CompleteParameter.vim'
```
- Manual
```
git clone https://github.com/tenfyzhong/CompleteParameter.vim.git ~/.vim/bundle/CompleteParameter.vim
echo 'set rtp+=~/.vim/bundle/CompleteParameter.vim' >> ~/.vimrc
vim -c 'helptag ~/.vim/bundle/CompleteParameter.vim/doc' -c qa!
```


# Usage
Install a complete engine have supported. Goto the completion item of the
completion popup menu you want to select, and then type `(`(minimal setting), 
the parameters will be inserted and select the the first parameter. 
`<c-j>`/`<c-k>`(minimal setting) will jump to the next/previous parameter 
and select it. 


# Minimal setting
```viml
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
```

**The parameter of `complete_parameter#pre_complete` will be insert if
parameter completion failed.**


# Mapping
### `<Plug>(complete_parameter#goto_next_parameter)`
Goto next parameter and select it.  
eg:  
```viml
nmap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
```


### `<Plug>(complete_parameter#goto_previous_parameter)`
Goto previous parameter and select it.  
eg:  
```viml
nmap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
```

### `<Plug>(complete_parameter#overload_down)`
Select next overload function.  
eg:  
```viml
nmap <m-d> <Plug>(complete_parameter#overload_down)
imap <m-d> <Plug>(complete_parameter#overload_down)
smap <m-d> <Plug>(complete_parameter#overload_down)
```

### `<Plug>(complete_parameter#overload_up)`
Select previous overload function.  
eg:  
```viml
nmap <m-u> <Plug>(complete_parameter#overload_up)
imap <m-u> <Plug>(complete_parameter#overload_up)
smap <m-u> <Plug>(complete_parameter#overload_up)
```


# Options
### The `g:complete_parameter_log_level` option
This option set the log level.  
4: only print **error** log.  
2: print **error** and **debug** log.  
1: print **error**, **debug**, **trace** log.  
Default: 4  
```viml
let g:complete_parameter_log_level = 4
```

### The `g:complete_parameter_use_ultisnips_mappings` option
If this option is 1 and you use ultisnips together, it will use ultisnips mapping 
to goto next or previous parameter.  
default: 0  
```viml
let g:complete_parameter_use_ultisnips_mapping = 0
```


# Supported
The cell mark `x` means the completion engine has supported the language by itself.
Of course, you must install the completion engine for the language follow its document.  
The plugin in the cell was supported with the completion engine.   

|                | [YouCompleteMe][]           | [deoplete][]                | [neocomplete][]             | [clang_complete][] |
|----------------|-----------------------------|-----------------------------|-----------------------------|--------------------|
| **c**          | x                           | [deoplete-clang][]          | [clang_complete][]          | x                  |
| **cpp**        | x                           | [deoplete-clang][]          | [clang_complete][]          | x                  |
| **go**         | x                           | [vim-go][]                  | [vim-go][]                  |                    |
| **python**     | x                           | [deoplete-jedi][]           | [jedi-vim][]                |                    |
| **rust**       | x                           | [deoplete-rust][]           | [vim-racer][]               |                    |
| **javascript** | x                           | [deoplete-ternjs][]         | [tern_for_vim][]            |                    |
| **typescript** | x                           | [nvim-typescript][]         | [tsuquyomi][]               |                    |
| **erlang**     | [vim-erlang-omnicomplete][] | [vim-erlang-omnicomplete][] | [vim-erlang-omnicomplete][] |                    |

## Setting for completion plugins
### `vim-racer`
```viml
let g:racer_experimental_completer = 1
```

### `tern_for_vim`
```viml
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
```

### `tsuquyomi`
```viml
let g:tsuquyomi_completion_detail = 1
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'
```

# FAQ
### Can't work with plugin auto-pairs use the default mapping `(`
Because the auto-pairs use `inoremap` to mapping the keys. It can't call this
plugin after the auto-pairs process. You can add the following setting to you
.vimrc, and it'll work well. 
```viml
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
```


### Can't jump to next parameter
If you use `ultinsips`, you must load `ultisnips` before this plugin. In other 
words, if you use `plug` to load plugins, `Plug 'SirVer/ultisnips'` must before 
`Plug 'tenfyzhong/CompleteParameter.vim'` in your vimrc. 


### How to accept the selected function but not parameters
You can type `<c-y>` key to accept the selected function and stop completion.
When the popup menu is disappeared, the parameters will not be insert. 


### The mapping `<c-j>` doesn't jump to the next parameter, but delete the selected words. 
If you use neosnippet, Please set `g:neosnippet#disable_select_mode_mappings`
to 0. It will remove all select mappings. 
If you don't use neosnippet, please send me a issue, and give me the plugins
you are using. 


# Contributions 
Contributions and pull requests are welcome.


# Thanks
- [johnzeng](https://github.com/johnzeng), support erlang


# LICENSE
MIT License Copyright (c) 2017 tenfyzhong


[vim-plug]: https://github.com/junegunn/vim-plug
[YouCompleteMe]: https://github.com/Valloric/YouCompleteMe
[deoplete]: https://github.com/Shougo/deoplete.nvim
[neocomplete]: https://github.com/Shougo/neocomplete.vim
[clang_complete]: https://github.com/Rip-Rip/clang_complete
[deoplete-clang]: https://github.com/zchee/deoplete-clang
[nvim-typescript]: https://github.com/mhartington/nvim-typescript
[deoplete-rust]: https://github.com/sebastianmarkow/deoplete-rust
[jedi-vim]: https://github.com/davidhalter/jedi-vim
[deoplete-ternjs]: https://github.com/carlitux/deoplete-ternjs
[deoplete-jedi]: https://github.com/zchee/deoplete-jedi
[vim-erlang-omnicomplete]: https://github.com/johnzeng/vim-erlang-omnicomplete
[vim-go]: https://github.com/fatih/vim-go
[vim-racer]: https://github.com/racer-rust/vim-racer
[tern_for_vim]: https://github.com/ternjs/tern_for_vim
[tsuquyomi]: https://github.com/Quramy/tsuquyomi
