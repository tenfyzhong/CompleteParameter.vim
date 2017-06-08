"==============================================================
"    file: parse_func.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-07 21:04:00
"==============================================================

function! complete_parameter#parse#go(completed_item)
    let menu = a:completed_item['menu']
    let param = matchlist(menu, '\m[^(]*(\([^(]*\)).*')[1]
    let params = split(param, '\s*,\s*')
    let trim_param = []
    for p in params
        let not_type = substitute(p, '\(\w\+\)\s.*', '\1', '')
        call add(trim_param, not_type)
    endfor
    let param = join(trim_param, ', ')
    let text = '(' . param . ')'
    return [{'text': text, 'delim': ',', 'prefix': '(', 'suffix': ')'}]
endfunction
