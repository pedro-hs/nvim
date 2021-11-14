" Others
augroup HtmlCustom
    au!
    au FileType html setlocal ts=2 sts=2 sw=2
augroup END

let &titlestring=system('echo `basename $(pwd)` \| %t - vi')

nnoremap <silent><leader>xp         :call system('xclip -i -selection clipboard', expand('%'))<cr>
nnoremap <silent><leader>xr         :source ~/.config/nvim/init.vim<cr>:echo 'vimrc updated'<cr>
" end


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
        call ThemeColors()
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

call add(g:centermode_ignore, '_diff_')

nnoremap <silent><leader>xf     :let g:revision_version=0<cr>:call ToggleGitDiff()<cr>
nnoremap <silent><leader>xk     :call GitRevision()<cr>
nnoremap <silent><leader>xj     :call GitRevision(1)<cr>
" end


" Open Image, PDF
fun! OpenFiles()
    " {{{
    silent !xdg-open '%'
    silent bd
endfun
" }}}

augroup OpenFiles
    au!
    au BufEnter *.png,*.jpg,*.jpeg,*.pdf :silent! call OpenFiles()
augroup END
" end
