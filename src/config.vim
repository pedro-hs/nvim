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
set colorcolumn=120
set encoding=UTF-8
set scrolloff=5
set sidescrolloff=10
set clipboard+=unnamedplus
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

let mapleader = 'z'