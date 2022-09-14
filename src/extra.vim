" Ale
let g:ale_sign_error              = '✘'
let g:ale_sign_warning            = '⚬'
let g:ale_linters_explicit        = 1

let g:ale_linters = {
            \  'python': ['flake8', 'pylint'],
            \  'javascript': ['eslint'],
            \  'javascriptreact': ['eslint'],
            \  'typescript': ['eslint'],
            \  'typescriptreact': ['eslint'],
            \}

let g:ale_fixers = {
            \  '*': ['trim_whitespace'],
            \  'python': ['isort', 'autopep8'],
            \  'javascript': ['prettier'],
            \  'javascriptreact': ['prettier'],
            \  'typescript': ['eslint', 'tslint'],
            \  'typescriptreact': ['eslint', 'tslint'],
            \  'markdown': ['prettier'],
            \}

let g:ale_python_flake8_options       = '--ignore=E501,W504'
let g:ale_python_isort_options        = '--line-length=100'
let g:ale_python_pylint_options       = '--max-line-length 120'
let g:ale_python_autopep8_options     = '--max-line-length 120'
let g:ale_javascript_prettier_options = '--single-quote --print-width=140 --arrow-parens=always --trailing-comma=es5 --implicit-arrow-linebreak=beside'

hi ALEWarning ctermfg=3 guifg=#edb443  ctermbg=4 guibg=#195466
hi link ALEError ALEWarning
hi clear ALEErrorSign
hi clear ALEWarningSign


fun! LintStatus()
    " {{{
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%dW %dE     ', all_warnings, all_errors)
endfun
" }}}

set statusline+=%{LintStatus()}

fun! AutosaveAle()
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

augroup Autosave
    au!
    au TextChanged,InsertLeave * call AutosaveAle()
augroup END
" end


" Semshi
hi link semshiSelected ALEWarning
hi link semshiUnresolved ALEWarning
" end


" Coc
let g:coc_global_extensions = [
            \  'coc-tsserver',
            \  'coc-python',
            \]

nmap <leader>cd <Plug>(coc-definition)
nmap <leader>cr <Plug>(coc-rename)
nmap <silent> coc :CocCommand<cr>

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

fun! s:show_documentation()
    " {{{
    if index(['vim','help'], &filetype) >= 0
        exe 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfun
" }}}

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"

hi HighlightedyankRegion cterm=bold gui=bold ctermbg=0 guibg=#c6c8d1 guifg=#17171b
" end


" Vim Kitty Navigator
let g:kitty_navigator_listening_on_address = 'unix:@mykitty'
let g:kitty_navigator_no_mappings = 1

nnoremap <silent> <c-h> :KittyNavigateLeft<cr>
nnoremap <silent> <c-j> :KittyNavigateDown<cr>
nnoremap <silent> <c-k> :KittyNavigateUp<cr>
nnoremap <silent> <c-l> :KittyNavigateRight<cr>
" end
