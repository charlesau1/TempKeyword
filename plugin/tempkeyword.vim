" tempkeyword.vim - TempKeyword
" Author:           BlueCat <BlueCat.Me@gmail.com>
" Version:          1.1
" Description:      Inspired from fcamel's work. Make it more flexible.
" Site:             http://bluecat.csie.net/2011/05/21/5400/
" Git:              git://github.com/BlueCatMe/TempKeyword.git
" Last Modified:    2011/05/23
"
" Licensed under the same terms as Vim itself.
"
" ============================================================================
"
" Default Usage:
"
" Assume <leader> is default value, use \0 ~ \9 to add keywords to group 0 ~ 9.
" \c0 ~ \c9 can clear corresponding groups.
" \ca can clear all groups.
"
" Customization:
"
" Set TempKeywordCmdPrefix to change prefix command.
" Use DeclareTempKeyword to add more groups with customized color.
"

let TempKeywordCmdPrefix = "<leader>"
function! DeclareTempKeyword(key, decoration, bg, fg)
    let group_name = 'TempKeyword' . a:key
    let cmd = 'highlight ' . group_name . ' gui=' . a:decoration . ' cterm=' . a:decoration . ' ctermbg=' . a:bg . ' ctermfg=' . a:fg . ' guibg=' . a:bg . ' guifg=' . a:fg

    execute cmd
    let cmd = 'nmap '. g:TempKeywordCmdPrefix . a:key . ' :call AddTempKeywords("' . a:key . '", "<C-R>=expand("<cword>")<CR>")<CR>'
    execute cmd
    let cmd = 'nmap ' . g:TempKeywordCmdPrefix . 'c' . a:key . ' :call DeleteTempKeywords("' . a:key . '")<CR>'
    execute cmd
endfunction
function! AddTempKeywords(index, pattern)
    let list_name = 'g:TempKeywordList' . a:index
    let group_name = 'TempKeyword' . a:index
    if !exists(list_name)
        let {list_name} = []
    endif
    let {list_name} = add({list_name}, matchadd(group_name, '\<' . a:pattern . '\>'))
    return len({list_name})
endfunction
function! DeleteTempKeywords(index)
    let list_name = 'g:TempKeywordList' . a:index
    if !exists(list_name)
        return -1
    endif
    for id in {list_name}
        if id != ''
            call matchdelete(id)
        endif
    endfor
    let {list_name} = []
    return 0
endfunction
call DeclareTempKeyword('1k', 'underline,bold', 'Blue', 'White')
call DeclareTempKeyword('2k', 'underline,bold', 'DarkMagenta', 'White')
call DeclareTempKeyword('3k', 'underline,bold', 'DarkCyan', 'White')
call DeclareTempKeyword('4k', 'underline,bold', 'Brown', 'White')
call DeclareTempKeyword('5k', 'underline,bold', 'DarkRed', 'White')
call DeclareTempKeyword('6k', 'underline,bold', 'DarkYellow', 'White')
call DeclareTempKeyword('7k', 'underline,bold', 'DarkGreen', 'White')
call DeclareTempKeyword('8k', 'underline,bold', 'DarkBlue', 'White')
call DeclareTempKeyword('9k', 'underline,bold', 'lightRed', 'Black')
call DeclareTempKeyword('0k', 'underline,bold', 'DarkYellow', 'Black')
let cmd = 'nmap ' . TempKeywordCmdPrefix . 'ca :call clearmatches()<CR>'
execute cmd
