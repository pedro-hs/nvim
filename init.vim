call plug#begin()
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'yuttie/comfortable-motion.vim'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'cocopon/iceberg.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
" Plug 'puremourning/vimspector'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-lion'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'sheerun/vim-polyglot'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
call plug#end()

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab
set nowrap
set relativenumber
set hidden
set number
set mouse=a
set inccommand=split
set cursorline
set encoding=UTF-8
set scrolloff=5
set sidescrolloff=10
set clipboard=unnamedplus
set updatetime=50
set splitbelow
set splitright
set cmdheight=2
set ignorecase
set nobackup
set nowritebackup
set noswapfile
set foldmethod=marker
set noshowmode
set listchars+=tab:--,space:`

au FileType html setlocal ts=2 sts=2 sw=2
au BufReadPost quickfix nnoremap <buffer> <cr> <cr>
au InsertLeave * set nolist relativenumber
au InsertEnter * set list norelativenumber

" Visual
vnoremap <leader>j ^
vnoremap <leader>k $h
vnoremap <leader>a $A
vnoremap <leader>i 0I
vnoremap <leader>f y/<c-r>"<cr>
vnoremap <leader>F y/\<<c-r>"\><cr>

vnoremap zz <esc>:wq<cr>
vnoremap zx <esc>:q!<cr>
vnoremap p pgvy
vnoremap <silent> ç <esc>:noh<cr>
" end

" Command
cnoremap <c-p> <c-r>"
cnoremap <c-o> \<c-r>"
" end

" Normal
nnoremap <bs> X
nnoremap <space> i<space><esc>l
nnoremap <c-m> i<cr><esc>
nnoremap <tab> i<tab><esc>l

nnoremap <a-h> <c-o>
nnoremap <a-l> <c-i>
nnoremap <a-s-k> <c-y>
nnoremap <a-s-j> <c-e>

nnoremap <silent> <right> :vertical resize +3<cr>
nnoremap <silent> <left>  :vertical resize -3<cr>
nnoremap <silent> <up>    :resize +3<cr>
nnoremap <silent> <down>  :resize -3<cr>

nnoremap <silent> <c-a> :bprevious<cr>
nnoremap <silent> <c-s> :bnext<cr>
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-l> :wincmd l<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>

nnoremap <leader>rr :%s///g<left><left>
nnoremap <silent> <leader>w :w<cr>
nnoremap <leader>xa <esc>ggVG
nnoremap <silent> <leader>xc :set ignorecase!<cr>
nnoremap <silent> <leader>xp :call system("xclip -i -selection clipboard", expand("%"))<CR>
nnoremap <silent> <leader>p a *<esc>pF*x
nnoremap <leader>j ^
nnoremap <leader>k $

nnoremap U <c-r>
nnoremap * viwy*N
nnoremap - ~
nnoremap zc zz
nnoremap zz <esc>:q!<cr>
nnoremap zx <esc>:%bd!<cr><esc>:q!<cr>
nnoremap <silent> ç <esc>:noh<cr>:echo ''<cr>
" end

" Insert
inoremap <silent> <c-j> <esc>:m .+1<cr>==gi
inoremap <silent> <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <down>
inoremap <a-l> <right>
inoremap <a-h> <left>
inoremap <a-k> <up>

inoremap <leader>w <esc>:w<cr>
inoremap <leader>j <esc><s-I>
inoremap <leader>k <esc><s-A>

inoremap <silent> ç <esc>:noh<cr>
" end

" Iceberg
set termguicolors
colorscheme iceberg
" end

" Hexadecimal
function ToggleHex()
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
endfunction
" }}}

nnoremap <leader>xh :call ToggleHex()<cr>
" end

" Autosave
fun! Autosave()
    " {{{
    if empty(&buftype)
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
" end

" Status Line
fun! StatusLineGit()
    " {{{
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? ' ('.l:branchname.')' : ''
endfun

let g:currentmode = {
            \  'n':  'Normal',   'no': 'Pending',  'v':  'Visual',   'V':  'V·Line',     "\<C-V>": 'V·Block',  's':  'Select',  'S':'S·Line',
            \  '^S': 'S·Block',  'i':  'Insert',   'R':  'Replace',  'Rv': 'V·Replace',  'c':      'Command',  'cv': 'Vim Ex',
            \  'ce': 'Ex',       'r':  'Prompt',   'rm': 'More',     'r?': 'Confirm',    '!':      'Shell',    't':  'Terminal'
            \}
" }}}

set laststatus=2
set statusline=%1*\ %{toupper(g:currentmode[mode()])}%=%<%m%r%h%w%f%5{StatusLineGit()}%5v%5l/%L%5p%%
" end

" Center mode
fun! ToggleCenterMode()
    " {{{
    if bufwinnr('_diff_') <= 0
        if bufwinnr('_center_') > 0
            wincmd o
            setlocal noequalalways!
        else
            exe 'topleft' ((&columns - &textwidth) / 4) . 'vsplit +setlocal\ nobuflisted _center_'
            setlocal nocursorline nonumber norelativenumber
            let &l:statusline='%1*%{getline(line("w$")+1)}'
            wincmd p
            setlocal noequalalways
        endif
    endif
endfun
" }}}

nnoremap <silent> <leader>z :call ToggleCenterMode()<cr>
" end

" CloseBuffer
fun! CloseBuffer()
    " {{{
    if bufwinnr('_center_') > 0
        call ToggleCenterMode()
        bwipeout!
        bnext
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
        bd '_diff_'
        set nodiff noscrollbind relativenumber nocursorbind
    else
        diffthis
        set norelativenumber
        vsplit '_diff_'
        setlocal buftype=nofile bufhidden
        exe "r!git show ".(!"<args>"?'HEAD':"<args>").":".expand('#') | 1d_
        let &filetype=getbufvar('#', '&filetype')
        diffthis
        wincmd h
    endif
endfun
" }}}

nnoremap <silent> <leader>df :call ToggleGitDiff()<cr>
" end

" Fzf
nnoremap <silent> <leader>ss yiw:Ag <c-r>"<cr>
nnoremap <silent> <leader>sd :Files<cr>
nnoremap <silent> <leader>sc :GFiles?<cr>
nnoremap <silent> <leader>sf yiw:Ag<cr>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '-m --bind ctrl-a:select-all,ctrl-d:deselect-all'
" end

" NerdTree
let g:NERDTreeMinimalUI              = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeWinPos                 = 'right'
let g:nerdtree_sync_cursorline       = 1
let g:NERDTreeStatusline             = '%#NonText#'
let g:NERDTreeAutoDeleteBuffer       = 1
let g:NERDTreeQuitOnOpen             = 1
let g:NERDTreeMouseMode              = 3

let g:NERDTreeGitStatusIndicatorMapCustom = {
            \  'Modified'  :'M', 'Staged'    :'S', 'Untracked' :'U',
            \  'Deleted'   :'D', 'Dirty'     :'*', 'Renamed'   :'R'
            \}

hi NERDTreeDir ctermfg=white
hi NERDTreeExecFile ctermfg=white
hi NERDTreeOpenable ctermfg=white
hi NERDTreeClosable ctermfg=white
hi NERDTreeFlags ctermfg=12 guifg=#6a6c6c

au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

fun! ToggleNERDTree()
    " {{{
    :NERDTreeToggle
    if(exists("b:NERDTreeType") == 1)
        call feedkeys("R")
    endif
endfun
" }}}

nnoremap <silent> <leader>n :call ToggleNERDTree()<cr>
" end

" Blamer
let g:blamer_enabled              = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_delay                = 200
" end

" Ale
let g:ale_sign_error              = '✘'
let g:ale_sign_warning            = '⚬'
let g:ale_linters_explicit        = 1

let g:ale_linters = {
            \  'python': ['flake8', 'pylint'],
            \  'typescript': ['eslint'],
            \  'typescriptreact': ['eslint'],
            \}

let g:ale_fixers = {
            \  '*': ['trim_whitespace'],
            \  'python': ['isort', 'autopep8'],
            \  'typescript': ['eslint'],
            \  'typescriptreact': ['eslint'],
            \  'markdown': ['prettier'],
            \}

let g:ale_python_flake8_options       = '--ignore=E501,W504'
let g:ale_python_autopep8_options     = '--max-line-length 120'
let g:ale_javascript_prettier_options = '--single-quote --print-width=120'

hi ALEWarning guifg=#b7bdc0 guibg=#474646
hi link ALEError ALEWarning
hi clear ALEErrorSign
hi clear ALEWarningSign
" end

" Semshi
hi semshiSelected ctermbg=242 guifg=#b7bdc0 guibg=#474646
hi link semshiUnresolved ALEWarning
" end

" Coc
let g:coc_global_extensions = [
            \  'coc-tsserver',
            \  'coc-python',
            \]

nmap cd <Plug>(coc-definition)
nmap <leader>cr <Plug>(coc-rename)
nmap <silent> coc :CocCommand<cr>

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

fun! s:show_documentation()
    " {{{
    if (index(['vim','help'], &filetype) >= 0)
        exe 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfun
" }}}

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<c-y>" : "\<c-g>u\<cr>"
else
    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
endif

" end

" BufTabline
let g:buftabline_indicators    = 1
" end

" Auto Pairs
let g:AutoPairsMultilineClose  = 0
" end

" Visual Multi
let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<a-m>'
let g:VM_maps["Select Cursor Up"]   = '<a-M>'
let g:VM_Mono_hl   = 'StatusLine'
let g:VM_Cursor_hl = 'StatusLine'
let g:VM_Extend_hl = 'StatusLine'
let g:VM_Insert_hl = 'StatusLine'
let g:VM_highlight_matches = ''
" end

" Clever F
let g:clever_f_mark_char_color = 'IncSearch'
" end

" Emmet
let g:user_emmet_leader_key='\'
" end

" Git Gutter
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_modified_removed = '▌'

hi GitGutterAdd          guibg=bg
hi GitGutterChange       guibg=bg
hi GitGutterDelete       guibg=bg
hi GitGutterChangeDelete guibg=bg
"  end

" Highlight
hi TabLineSel  cterm=bold   gui=bold guifg=#D8DEE9 ctermfg=none ctermbg=none guibg=bg
hi TabLine     ctermbg=none guibg=bg
hi TabLineFill guifg=bg

hi LineNr     ctermbg=bg  guibg=bg
hi SignColumn ctermbg=bg  guibg=bg
hi VertSplit  guifg=bg    guibg=bg
hi FoldColumn guibg=bg
hi Folded     ctermfg=0   guifg=#3B4252   guibg=#2E3440 ctermfg=none  ctermbg=none guibg=bg
hi Pmenu      guibg=bg

hi DiffAdd    ctermfg=159 ctermbg=23  guifg=#b3c3cc guibg=#384851
hi DiffDelete ctermbg=224 ctermfg=224 guifg=#53343b guibg=#53343b
"  end

" Vimspector
" let g:vimspector_enable_mappings = 'HUMAN'

" nmap <leader>vl :call vimspector#Launch()<cr>
" nmap <leader>vr :VimspectorReset<cr>
" nmap <leader>ve :VimspectorEval
" nmap <leader>vw :VimspectorWatch
" nmap <leader>vo :VimspectorShowOutput
" end
