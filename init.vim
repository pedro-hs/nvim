call plug#begin()
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yuttie/comfortable-motion.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Lenovsky/nuake'
Plug 'lervag/vimtex'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'sheerun/vim-polyglot'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
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
set cursorcolumn
set cursorline
set colorcolumn=80,120,140
set encoding=UTF-8
set scrolloff=3
set clipboard=unnamedplus
set updatetime=50
set splitbelow
set splitright
set virtualedit=block
set cmdheight=2

vnoremap <silent> ç <esc>:noh<cr>
vnoremap <silent> Ç <esc>:noh<cr>
vnoremap - ~
vnoremap 99 ^
vnoremap ^ 0
vnoremap 00 $h

cnoremap <c-p> \<c-r>"<cr>
cnoremap <c-o> <c-r>"<cr>

nnoremap <bs> X
nnoremap <c-p> :Files<cr>
nnoremap <c-l> :Ag<cr>
nnoremap <c-y> :w<cr>
nnoremap <silent> <esc> :noh<cr>
nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
nnoremap <s-a-k> <c-y>
nnoremap <s-a-j> <c-e>
nnoremap <silent> <c-a> :bprevious<cr>
nnoremap <silent> <c-s> :bnext<cr>
nnoremap <silent> <c-x> :bwipeout!<cr>
nnoremap <silent> <c-right> :vertical resize +3<cr>
nnoremap <silent> <c-left> :vertical resize -3<cr>
nnoremap <silent> <c-s-right> :resize +3<cr>
nnoremap <silent> <c-s-left> :resize -3<cr>
nnoremap <c-u> <c-r>
nnoremap <c-r> :%s///g<left><left>
nnoremap <silent> ç <esc>:noh<cr>
nnoremap <silent> Ç <esc>:noh<cr>
nnoremap <silent> <leader>x :set relativenumber!<cr>
nnoremap <silent> <leader>c :set ignorecase!<cr>
nnoremap - ~
nnoremap 99 ^
nnoremap ^ 0
nnoremap 00 $

inoremap <silent> <leader>x :set relativenumber!<cr>
inoremap <silent> ç <esc>:noh<cr>
inoremap <silent> Ç <esc>:noh<cr>
inoremap <c-y> <esc>:w<cr>
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <esc>ja
inoremap <a-l> <esc>la
inoremap <a-h> <esc>ha
inoremap <a-k> <esc>ka
inoremap <leader>0 <esc><s-A>
inoremap <leader>9 <esc><s-I>

" Quantum
set termguicolors
let g:quantum_black=1
colorscheme quantum

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" NerdTree
let g:NERDTreeMinimalUI = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeWinPos = "right"
hi NERDTreeCWD ctermfg=white
hi NERDTreeDir ctermfg=white
hi NERDTreeExecFile ctermfg=white
hi NERDTreeOpenable ctermfg=white
hi NERDTreeClosable ctermfg=white
hi NERDTreeFlags ctermfg=12 guifg=#6a6c6c
let g:NERDTreeGitStatusIndicatorMapCustom = {
\  'Modified'  :'M',
\  'Staged'    :'S',
\  'Untracked' :'U',
\  'Renamed'   :'R',
\  'Deleted'   :'D',
\  'Dirty'     :'*',
\}
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <leader>n :NERDTreeToggle<cr>
let g:nerdtree_sync_cursorline = 1

" Blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_delay = 200

" Quake
nnoremap <silent> <leader>j :Nuake<cr>
inoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>
tnoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>

" Ale
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚬'
hi ALEWarning guifg=#b7bdc0 guibg=#474646
hi ALEError guifg=#292929 guibg=#b7bdc0
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'python': ['flake8', 'pylint'],
\}
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'python': ['isort', 'autopep8'],
\  'typescript': ['prettier'],
\  'typescriptreact': ['prettier'],
\}
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_python_pylint_options = '--ignore=E501'
let g:ale_python_autopep8_options = '--max-line-length 120'
let g:ale_javascript_prettier_options = '--single-quote --print-width=140 --arrow-parens=always --trailing-comma=es5 --implicit-arrow-linebreak=beside'

" Semshi
hi semshiSelected ctermbg=242 guifg=#b7bdc0 guibg=#474646
hi link semshiUnresolved ALEError

" Vimtex
let g:tex_flavor = 'latex'

" Coc
let g:coc_global_extensions = [
\  'coc-tsserver',
\  'coc-python',
\  'coc-vimtex',
\]
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> coc :CocCommand<cr>
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
hi Pmenu guibg=#292929
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









" TODO
" Global search and replace with on and off case in fzf
" Git diff
" Autoimport
" config mg979/vim-visual-multi
"
" INSTALL
" apt install silversearcher-ag ranger latexmk terminator nvim
"
" PLUG VIM
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" PIP
" pip3 install flake8 isort pylint autopep8 pynvim jedi
"
" ICONS
" wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
" unzip DroidSansMono.zip -d ~/.fonts
" fc-cache -fv
"
" COMFORTABLE MOTION VIM
" nnoremap <silent> <a-j> :call comfortable_motion#flick(100)<cr>
" nnoremap <silent> <a-k> :call comfortable_motion#flick(-100)<cr>
"
" BASHRC
" alias python=python3.6
" alias pip=pip3
" alias rg=ranger
" alias bashrc="cd ~ && nvim .bashrc"
" alias evi="cd ~/.config/nvim && nvim init.vim"
" alias cvi="rm -rf ~/.local/share/nvim/swap/"
" alias penv="source env/bin/activate"
" alias pvenv="source venv/bin/activate"
" alias src="cd ~/Documents/src"
" PS1='\w\[\033[32m\]$(__git_ps1)\n \$\[\033[0m\] '
" alias gis="git status -su"
"
" GOOGLE CHROME VIMIUM
" VSCODE VIM
 " SUBLIME VINTAGE
