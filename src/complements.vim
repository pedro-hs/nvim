" Hexadecimal
fun! ToggleHex()
    " {{{
    if !exists('b:isHex') || !b:isHex
        setlocal binary
        silent :e
        let b:isHex=1
        %!xxd
        setlocal nomodifiable
        syntax off
    else
        setlocal nobinary modifiable
        let b:isHex=0
        %!xxd -r
        syntax on
        call SetColors()
    endif
endfun
" }}}

nnoremap <leader>xh :call ToggleHex()<cr>
" end


" Autosave (depends ale)
let g:autosave_on = 1

fun! Autosave()
    " {{{
    if empty(&buftype) && g:autosave_on == 1
        try
            silent ALEFix
            silent write
        catch
            echo
        endtry
    endif
endfun
" }}}

fun! ToggleAutosave()
    " {{{
    let g:autosave_on = !g:autosave_on
endfun
" }}}

au TextChanged,InsertLeave * call Autosave()

nnoremap <silent><leader>xs :call ToggleAutosave()<cr>
nnoremap <silent><leader>p :call ToggleAutosave()<cr>a<space><esc>p`[:call ToggleAutosave()<cr>:w<cr>
" end


" Status Line (depends ale)
fun! StatusLineGit()
    " {{{
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? l:branchname : ''
endfun
" }}}

fun! HideStatusLine()
    " {{{
    let &l:statusline='%1*%{getline(line("w$")+1)}'
endfun
" }}}

fun! LintStatus()
    " {{{
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%dW %dE', all_warnings, all_errors)
endfun
" }}}

" {{{
let g:basedir = system("`echo basename $(pwd)` | tr -d '\n'")
let g:currentmode = {
            \  'n':  'Normal',   'no': 'Pending',  'v':  'Visual',   'V':  'V·Line',     "\<C-V>": 'V·Block',  's':  'Select',  'S':'S·Line',
            \  '^S': 'S·Block',  'i':  'Insert',   'R':  'Replace',  'Rv': 'V·Replace',  'c':      'Command',  'cv': 'Vim Ex',
            \  'ce': 'Ex',       'r':  'Prompt',   'rm': 'More',     'r?': 'Confirm',    '!':      'Shell',    't':  'Terminal'
            \}

set laststatus=2
set statusline=%1*⠀⠀                                " color
set statusline+=%{toupper(g:currentmode[mode()])}   " mode
set statusline+=%=                                  " divider
set statusline+=%{LintStatus()}⠀⠀⠀⠀⠀                " lint
set statusline+=%{g:autosave_on?'on':'off'}⠀⠀⠀⠀⠀    " auto-save
set statusline+=%l/%L⠀⠀⠀⠀⠀                          " lines
set statusline+=%v⠀⠀⠀⠀⠀                             " column
set statusline+=%m⠀                                 " edit-status
set statusline+=%f⠀⠀⠀⠀⠀                             " file
set statusline+=(%{StatusLineGit()})⠀⠀⠀⠀⠀           " git-branch
set statusline+=[%{g:basedir}]⠀⠀⠀⠀⠀                 " project
" }}}
" end


" Center Mode
fun! ToggleCenterMode()
    " {{{
    if bufwinnr('_diff_') <= 0
        if bufwinnr('_center_') > 0
            exe bufnr('_center_') . 'bd'
            setlocal noequalalways! cursorline
        else
            exe 'topleft' ((&columns - &textwidth) / 4) . 'vsplit _center_'
            setlocal nocursorline nonumber norelativenumber nomodifiable nobuflisted buftype=nofile
            call HideStatusLine()
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


" Replace Text In Working Directory
command! -nargs=+ ReplaceAll call ReplaceAll(<q-args>)

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

nnoremap <leader>ra :silent! ReplaceAll %s///<left><left><c-r>"<right>
" end


" Terminal (depends vim current word)
let g:windows = []
let g:buffers = []

fun! ToggleTerminal()
    " {{{
    if (exists('b:fern'))
        return
    endif
    call RemoveTerminalBuffers()
    let g:vim_current_word#enabled = 1
    if len(g:windows) == 0
        if len(g:buffers) == 0
            let g:vim_current_word#enabled = 0
            split | term
            call add(g:buffers, bufnr('$'))
            call ConfigureTerminalWindow()
        else
            let g:vim_current_word#enabled = 0
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
        let g:vim_current_word#enabled = 1
        set laststatus=2
    endif
endfun
" }}}

fun! NewTerminal()
    " {{{
    if len(g:buffers) > 3
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

fun! RemoveTerminalBuffers()
    " {{{
    for buffer in g:buffers
        if !bufexists(buffer)
            let l:buffer_index = index(g:buffers, buffer)
            call remove(g:buffers, l:buffer_index, l:buffer_index)
        endif
    endfor
endfun
" }}}

nnoremap <silent><leader>m :call ToggleTerminal()<cr>

inoremap <silent><leader>m <c-\><c-n>:call ToggleTerminal()<cr>

tnoremap <silent><leader>m <c-\><c-n>:call ToggleTerminal()<cr><esc>
tnoremap <silent><c-k> <c-\><c-n>:exe 'wincmd k'<cr>
tnoremap <silent><c-l> <c-\><c-n>:exe 'wincmd l'<cr>
tnoremap <silent><c-h> <c-\><c-n>:exe 'wincmd h'<cr>
tnoremap <silent><c-j> <c-\><c-n>:exe 'wincmd h'<cr>
tnoremap <silent><leader>n <c-\><c-n>:call NewTerminal()<cr>
tnoremap <silent><leader>i <c-\><c-n>
tnoremap <silent><c-d> <c-\><c-n>:call RemoveTerminalBuffers()<cr>:bwipeout!<cr>

au BufWinEnter,WinEnter term://* startinsert
" end


" Git Complements
let g:revision_version = 0

fun! ToggleGitDiff()
    " {{{
    if bufwinnr('_diff_') > 0
        exe bufnr('_diff_') . 'bd'
        diffthis
        setlocal noscrollbind nocursorbind nodiff
    else
        diffthis
        vsplit '_diff_'
        exe "r!git show ".(!"<args>" ? 'HEAD~' . g:revision_version : "<args>") . ":" . expand('#') | 1d_
        setlocal buftype=nofile nomodifiable nobuflisted norelativenumber
        let &filetype=getbufvar('#', '&filetype')
        call HideStatusLine()
        diffthis
        wincmd h
    endif
endfun
" }}}

fun! GitRevision(...)
    " {{{
    if bufwinnr('_diff_') > 0
        call ToggleGitDiff()
    endif
    let g:revision_version = get(a:, 1, 0) ? g:revision_version + 1 : g:revision_version - 1
    let g:revision_version = g:revision_version >= 0 ? g:revision_version : 0
    call ToggleGitDiff()
    echo 'Revision ' . g:revision_version
endfun
" }}}

nnoremap <silent> <leader>df :let g:revision_version=0<cr>:call ToggleGitDiff()<cr>
nnoremap <silent> <leader>dl :call GitRevision()<cr>
nnoremap <silent> <leader>dh :call GitRevision(1)<cr>
" end


" Open Image, PDF
fun! OpenFiles()
    " {{{
    silent !xdg-open '%'
    silent bd
endfun
" }}}

au BufEnter *.png,*.jpg,*.jpeg,*.pdf :silent! call OpenFiles()
" end


" Scroll
set scrolloff=5
nnoremap <silent><leader>c :let &scrolloff=999-&scrolloff<cr>:set scrolloff?<cr>
let &scrolloff=999-&scrolloff
au TermEnter * setlocal scrolloff=0
au TermLeave * let &scrolloff=999-&scrolloff
" end


" Visual Search
fun! s:GetSelectedText()
    " {{{
    let l:old_register = getreg('"')
    let l:old_register_type = getregtype('"')
    norm gvy
    let l:new_register = getreg('"')
    call setreg('"', l:old_register, l:old_register_type)
    exe "norm \<esc>"
    return l:new_register
endfun
" }}}

vnoremap <silent> * :call setreg("/", substitute(<SID>GetSelectedText(), '\_s\+', '\\_s\\+', 'g'))<cr>nN
" end
