" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" TERMINATOR
" apt install terminator
" disable ctrl f
" disable ctrl tab
" change colors
"
" ICONS
" wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
" unzip DroidSansMono.zip -d ~/.fonts
" fc-cache -fv
"
" GIT
" git config --global merge.tool vimdiff
" git config --global mergetool.path nvim
" export EDITOR=nvim
"
" RANGER
" apt install ranger
" .bashrc -> alias rg=ranger
"
" COMFORTABLE MOTION VIM - change keymaps
" nnoremap <silent> <s-a-j> :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> <s-a-k> :call comfortable_motion#flick(-100)<CR>

" Plugins
call plug#begin()
Plug 'w0rp/ale', { 'do': 'pip3 install flake8 isort pylint autopep8' }
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
Plug 'yuttie/comfortable-motion.vim'
Plug 'zchee/deoplete-jedi', { 'do': 'pip3 install pynvim jedi' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Lenovsky/nuake'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

set hidden
set number
set mouse=a
set inccommand=split
set list
set listchars=tab:--,space:.
set cursorcolumn
set cursorline
set colorcolumn=80,120
set encoding=UTF-8
set scrolloff=2
set clipboard=unnamedplus
set updatetime=100
set splitbelow
set splitright

colorscheme onedark

nnoremap <bs> X
nnoremap <c-p> :Files<cr>
nnoremap <c-l> :Ag<cr>
nnoremap <c-y> :w<cr>
nnoremap <esc> :noh<cr>
nnoremap <c-j> :m .+1<cr>==
nnoremap <c-k> :m .-2<cr>==
nnoremap <a-k> <c-y>
nnoremap <a-j> <c-e>
nnoremap <c-a> :bprevious<cr>
nnoremap <c-x> :bnext<cr>
nnoremap <c-z> :enew<cr>
nnoremap <c-s> :bd!<cr>
noremap <silent> <c-right> :vertical resize +1<CR>
noremap <silent> <c-left> :vertical resize -1<CR>
nnoremap <leader>j :noh<cr>

inoremap <leader>j <esc>:noh<cr>
inoremap <c-y> <esc>:w<cr>
inoremap <c-j> <esc>:m .+1<CR>==gi
inoremap <c-k> <esc>:m .-2<CR>==gi
inoremap <a-j> <esc>ja
inoremap <a-l> <esc>la
inoremap <a-h> <esc>ha
inoremap <a-k> <esc>ka
inoremap <leader>[ <esc><s-I>
inoremap <leader>] <esc><s-A>

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" NerdTree
" TODO another keybinds
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <F3> :NERDTreeToggle<CR>

" Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500

" Quake
nnoremap <F4> :Nuake<CR>
inoremap <F4> <C-\><C-n>:Nuake<CR>
tnoremap <F4> <C-\><C-n>:Nuake<CR>

" Ale
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['isort', 'autopep8']
\}
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_python_pylint_options = '--ignore=E501'

" Deoplete
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Jedi
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
