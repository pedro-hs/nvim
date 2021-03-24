" Visual
vnoremap <leader>j ^
vnoremap <leader>k $h
vnoremap <leader>o %
vnoremap <leader>a $A
vnoremap <leader>i 0I

vnoremap p pgvy
vnoremap <silent> ; <esc>:noh<cr>
" end

" Command
cnoremap <c-p> <c-r>"
cnoremap <c-o> \<c-r>"
" end

" Normal
nnoremap <bs> X
nnoremap <space> i<space><esc><right>
nnoremap <c-m> i<cr><esc><right>
nnoremap <tab> i<tab><esc><right>

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

nnoremap <silent> <leader>w :w<cr>
nnoremap <leader>xa <esc>ggVG
nnoremap <silent> <leader>xp :call system('xclip -i -selection clipboard', expand('%'))<cr>
nnoremap <leader>o %
nnoremap <leader>j ^
nnoremap <leader>k $
nnoremap <silent> <leader>; :call cursor(0, len(getline('.'))/2)<cr>

nnoremap U <c-r>
nnoremap - ~
nnoremap <leader>zc zz
nnoremap <leader>zm zm
nnoremap <leader>zr zr
nnoremap <leader>zz <esc>:q!<cr>
nnoremap <leader>zx <esc>:%bd!<cr><esc>:q!<cr>
nnoremap <silent> ; <esc>:noh<cr>:echo ''<cr>
" end

" Insert
inoremap <silent> <c-j> <esc>:m .+1<cr>==gi
inoremap <silent> <c-k> <esc>:m .-2<cr>==gi
inoremap <a-j> <down>
inoremap <a-l> <right>
inoremap <a-h> <left>
inoremap <a-k> <up>

inoremap <leader>w <esc>:w<cr>
inoremap <leader>j <home>
inoremap <leader>k <end>
inoremap <silent> <leader>; <esc>:call cursor(0, len(getline('.'))/2)<cr>a

inoremap <silent> ; <esc>:noh<cr>
inoremap <leader>; ;
inoremap <leader>z z
" end
