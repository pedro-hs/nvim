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
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-lion'
Plug 'unkiwii/vim-nerdtree-sync'
Plug 'rakr/vim-one'
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
set nobackup
set nowritebackup
set noswapfile

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

nnoremap <leader>rr :%s///g<left><left>
nnoremap <leader>sa <esc>ggVG
nnoremap <silent> <leader>w :w<cr>
nnoremap <silent> <leader>c :set ignorecase!<cr>
nnoremap <silent> <leader>x :set relativenumber!<cr>

nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>sf yiw:Ag<cr>

nnoremap 99 ^
nnoremap 00 $
nnoremap U <c-r>
nnoremap * *N
nnoremap - ~
nnoremap zz <esc>:wq<cr>
nnoremap zx <esc>:q!<cr>
nnoremap <silent> ç <esc>i<esc>:noh<cr>
" end

" Insert
inoremap <c-j> <esc>:m .+1<cr>==gi
inoremap <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <esc>ja
inoremap <a-l> <esc>la
inoremap <a-h> <esc>ha
inoremap <a-k> <esc>ka

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

let g:currentmode={
\  'n':  'Normal',   'no': 'Pending',  'v':  'Visual',   'V':  'V·Line',     "\<C-V>": 'V·Block',  's':  'Select',  'S':'S·Line',
\  '^S': 'S·Block',  'i':  'Insert',   'R':  'Replace',  'Rv': 'V·Replace',  'c':      'Command',  'cv': 'Vim Ex',
\  'ce': 'Ex',       'r':  'Prompt',   'rm': 'More',     'r?': 'Confirm',    '!':      'Shell',    't':  'Terminal'
\}

set laststatus=2
set statusline=%1*\ %{toupper(g:currentmode[mode()])}%=%<%m%r%h%w%f%5{StatuslineGit()}%5v%5l/%L%5p%%
" end

" Zen mode
function! ToggleZenMode()
  let l:name = '_zen_'
  if bufwinnr(l:name) > 0
    wincmd o
    set noequalalways!
  else
    execute 'topleft' ((&columns - &textwidth) / 4) . 'vsplit +setlocal\ nobuflisted' l:name | let &l:statusline='%1*%{getline(line("w$")+1)}' | wincmd p
    set noequalalways
  endif
endfunction

autocmd VimEnter * hi VertSplit guifg=bg guibg=bg

nnoremap <silent> <leader>z :call ToggleZenMode()<cr>
" end

" One
set termguicolors
set background=dark

let g:one_allow_italics = 1

colorscheme one

hi FoldColumn guifg=bg guibg=gb
hi Pmenu guibg=bg
" end

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" end

" NerdTree
let g:NERDTreeMinimalUI = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeWinPos = "right"
let g:nerdtree_sync_cursorline = 1

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
" end

" Blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_delay = 200
" end

" Nuake
nnoremap <silent> <leader>j :Nuake<cr>
inoremap <silent> <leader>j <C-\><C-n>:Nuake<cr>
tnoremap <silent> <leader>j <C-\><C-n>:Nuake<cr><c-w>w
" end

" Ale
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚬'
let g:ale_fix_on_save = 1

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

let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_python_pylint_options = '--ignore=E501'
let g:ale_python_autopep8_options = '--max-line-length 120'
let g:ale_javascript_prettier_options = '--single-quote --print-width=140 --arrow-parens=always --trailing-comma=es5 --implicit-arrow-linebreak=beside'

hi ALEWarning guifg=#b7bdc0 guibg=#474646
hi ALEError guifg=#292929 guibg=#b7bdc0
" end

" Semshi
hi semshiSelected ctermbg=242 guifg=#b7bdc0 guibg=#474646
hi link semshiUnresolved ALEError
" end

" Coc
let g:coc_global_extensions = [
\  'coc-tsserver',
\  'coc-python',
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
" end

" BufTabline
let g:buftabline_indicators=1
" end










" TODO
" Global replace
" Git diff
" Git merge
" Create dotfiles (bash, git)
" Add sql formatter
" Fix js formatter
"
" INSTALL
" apt install silversearcher-ag ranger terminator nvim
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
" BUFTABLINE + DEVICONS
" let tab.label = tab.path[tab.sep + 1:] . ' ' . WebDevIconsGetFileTypeSymbol(tab.path)
"
" BASHRC
" alias python=python3.6
" alias pip=pip3
" alias rg=ranger
" alias bashrc="cd ~ && nvim .bashrc"
" alias evi="cd ~/.config/nvim && nvim init.vim"
" alias penv="source env/bin/activate"
" alias pvenv="source venv/bin/activate"
" alias src="cd ~/Documents/src"
" PS1='\w\[\033[32m\]$(__git_ps1)\n \$\[\033[0m\] '
" alias gis="git status -su"
"
" GOOGLE CHROME VIMIUM
" VSCODE VIM
" SUBLIME VINTAGE
