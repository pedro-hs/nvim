call plug#begin()
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuttie/comfortable-motion.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Lenovsky/nuake'
Plug 'joshdick/onedark.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'puremourning/vimspector'
Plug 'vim-scripts/vim-auto-save'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-lion'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'sheerun/vim-polyglot'
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
set list
set listchars=tab:--,space:.
set cursorline
set colorcolumn=80,120
set encoding=UTF-8
set scrolloff=5
set sidescrolloff=10
set clipboard=unnamedplus
set updatetime=50
set splitbelow
set splitright
set cmdheight=2
set virtualedit=block
set ignorecase
set nobackup
set nowritebackup
set noswapfile

autocmd FileType html setlocal ts=2 sts=2 sw=2

" Visual
vnoremap 99 ^
vnoremap 00 $h
vnoremap <leader>a $A
vnoremap <leader>i 0I

vnoremap zz <esc>:wq<cr>
vnoremap zx <esc>:q!<cr>
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

nnoremap <s-a-j> <c-e>
nnoremap <s-a-k> <c-y>

nnoremap <a-h> <c-o>
nnoremap <a-l> <c-i>

nnoremap <silent> <c-a> :bprevious<cr>
nnoremap <silent> <c-s> :bnext<cr>
nnoremap <silent> <c-x> :bwipeout!<cr>
nnoremap <silent> <c-right> :vertical resize +3<cr>
nnoremap <silent> <c-left> :vertical resize -3<cr>
nnoremap <silent> <c-s-right> :resize +3<cr>
nnoremap <silent> <c-s-left> :resize -3<cr>
nnoremap <silent> <c-h> :wincmd h<cr>
nnoremap <silent> <c-l> :wincmd l<cr>
nnoremap <silent> <c-j> :wincmd j<cr>
nnoremap <silent> <c-k> :wincmd k<cr>

nnoremap <leader>rr :%s///g<left><left>
nnoremap <leader>sa <esc>ggVG
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>c :set ignorecase!<cr>
nnoremap <silent> <leader>x :set relativenumber!<cr>
nnoremap <silent> <leader>p a *<esc>pF*x

nnoremap 99 ^
nnoremap 00 $
nnoremap U <c-r>
nnoremap * *N
nnoremap - ~
nnoremap zc zz
nnoremap zz <esc>:q!<cr>
nnoremap zx <esc>:%bd!<cr><esc>:q!<cr>
nnoremap <silent> ç <esc>i<esc>:noh<cr>
" end

" Insert
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <down>
inoremap <a-l> <right>
inoremap <a-h> <left>
inoremap <a-k> <up>

inoremap <leader>w <esc>:w<cr>
inoremap <leader>9 <esc><s-I>
inoremap <leader>0 <esc><s-A>

inoremap <silent> ç <esc>:noh<cr>
" end

" Line
function! StatuslineGit()
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? ' ('.l:branchname.')' : ''
endfunction

let g:currentmode = {
            \  'n':  'Normal',   'no': 'Pending',  'v':  'Visual',   'V':  'V·Line',     "\<C-V>": 'V·Block',  's':  'Select',  'S':'S·Line',
            \  '^S': 'S·Block',  'i':  'Insert',   'R':  'Replace',  'Rv': 'V·Replace',  'c':      'Command',  'cv': 'Vim Ex',
            \  'ce': 'Ex',       'r':  'Prompt',   'rm': 'More',     'r?': 'Confirm',    '!':      'Shell',    't':  'Terminal'
            \}

set laststatus=2
set statusline=%1*\ %{toupper(g:currentmode[mode()])}%=%<%m%r%h%w%f%5{StatuslineGit()}%5v%5l/%L%5p%%
" end

" Zen mode
function! CenterMode()
    if bufwinnr('diff') > 0
        bd 'diff'
        set nodiff noscrollbind relativenumber nocursorbind
        set nodiff
    endif
    if bufwinnr('_center_') > 0
        wincmd o
        set noequalalways!
    else
        execute 'topleft' ((&columns - &textwidth) / 4) . 'vsplit +setlocal\ nobuflisted _center_' | set nocursorline | set nonu | set nornu | let &l:statusline='%1*%{getline(line("w$")+1)}' | wincmd p
        set noequalalways
    endif
endfunction

autocmd VimEnter * hi VertSplit guifg=bg guibg=bg

nnoremap <silent> m :call CenterMode()<cr>
" end

" Replace All
command! -nargs=+ QFDo call QFDo(<q-args>)

function! QFDo(command)
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
endfunction

nnoremap <leader>ra :silent! QFDo %s///<left><left><c-r>"<right>
" end

" Onedark
set termguicolors

let g:onedark_terminal_italics   = 1
let g:onedark_hide_endofbuffer   = 1

colorscheme onedark
" end

