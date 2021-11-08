set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set autoindent
set expandtab
set nowrap
set relativenumber
set hidden
set number
set mouse=a
set inccommand=split
set cursorline
set colorcolumn=120
set encoding=UTF-8
set sidescrolloff=15
set clipboard+=unnamedplus
set splitbelow
set splitright
set cmdheight=2
set ignorecase
set nobackup
set nowritebackup
set noswapfile
set foldmethod=manual
set noshowmode
set listchars+=tab:--,space:`
set title
let &titlestring=system('echo `basename $(pwd)` \| %t - vi')


augroup Init
    au!
    au FileType vim set foldmethod=marker
    au BufReadPost quickfix nnoremap <buffer> <cr> <cr>
    au InsertLeave * set nolist relativenumber
    au InsertEnter * set list norelativenumber
    au FocusGained,CursorHold * silent! checktime
augroup END


let mapleader = 'z'
let g:omni_sql_no_default_maps = 1
