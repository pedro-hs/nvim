" Hexadecimal
fun! ToggleHex()
    " {{{
    if !exists('b:isHex') || !b:isHex
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
let g:auto_save_status = '↻   '

fun! Autosave()
    " {{{
    if empty(&buftype) && g:auto_save_status == '↻   '
        try
            silent ALEFix
            silent write
        catch
            echo ''
        endtry
    endif
endfun
" }}}

fun! ToggleAutosave()
    " {{{
    let g:auto_save_status = g:auto_save_status == '↻   ' ? '⇄   ' : '↻   '
endfun
" }}}

au InsertLeave * call Autosave()
au TextChanged * call Autosave()

nnoremap <silent><leader>xs :call ToggleAutosave()<cr>
nnoremap <silent><leader>p :call ToggleAutosave()<cr>a<space><esc>p`[:call ToggleAutosave()<cr>:w<cr>
" end


" Status Line
fun! StatusLineGit()
    " {{{
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? ' ('.l:branchname.')' : ''
endfun
" }}}

fun! LinterStatus()
    " {{{
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%dW %dE   ', all_warnings, all_errors)
endfun
" }}}

let g:currentmode = {
            \  'n':  'Normal',   'no': 'Pending',  'v':  'Visual',   'V':  'V·Line',     "\<C-V>": 'V·Block',  's':  'Select',  'S':'S·Line',
            \  '^S': 'S·Block',  'i':  'Insert',   'R':  'Replace',  'Rv': 'V·Replace',  'c':      'Command',  'cv': 'Vim Ex',
            \  'ce': 'Ex',       'r':  'Prompt',   'rm': 'More',     'r?': 'Confirm',    '!':      'Shell',    't':  'Terminal'
            \}

set laststatus=2
set statusline=%1*\ %{toupper(g:currentmode[mode()])}%=%<%{g:auto_save_status}%{LinterStatus()}%f%5{StatusLineGit()}%3v%5l/%L
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

fun! CloseFile()
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

nnoremap <silent> <c-x> :call CloseFile()<cr>
nnoremap <silent> <leader>a :call ToggleCenterMode()<cr>
" end


" Search and Replace
command! -nargs=+ ReplaceAll call ReplaceAll(<q-args>)
let g:search_full_word = 0

fun! ReplaceAll(command)
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

fun! Search(...) range
    " {{{
    if get(a:, 1, 0)
        let g:search_full_word = g:search_full_word ? 0 : 1
    endif
    let l:default_register = @"
    execute 'normal! vgvy'
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = g:search_full_word ? substitute('\v<'.l:pattern.'>', "\n$", "", "") : substitute(l:pattern, "\n$", "", "")
    let @/ = l:pattern
    let @" = l:default_register
endfun
" }}}

nnoremap <leader>xc :set ignorecase! ignorecase?<cr>
nnoremap <leader>xw :call Search(1)<cr>:set hlsearch<cr>:echo printf('%sfullmatch', g:search_full_word ? '  ' : 'no')<cr>
nnoremap * viwy<esc>:call Search()<cr>:set hlsearch<cr>:echo<cr>
nnoremap # viwy<esc>:call Search()<cr>:set hlsearch<cr>:echo<cr>
nnoremap <leader>rr :%s///g<left><left>
nnoremap <leader>rd :call Search(0, 1)<cr>:set hlsearch<cr>:echo<cr>cgn
nnoremap <leader>ra :silent! ReplaceAll %s///<left><left><c-r>"<right>

vnoremap * ygv<esc>:call Search()<cr>:set hlsearch<cr>:echo<cr>
vnoremap # ygv<esc>:call Search()<cr>:set hlsearch<cr>:echo<cr>
vnoremap <leader>rd <esc>:call Search(0, 1)<cr>:set hlsearch<cr>:echo<cr>cgn
" end


" Terminal
let g:windows = []
let g:buffers = []

fun! ToggleTerminal()
    " {{{
    for buffer in g:buffers
        if !bufexists(buffer)
            let l:buffer_index = index(g:buffers, buffer)
            call remove(g:buffers, l:buffer_index, l:buffer_index)
        endif
    endfor
    if len(g:windows) == 0
        if len(g:buffers) == 0
            split | term
            call add(g:buffers, bufnr('$'))
            call ConfigureTerminalWindow()
        else
            exe 'sbuffer' . g:buffers[0]
            call ConfigureTerminalWindow()
            for buffer in g:buffers[1:-1]
                if bufexists(str2nr(buffer))
                    exe 'vert sb' . buffer
                    call ConfigureTerminalWindow()
                    if len(g:windows) > 2
                        setlocal eadirection=hor equalalways noequalalways
                    endif
                endif
            endfor
        endif
        startinsert!
    else
        for window in g:windows
            let l:window_index = index(g:windows, window)
            call remove(g:windows, l:window_index, l:window_index)
            if win_gotoid(window)
                hide
            endif
        endfor
        set laststatus=2
    endif
endfun
" }}}

fun! NewTerminal()
    " {{{
    if len(g:buffers) > 2
        echo 'Limit of terminals created'
    else
        vsplit | term
        call add(g:buffers, bufnr('$'))
        call ConfigureTerminalWindow()
    endif
    startinsert!
endfun
" }}}

fun! ConfigureTerminalWindow()
    " {{{
    resize 10
    setlocal laststatus=0 noruler nonumber norelativenumber nobuflisted
    call add(g:windows, win_getid())
endfun
" }}}

nnoremap <silent><leader>m :call ToggleTerminal()<cr>

inoremap <silent><leader>m <c-\><c-n>:call ToggleTerminal()<cr>

tnoremap <silent><leader>m <c-\><c-n>:call ToggleTerminal()<cr>
tnoremap <silent><leader>k <c-\><c-n>:exe 'wincmd k'<cr>
tnoremap <silent><leader>l <c-\><c-n>:exe 'wincmd l'<cr>:startinsert!<cr>
tnoremap <silent><leader>h <c-\><c-n>:exe 'wincmd h'<cr>:startinsert!<cr>
tnoremap <silent><leader>M <c-\><c-n>:call NewTerminal()<cr>
tnoremap <silent><leader>n <c-\><c-n>
" end


"  Git Diff
fun! ToggleGitDiff()
    " {{{
    if bufwinnr('_diff_') > 0
        exe bufnr('_diff_') . 'bd'
        diffthis
        set noscrollbind nocursorbind nodiff
    else
        diffthis
        vsplit '_diff_'
        exe "r!git show ".(!"<args>"?'HEAD':"<args>").":".expand('#') | 1d_
        setlocal buftype=nofile nomodifiable nobuflisted norelativenumber
        let &filetype=getbufvar('#', '&filetype')
        let &l:statusline='%1*%{getline(line("w$")+1)}'
        diffthis
        wincmd h
    endif
endfun
" }}}

nnoremap <silent> <leader>df :call ToggleGitDiff()<cr>
" end
