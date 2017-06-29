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
![cp_screenshorts](https://ooo.0o0.ooo/2017/06/14/5940c34725a1a.gif)


# Features
- Complete parameters after select a complete item from the completion popup menu. 
- After complete the parameters, jump to the first parameter and the select it. 
- `<m-n>`(default mapping) to jump to the next parameter in any position. 
- `<m-p>`(default mapping) to jump to the previous parameter in any position. 
- `<m-d>`(default mapping) select next overload function parameters. Only cpp now.
- `<m-u>`(default mapping) select previous overload function parameters. Only cpp now
- Select the first item in the completion popup menu if you no select one and 
  type `(`(default mapping).


# Install
I suggest you to use a plugin manager, such vim-plug or other.
- [vim-plug](https://github.com/junegunn/vim-plug)
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
Install a complete engine we have supported. Goto the completion item of the
completion popup menu you want to select, and then type `(`(default mapping), 
the parameters will be completed and jump the the first parameter. The first 
completion item will be seleted if no one selected and the input is equal to 
the first popup item after you type `(`. 
`<m-n>`/`<m-p>`(default mapping) will jump to the next/previous parameter 
and select it. 


# Mapping
### `(`
Mapping type: inoremap  
Call the parameter completor.  

### `<m-n>`
Mapping type: inoremap,nnoremap,vnoremap  
Goto the next parameter and select it.  

### `<m-p>`
Mapping type: inoremap,nnoremap,vnoremap  
Goto the previous parameter and select it.

### `<m-d>`
Mapping type: inoremap,nnoremap,vnoremap  
Select the next overload function.   

### `<m-u>`
Mapping type: inoremap,nnoremap,vnoremap  
Select the previous overload function.  

# Options
### The `g:complete_parameter_mapping_complete` option
This option set the complete mapping. When you are in a complete item of the 
completion popup menu, type this mapping, it'll complete the parameters.   
Default: `(`  
```viml
let g:complete_parameter_mapping_complete = '('
```

### The `g:complete_parameter_failed_insert` option
This option set the complete text when the parameter complete failed. 
Default: `()`
```viml
let g:complete_parameter_failed_insert = '()'
```

### The `g:complete_parameter_mapping_complete_for_ft` option
This option set the complete mapping for special typefile. By default, the 
complete mapping is the `g:complete_parameter_mapping_complete` value. But 
you can define other key for a special. For example, you can set the cpp 
complete mapping to `(` and `<`. This option is a map, the key of the map
is filetype, the value is a map too.  The key of the value map is the 
complete mapping key, the value is a string when fail to call the complete. 
Default: `{'cpp': {'(': '()', '<': '<'}}`
```viml
let g:complete_parameter_mapping_complete_for_ft = {'cpp': {'(': '()', '<': '<'}}
```

### The `g:complete_parameter_mapping_goto_next` option
This option set the goto to next paramater mapping. When this mapping was called,
it'll goto to the next parameter.  
Default: `<m-n>`  
```viml
let g:complete_parameter_mapping_goto_next = '<m-n>'
```

### The `g:complete_parameter_goto_next_mode` option
This option set the mapping `g:complete_parameter_mapping_goto_next` mode. 
For example, the value is `iv`, it'll only map 
`g:complete_parameter_mapping_goto_next` in the mode of insert and visual(select).
Default: `ivn`
```viml
let g:complete_parameter_goto_next_mode = 'ivn'
```

### The `g:complete_parameter_mapping_goto_previous` option
This option set the goto to previous paramater mapping. When this mapping was called,
it'll goto to the previous parameter.  
Default: `<m-p>`  
```viml
let g:complete_parameter_mapping_goto_previous = '<m-p>'
```

### The `g:complete_parameter_goto_previous_mode` option
This option set the mapping `g:complete_parameter_mapping_goto_previous` mode. 
For example, the value is `iv`, it'll only map 
`g:complete_parameter_mapping_goto_previous` in the mode of insert and visual(select).
Default: `ivn`
```viml
let g:complete_parameter_goto_previous_mode = 'ivn'
```

### The `g:complete_parameter_mapping_overload_down` option
This option set the select next overload parameters mapping. When this 
mapping was called, it'll delete the current completed paramaters and insert
the next overload parameters. It works only the cursor in the current 
completed parameters. For example, `v.erase(__first, __last)`, only the cursor 
in the `(` and `)`, it can be work. 
Default: `<m-d>`
```viml
let g:complete_parameter_mapping_overload_down = '<m-d>'
```

### The `g:complete_parameter_mapping_overload_down_mode` option
This option set the mapping `g:complete_parameter_mapping_overload_down` mode. 
For example, the value is `iv`, it'll only map 
`g:complete_parameter_mapping_overload_down` in the mode of insert and visual(select).
Default: `ivn`
```viml
let g:complete_parameter_mapping_overload_down_mode = 'ivn'
```

### The `g:complete_parameter_mapping_overload_up` option
This option set the select previous overload parameters mapping. When this 
mapping was called, it'll delete the current completed paramaters and insert
the previous overload parameters. It works only the cursor in the current 
completed parameters. For example, `v.erase(__first, __last)`, only the cursor 
in the `(` and `)`, it can be work. 
Default: `<m-u>`
```viml
let g:complete_parameter_mapping_overload_up = '<m-u>'
```

### The `g:complete_parameter_mapping_overload_up_mode` option
This option set the mapping `g:complete_parameter_mapping_overload_up` mode. 
For example, the value is `iv`, it'll only map 
`g:complete_parameter_mapping_overload_up` in the mode of insert and visual(select).
Default: `ivn`
```viml
let g:complete_parameter_mapping_overload_up_mode = 'ivn'
```

### The `g:complete_parameter_log_level` option
This option set the log level.  
4: only print **error** log.  
2: print **error** and **debug** log.  
1: print **error**, **debug**, **trace**  
Default: 4  
```viml
let g:complete_parameter_log_level = 4
```


# Event
### The `User CompleteParameterFailed` event
When complete failed, this event will be toggle. And the variable 
`g:complete_parameter_last_failed_insert` was assigned the inserted value. 
Eg: 
```viml
autocmd User CompleteParameterFailed if g:complete_parameter_last_failed_insert ==# '()' | call feedkeys("\<LEFT>", 'n') | endif
```


# Supported
**`x` has supported**  

|                | youcompleteme | deoplete            | neocomplete  | completor | clang_complete |
|----------------|---------------|---------------------|--------------|-----------|----------------|
| **c**          | x             | [deoplete-clang][]  |              |           |                |
| **cpp**        | x             | [deoplete-clang][]  |              |           |                |
| **go**         | x             | [deoplete-go][]     | x            | x         |                |
| **python**     | x             | x                   | [jedi-vim][] |           |                |
| **rust**       | x             | [deoplete-rust][]   |              |           |                |
| **javascript** | x             | x                   |              |           |                |
| **typescript** | x             | [nvim-typescript][] |              |           |                |
| **erlang**     | x             |                     |              |           |                |
| **objc**       |               |                     |              |           |                |
| **c#**         |               |                     |              |           |                |


# FAQ
### Can't work with plugin auto-pairs use the default mapping `(`
Because the auto-pairs use `inoremap` to mapping the keys. It can't call this
plugin after the auto-pairs process. You can add the following setting to you
.vimrc, and it'll work well. 
```viml
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
```


### How to accept the selected function but not parameters
You can type `<c-y>` key to accept the selected function and stop completion.
When the popup menu is disappeared, the parameters will not be insert. 


### The mapping `<m-n>` doesn't jump to the next parameter, but delete the selected words. 
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


[deoplete-clang]: https://github.com/zchee/deoplete-clang
[nvim-typescript]: https://github.com/mhartington/nvim-typescript
[deoplete-go]: https://github.com/zchee/deoplete-go
[deoplete-rust]: https://github.com/sebastianmarkow/deoplete-rust
[jedi-vim]: https://github.com/davidhalter/jedi-vim

