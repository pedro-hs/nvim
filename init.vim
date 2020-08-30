" PLUG VIM
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" TERMINATOR
" apt install terminator  # remove titlebar and window border
"
" SILVER SEARCH
" apt install silversearcher-ag
"
" RANGER
" apt install ranger
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
" BASHRC
" alias rg=ranger
" alias bashrc="cd ~ && nvim .bashrc"
" alias evi="cd ~/.config/nvim && nvim init.vim"
" alias cvi="rm -rf ~/.local/share/nvim/swap/"
"
" COMFORTABLE MOTION VIM - change keymaps
" nnoremap <silent> <s-a-j> :call comfortable_motion#flick(100)<cr>
" nnoremap <silent> <s-a-k> :call comfortable_motion#flick(-100)<cr>

" Plugins
call plug#begin()
Plug 'w0rp/ale', { 'do': 'pip3 install flake8 isort pylint autopep8' } " Python
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
Plug 'yuttie/comfortable-motion.vim'
Plug 'zchee/deoplete-jedi', { 'do': 'pip3 install pynvim jedi' } " Python
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Python
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim' " Python
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

nnoremap <bs> X
nnoremap <c-p> :Files<cr>
nnoremap <c-l> :Ag<cr>
nnoremap <c-y> :w<cr>
nnoremap <silent> <esc> :noh<cr>
nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
nnoremap <a-k> <c-y>
nnoremap <a-j> <c-e>
nnoremap <silent> <c-a> :bprevious<cr>
nnoremap <silent> <c-x> :bnext<cr>
nnoremap <silent> <c-z> :enew<cr>
nnoremap <silent> <c-s> :bd!<cr>
nnoremap <silent> <c-right> :vertical resize +3<cr>
nnoremap <silent> <c-left> :vertical resize -3<cr>
nnoremap <silent> <c-s-right> :resize +3<cr>
nnoremap <silent> <c-s-left> :resize -3<cr>
nnoremap <c-u> <c-r>
nnoremap ss :%s///g<left><left>
nnoremap <silent> çç <esc>:noh<cr>

inoremap <silent> çç <esc>:noh<cr>
inoremap <c-y> <esc>:w<cr>
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <esc>ja
inoremap <a-l> <esc>la
inoremap <a-h> <esc>ha
inoremap <a-k> <esc>ka
inoremap <leader>[ <esc><s-I>
inoremap <leader>] <esc><s-A>

vnoremap <silent> çç <esc>:noh<cr>

cnoremap <c-p> <c-r>"<cr>

colorscheme onedark
hi Directory ctermfg=blue
hi NERDTreeCWD ctermfg=grey
let g:DevIconsEnableFoldersOpenClose = 1

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" NerdTree
let g:NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <leader>n :NERDTreeToggle<cr>

" Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 200

" Quake
nnoremap <silent> <leader>j :Nuake<cr>
inoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>
tnoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>

" Ale " Python
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
let g:ale_python_autopep8_options = '--max-line-length 120'

" Deoplete " Python
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Jedi " Python
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
