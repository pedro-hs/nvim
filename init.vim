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
Plug 'sheerun/vim-polyglot'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

set expandtab
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
set scrolloff=3
set clipboard=unnamedplus
set updatetime=50
set splitbelow
set splitright
set virtualedit=block
set cmdheight=2

vnoremap <silent> ç <esc>:noh<cr>

cnoremap <c-p> <c-r>"<cr>

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
nnoremap <silent> <c-s> :bwipeout!<cr>
nnoremap <silent> <c-right> :vertical resize +3<cr>
nnoremap <silent> <c-left> :vertical resize -3<cr>
nnoremap <silent> <c-s-right> :resize +3<cr>
nnoremap <silent> <c-s-left> :resize -3<cr>
nnoremap <c-u> <c-r>
nnoremap ss :%s///g<left><left>
nnoremap <silent> ç <esc>:noh<cr>

inoremap <silent> ç <esc>:noh<cr>
inoremap <c-y> <esc>:w<cr>
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <esc>ja
inoremap <a-l> <esc>la
inoremap <a-h> <esc>ha
inoremap <a-k> <esc>ka
inoremap <leader>[ <esc><s-I>
inoremap <leader>] <esc><s-A>

" Quantum
set termguicolors
let g:quantum_black=1
colorscheme quantum

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" NerdTree
let g:NERDTreeMinimalUI = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeWinPos = "right"
hi NERDTreeCWD ctermfg=grey
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <leader>n :NERDTreeToggle<cr>

" Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 200

" Quake
nnoremap <silent> <leader>j :Nuake<cr>
inoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>
tnoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>

" Ale
let g:ale_linters = {
\       'python': ['flake8', 'pylint'],
\}
let g:ale_fixers = {
\       '*': ['remove_trailing_lines', 'trim_whitespace'],
\       'python': ['isort', 'autopep8'],
\}
let g:ale_fix_on_save = 1
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_python_pylint_options = '--ignore=E501'
let g:ale_python_autopep8_options = '--max-line-length 120'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚬'

" Semshi
hi semshiSelected ctermbg=242 guifg=#b7bdc0 guibg=#474646

" Vimtex
let g:tex_flavor = 'latex'

" Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-python',
  \ 'coc-vimtex',
\]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> coc :CocCommand<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
hi Pmenu guibg=#292929
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif











" INSTALL BEFORE
" NVIM
" apt install nvim
"
" Pip
" pip3 install flake8 isort pylint autopep8 pynvim jedi
"
" PLUG VIM
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" LATEXMK
" apt install latexmk
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
" BASHRC
" alias python=python3.6
" alias pip=pip3
" alias rg=ranger
" alias bashrc="cd ~ && nvim .bashrc"
" alias evi="cd ~/.config/nvim && nvim init.vim"
" alias cvi="rm -rf ~/.local/share/nvim/swap/"
" alias env="source env/bin/activate"
" alias venv="source venv/bin/activate"
" PS1='\w\[\033[32m\]$(__git_ps1)\n \$\[\033[0m\] '
"
" COMFORTABLE MOTION VIM - change keymaps
" nnoremap <silent> <s-a-j> :call comfortable_motion#flick(100)<cr>
" nnoremap <silent> <s-a-k> :call comfortable_motion#flick(-100)<cr>
