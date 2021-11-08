au FileType html setlocal ts=2 sts=2 sw=2

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
        if exists('MINIMAL')
            call ThemeColors()
        endif
    endif
endfun
" }}}

nnoremap <leader>xh :call ToggleHex()<cr>
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

fun! GitBranch()
    " {{{
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? '('.l:branchname.')     ' : ''
endfun
" }}}

set statusline+=%{GitBranch()}

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


" Netrw
if exists('MINIMAL')
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4

    function! ToggleNetrw()
        " {{{
        if exists('t:expl_buf_num')
            let expl_win_num = bufwinnr(t:expl_buf_num)
            let cur_win_num = winnr()
            if expl_win_num != -1
                while expl_win_num != cur_win_num
                    wincmd w
                    let cur_win_num = winnr()
                endwhile
                hide
            endif
            unlet t:expl_buf_num
        else
            vsplit
            Explore
            vertical resize 35
            let t:expl_buf_num = bufnr('%')
        endif
    endfunction
    " }}}

    nnoremap <silent><leader>n :call ToggleNetrw()<cr>
else
    let g:loaded_netrw              = 1
    let g:loaded_netrwPlugin        = 1
    let g:loaded_netrwSettings      = 1
    let g:loaded_netrwFileHandlers  = 1
endif
" end
