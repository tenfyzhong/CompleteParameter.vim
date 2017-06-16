# CompleteParameter.vim

[![Join the chat at https://gitter.im/tenfyzhong/CompleteParameter.vim](https://badges.gitter.im/tenfyzhong/CompleteParameter.vim.svg)](https://gitter.im/tenfyzhong/CompleteParameter.vim?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/tenfyzhong/CompleteParameter.vim.svg?branch=master)](https://travis-ci.org/tenfyzhong/CompleteParameter.vim)
[![GitHub tag](https://img.shields.io/github/tag/tenfyzhong/CompleteParameter.vim.svg)]()
[![Vim Version](https://img.shields.io/badge/support-Vim%207.4.2367%E2%86%91%20or%20NVIM-yellowgreen.svg?style=flat)]()
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
echo 'set rtp+=~/.vim/bundle/CompleteParameter.vim'
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
Call the parameter completor.

### `<m-n>`
Goto the next parameter and select it.

### `<m-p>`
Goto the previous parameter and select it.

### `<m-d>`
Select the next overload function. 

### `<m-u>`
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

### The `g:complete_parameter_mapping_goto_previous` option
This option set the goto to previous paramater mapping. When this mapping was called,
it'll goto to the previous parameter.  
Default: `<m-p>`  
```viml
let g:complete_parameter_mapping_goto_previous = '<m-p>'
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

### The `g:complete_parameter_log_level` option
This option set the log level.  
4: only print **error** log. 
2: print **error** and **debug** log.
1: print **error**, **debug**, **trace**
Default: 4
```viml
let g:complete_parameter_log_level = 4
```


# Supported
## Supported Complete Engine
- [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

## Supported Language
- golang
- erlang
- c
- c++
- python
- javascript
- rust

# Todo
- support language: objc
- support language: c#
- support language: typescript
- support engine: [completor.vim](https://github.com/maralla/completor.vim)
- support engine: [neocomplete.vim](https://github.com/Shougo/neocomplete.vim)
- support engine: [deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
- support engine: [clang_complete](https://github.com/Rip-Rip/clang_complete)
- support nvim


# FAQ
### Can't work with plugin auto-pairs use the default mapping `(`
Because the auto-pairs use `inoremap` to mapping the keys. It can't call this
plugin after the auto-pairs process. You can add the following setting to you
.vimrc, and it'll work well. 
```viml
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
```


# Contributions 
Contributions and pull requests are welcome.


# Thanks
- [johnzeng](https://github.com/johnzeng), support erlang


# LICENSE
MIT License Copyright (c) 2017 tenfyzhong