" Git Diff
hi DiffAdd ctermfg=16 ctermbg=65 guifg=#282c34 gui=bold guibg=#5f875f
hi DiffChange ctermfg=59 ctermbg=17 guifg=#abb2bf guibg=#3e4452 cterm=none gui=none
hi DiffText ctermfg=16 ctermbg=65 guifg=#282c34 gui=bold guibg=#5f875f
hi DiffDelete ctermfg=131 ctermbg=131 guifg=#af5f5f guibg=#af5f5f

hi FoldColumn guifg=bg guibg=gb

function! ToggleGitDiff()
    if bufwinnr('diff') > 0
        bd 'diff'
    endif
    if (&diff)
        set nodiff noscrollbind relativenumber nocursorbind
        if bufwinnr('_center_') > 0
            silent wincmd o
            call CenterMode()
        else
            silent wincmd o
        endif
    else
        diffthis
        set norelativenumber
        vsplit 'diff'
        set buftype=nofile bufhidden
        execute "r!git show ".(!"<args>"?'HEAD~1':"<args>").":".expand('#') | 1d_
        let &filetype=getbufvar('#', '&filetype')
        diffthis
        wincmd h
    endif
endfunction

nnoremap <silent> <leader>df :call ToggleGitDiff()<cr>
" end

" Fzf
nnoremap <silent> <leader>ss yiw:Ag <c-r>"<cr>
nnoremap <silent> <leader>sd :Files<cr>
nnoremap <silent> <leader>sf yiw:Ag<cr>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '-m --bind ctrl-a:select-all,ctrl-d:deselect-all'
" end

" NerdTree
let g:NERDTreeMinimalUI              = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeWinPos                 = 'right'
let g:nerdtree_sync_cursorline       = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
            \  'Modified'  :'M', 'Staged'    :'S', 'Untracked' :'U',
            \  'Deleted'   :'D', 'Dirty'     :'*', 'Renamed'   :'R'
            \}

hi NERDTreeDir ctermfg=white
hi NERDTreeExecFile ctermfg=white
hi NERDTreeOpenable ctermfg=white
hi NERDTreeClosable ctermfg=white
hi NERDTreeFlags ctermfg=12 guifg=#6a6c6c

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeHideCWD #^[</].*$# conceal | setlocal concealcursor=n

function! ToggleNERDTreeWithRefresh()
    :NERDTreeToggle
    if(exists("b:NERDTreeType") == 1)
        call feedkeys("R")
    endif
endf

nnoremap <silent> <leader>n :call ToggleNERDTreeWithRefresh()<cr>
" end

" Blamer
let g:blamer_enabled              = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_delay                = 200
" end

" Nuake
function! ToggleNuake()
    if bufwinnr('_center_') > 0
        execute ':Nuake'
        wincmd l
    else
        execute ':Nuake'
    endif
endfunction

nnoremap <silent> <leader>j :Nuake<cr>
inoremap <silent> <leader>j <C-\><C-n>:call ToggleNuake()<cr>
tnoremap <silent> <leader>j <C-\><C-n>:call ToggleNuake()<cr>
" end

" Ale
let g:ale_sign_error   = '✘'
let g:ale_sign_warning = '⚬'
let g:ale_fix_on_save  = 1

let g:ale_linters = {
            \  'python': ['flake8', 'pylint']
            \}

let g:ale_fixers = {
            \  '*': ['remove_trailing_lines', 'trim_whitespace'],
            \  'python': ['isort', 'autopep8'],
            \  'typescript': ['prettier'],
            \  'typescriptreact': ['prettier'],
            \  'markdown': ['prettier'],
            \}

let g:ale_python_flake8_options       = '--ignore=E501'
let g:ale_python_pylint_options       = '--ignore=E501'
let g:ale_python_autopep8_options     = '--max-line-length 120'
let g:ale_javascript_prettier_options = '--single-quote --print-width=140 --arrow-parens=always --trailing-comma=es5 --implicit-arrow-linebreak=beside'

hi ALEWarning guifg=#b7bdc0 guibg=#474646
hi link ALEError ALEWarning
" end

" Semshi
hi semshiSelected ctermbg=242 guifg=#b7bdc0 guibg=#474646
hi link semshiUnresolved ALEWarning
" end

" Coc
let g:coc_global_extensions = [
            \  'coc-tsserver',
            \  'coc-python',
            \  'coc-sql',
            \]

nmap gd <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> coc :CocCommand<cr>

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<c-y>" : "\<c-g>u\<cr>"
else
    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
endif

hi Pmenu guibg=bg
" end

" BufTabline
let g:buftabline_indicators    = 1
" end

" Auto Save
let g:auto_save                = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent         = 1
" end

" Auto Pairs
let g:AutoPairsMultilineClose  = 0
" end
"
" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>vl :call vimspector#Launch()<cr>
nmap <leader>vr :VimspectorReset<cr>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
" end
