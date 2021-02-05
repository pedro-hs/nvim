" Hexadecimal
fun! ToggleHex()
    " {{{
    if !exists("b:isHex") || !b:isHex
        setlocal binary
        silent :e
        let b:isHex=1
        %!xxd
    else
        setlocal nobinary
        let b:isHex=0
        %!xxd -r
    endif
endfun
" }}}

nnoremap <leader>xh :call ToggleHex()<cr>
" end

" Autosave
let g:can_auto_save = 1

fun! Autosave()
    " {{{
    if empty(&buftype) && g:can_auto_save
        try
            silent ALEFix
            silent write
        catch
            echo ''
        endtry
    endif
endfun
" }}}

au InsertLeave * call Autosave()
au TextChanged * call Autosave()
nnoremap <silent><leader>xs :let g:can_auto_save = g:can_auto_save == 0 ? 1 : 0<cr>
" end

" Status Line
fun! StatusLineGit()
    " {{{
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? ' ('.l:branchname.')' : ''
endfun
" }}}

let g:currentmode = {
            \  'n':  'Normal',   'no': 'Pending',  'v':  'Visual',   'V':  'V·Line',     "\<C-V>": 'V·Block',  's':  'Select',  'S':'S·Line',
            \  '^S': 'S·Block',  'i':  'Insert',   'R':  'Replace',  'Rv': 'V·Replace',  'c':      'Command',  'cv': 'Vim Ex',
            \  'ce': 'Ex',       'r':  'Prompt',   'rm': 'More',     'r?': 'Confirm',    '!':      'Shell',    't':  'Terminal'
            \}

fun! LinterStatus()
    " {{{
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%dW %dE   ', all_warnings, all_errors)
endfun
" }}}

fun! AutosaveStatus()
" {{{
    return g:can_auto_save == 1 ? '↻   ' : '⇄   '
endfun
" }}}

set laststatus=2
set statusline=%1*\ %{toupper(g:currentmode[mode()])}%=%<%{AutosaveStatus()}%{LinterStatus()}%f%5{StatusLineGit()}%3v%5l/%L
" end

" Center mode
fun! ToggleCenterMode()
    " {{{
    if bufwinnr('_diff_') <= 0
        if bufwinnr('_center_') > 0
            exe bufnr('_center_') . 'bd'
            setlocal noequalalways! cursorline
        else
            exe 'topleft' ((&columns - &textwidth) / 3) . 'vsplit _center_'
            setlocal nocursorline nonumber norelativenumber nomodifiable nobuflisted buftype=nofile
            let &l:statusline='%1*%{getline(line("w$")+1)}'
            wincmd p
            setlocal noequalalways
        endif
    endif
endfun
" }}}

nnoremap <silent> <leader>a :call ToggleCenterMode()<cr>
" end

" CloseBuffer
fun! CloseBuffer()
    " {{{
    if bufwinnr('_center_') > 0
        call ToggleCenterMode()
        bwipeout!
        wincmd h
        call ToggleCenterMode()
    else
        bwipeout!
    endif
endfun
" }}}

nnoremap <silent> <c-x> :call CloseBuffer()<cr>
" end

" Replace All
command! -nargs=+ QFDo call QFDo(<q-args>)

fun! QFDo(command)
    " {{{
    let buffer_numbers = {}
    for fixlist_entry in getqflist()
        let buffer_numbers[fixlist_entry['bufnr']] = 1
    endfor
    let buffer_number_list = keys(buffer_numbers)
    for num in buffer_number_list
        exe 'buffer' num
        exe a:command
        update
    endfor
endfun
" }}}

nnoremap <leader>ra :silent! QFDo %s///<left><left><c-r>"<right>
" end

" Terminal
let g:term_win = 0
let g:term_buf = 0

fun! ToggleTerminal() abort
    " {{{
    if win_gotoid(g:term_win)
        hide
        set laststatus=2
    else
        if g:term_buf == 0 || !bufexists(str2nr(g:term_buf))
            split | term
            let g:term_buf = bufnr("$")
        else
            exe 'sbuffer' . g:term_buf
        endif
        resize 10
        setlocal laststatus=0 noruler nonumber norelativenumber nobuflisted
        let g:term_win = win_getid()
        startinsert!
    endif
    if bufwinnr('_center_') > 0
        wincmd l
    endif
endfun
" }}}

nnoremap <silent><leader>m :call ToggleTerminal()<cr>
inoremap <silent><leader>m <c-\><c-n>:call ToggleTerminal()<cr>
tnoremap <silent><leader>m <c-\><c-n>:call ToggleTerminal()<cr>
tnoremap <silent><leader>k <c-\><c-n>:exe 'wincmd k'<cr>
tnoremap <silent><leader>n <c-\><c-n>
" end

"  Git Diff
fun! ToggleGitDiff()
    " {{{
    if bufwinnr('_diff_') > 0
        exe bufnr('_diff_') . 'bd'
        diffthis
        set noscrollbind relativenumber nocursorbind nodiff
    else
        diffthis
        set norelativenumber
        vsplit '_diff_'
        exe "r!git show ".(!"<args>"?'HEAD':"<args>").":".expand('#') | 1d_
        setlocal buftype=nofile nomodifiable nobuflisted
        let &filetype=getbufvar('#', '&filetype')
        diffthis
        wincmd h
    endif
endfun
" }}}

nnoremap <silent> <leader>df :call ToggleGitDiff()<cr>
" end
