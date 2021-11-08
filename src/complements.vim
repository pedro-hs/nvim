" Autosave (depends ale)
let g:autosave_on = 1

fun! Autosave()
    " {{{
    if empty(&buftype) && g:autosave_on == 1
        try
            silent ALEFix
            silent write
        catch
            try
                silent write
            catch
                echo
            endtry
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


" Status Line
fun! HideStatusLine()
    " {{{
    let &l:statusline='%1*%{getline(line("w$")+1)}'
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
set statusline+=%{g:autosave_on?'on':'off'}⠀⠀⠀⠀⠀    " auto-save
set statusline+=%l/%L⠀⠀⠀⠀⠀                          " lines
set statusline+=%v⠀⠀⠀⠀⠀                             " column
set statusline+=%m⠀                                 " edit-status
set statusline+=%f⠀⠀⠀⠀⠀                             " file
set statusline+=[%{g:basedir}]⠀⠀⠀⠀⠀                 " project
" }}}
" end


" Center Mode (depends git diff)
fun! ToggleCenterMode()
    " {{{
    if bufwinnr('_diff_') > 0
        return
    endif
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


" Terminal (depends vim current word and fern)
let g:windows = []
let g:buffers = []

fun! ToggleTerminal()
    " {{{
    if exists('b:fern')
        return
    endif
    call RemoveTerminalBuffers()
    if len(g:windows) == 0
        let g:vim_current_word#enabled = 0
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


" Comment
fun! ToggleComment()
    " {{{
    let l:commentstring = GetCommentString()
    if match(getline('.'), "^\\s*" . l:commentstring[0]) == 0
        call Uncomment()
    else
        call Comment()
    endif
endfun
" }}}

fun! GetCommentString()
    " {{{
    let l:commentstring = split(&commentstring, "%s")
    let l:commentstring_result = []
    for item in l:commentstring
        call add(l:commentstring_result, escape(item, '\\/.*$^~[]'))
    endfor
    return l:commentstring_result
endfun
" }}}

fun! Comment()
    " {{{
    let l:commentstring = split(&commentstring, "%s")
    let l:commentstring_end = get(l:commentstring, 1, '')
    let l:commentstring_end = l:commentstring_end != '' ? ' ' . l:commentstring_end : ''
    let l:line = getline('.')
    let l:whitespaces = match(l:line, '\S')
    call setline('.', repeat(' ', l:whitespaces) . l:commentstring[0] . ' ' . trim(l:line) . l:commentstring_end)
endfun
" }}}

fun! Uncomment()
    " {{{
    let l:commentstring = GetCommentString()
    let l:comment = match(getline('.'), "^\\s*" . l:commentstring[0] . ' ') == 0 ? l:commentstring[0] . ' ' : l:commentstring[0]
    call setline('.', substitute(getline('.'), l:comment, '', ''))
    if len(l:commentstring) == 2
        let l:comment = match(getline('.'), "^\\s*" . ' ' . l:commentstring[1]) == 0 ? ' ' . l:commentstring[1] : l:commentstring[1]
        call setline('.', substitute(getline('.'), ' ' . l:comment, '', ''))
    endif
endfun
" }}}

nnoremap <silent><leader>b :call ToggleComment()<cr>
vnoremap <silent><leader>b :call ToggleComment()<cr>
" end


" Dir Colors
fun! DirColors()
    " {{{
    set fillchars+=vert:\⠀
    hi ColorColumn  ctermbg=8 guibg=#11151c
    hi VertSplit    cterm=none
    hi CursorLine   cterm=none
    hi FoldColumn   ctermfg=none ctermbg=none
    hi Folded       ctermfg=none ctermbg=none
endfun
" }}}

call DirColors()
" end


" Highlight Yank
fun! HighlightYank() abort
    " {{{
    let [begin_line, end_line, begin_column, end_column] = [line("'["), line("']"), col("'["), col("']")]
    if begin_line == end_line
        let yank_index = [[begin_line, begin_column, end_column - begin_column + 1]]
    else
        let yank_index = [[begin_line, begin_column, col([begin_line, '$']) - begin_column]] + range(begin_line + 1, end_line - 1) + [[end_line, 1, end_column]]
    endif
    for chunk in range(0, len(yank_index), 8)
        call matchaddpos('Search', yank_index[chunk:chunk + 7])
    endfor
    redraw!
    call timer_start(300, {t_id -> clearmatches()})
endfun
" }}}

augroup HiYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call HighlightYank() | endif
augroup END
" end


" Highlight Current Word
fun! ExistMatchId(id)
    " {{{
  for match in getmatches()
    if get(match, 'id', '-1') == a:id
      return 1
    end
  endfor
  return 0
endfun
" }}}

fun! AddWordHighlight()
    " {{{
    call RemoveWordHighlight()
    call matchadd('Pmenu', '\k*\%#\k*', 0, 666)
    call matchadd('DiffChange', '\%(\k*\%#\k*\)\@!\<\V'.substitute(expand('<cword>'), '\\', '\\\\', 'g').'\m\>', 0, 999)
endfun
" }}}

fun! RemoveWordHighlight()
    " {{{
    for id in [666, 999]
        if ExistMatchId(id)
            call matchdelete(id)
        endif
    endfor
endfun
" }}}

augroup HighlightWord
    au!
    au CursorHold * :call AddWordHighlight()
    au CursorMoved,InsertEnter * :call RemoveWordHighlight()
augroup END
" end
