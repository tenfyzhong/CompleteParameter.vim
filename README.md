# CompleteParameter.vim [![Build Status](https://travis-ci.org/tenfyzhong/CompleteParameter.vim.svg?branch=master)](https://travis-ci.org/tenfyzhong/CompleteParameter.vim)

[![Join the chat at https://gitter.im/CompleteParameter-vim/Lobby](https://badges.gitter.im/CompleteParameter-vim/Lobby.svg)](https://gitter.im/CompleteParameter-vim/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
CompletEparameter is a plugin for complete function's parameters after complete
a function.  

If you like this plugin, please star it. 


# Screenshots
![cp_screenshorts](https://ooo.0o0.ooo/2017/06/14/5940c34725a1a.gif)


# Features
- Complete parameters after select a complete item from the complete menu. 
- After complete the parameters, jump to the first parameter and the select it. 
- type `<m-n>`(default mapping) to jump to the next parameter in any position. 
- type `<m-p>`(default mapping) to jump to the previous parameter in any position. 


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
Install a complete engine we have supported. Goto the complete item of the
complete menu you want to select, and then type `(`(default mapping), the 
parameters will be completed and jump the the first parameter. 
`<m-n>`/`<m-p>`(default mapping) will jump 
to the next/previous parameter and select it. 


# Mapping
## `(`
Call the parameter completor.

## `<m-n>`
Goto the next parameter and select it.

## `<m-p>`
Goto the previous parameter and select it.


# Options
## The `g:complete_parameter_mapping_complete` option
This option set the complete mapping. When you are in a complete item of the 
complete menu, type this mapping, it'll complete the parameters.   
Default: `(`  
```viml
let g:complete_parameter_mapping_complete = '('
```

## The `b:complete_parameter_mapping_complete` option
This option can set different mapping fo defferent filetype. If this option set 
for a filetype, it'll use this mapping to over the 
`g:complete_parameter_mapping_complete` value when you are edit this file.  
```viml
augroup complete_parameter_setting
    autocmd!
    autocmd FileType go let b:complete_parameter_mapping_complete = '('
augroup END
```

## The `g:complete_parameter_mapping_goto_next` option
This option set the goto to next paramater mapping. When this mapping was called,
it'll goto to the next parameter.  
Default: `<m-n>`  
```viml
let g:complete_parameter_mapping_goto_next = '<m-n>'
```

## The `g:complete_parameter_mapping_goto_previous` option
This option set the goto to previous paramater mapping. When this mapping was called,
it'll goto to the previous parameter.  
Default: `<m-p>`  
```viml
let g:complete_parameter_mapping_goto_previous = '<m-p>'
```

## The `g:complete_parameter_mapping_overload_down` option
This option set the select next overload parameters mapping. When this 
mapping was called, it'll delete the current completed paramaters and insert
the next overload parameters. It works only the cursor in the current 
completed parameters. For example, `v.erase(__first, __last)`, only the cursor 
in the `(` and `)`, it can be work. 
Default: `<m-d>`
```viml
let g:complete_parameter_mapping_overload_down = '<m-d>'
```

## The `g:complete_parameter_mapping_overload_up` option
This option set the select previous overload parameters mapping. When this 
mapping was called, it'll delete the current completed paramaters and insert
the previous overload parameters. It works only the cursor in the current 
completed parameters. For example, `v.erase(__first, __last)`, only the cursor 
in the `(` and `)`, it can be work. 
Default: `<m-u>`
```viml
let g:complete_parameter_mapping_overload_up = '<m-u>'
```

## The `g:complete_parameter_log_level` option
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


# Contributions 
Contributions and pull requests are welcome.


# Thanks
- [johnzeng](https://github.com/johnzeng), support erlang


# LICENSE
MIT License Copyright (c) 2017 tenfyzhong
