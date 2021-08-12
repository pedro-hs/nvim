" Visual
vnoremap <leader>j ^
vnoremap <leader>k $h
vnoremap <leader>o %
vnoremap <leader>a $A
vnoremap <leader>i 0I
vnoremap p pgvy
vnoremap <silent> ; <esc>:noh<cr>
vnoremap <leader>rr :s/\%V\%V//<left><left><left><left><left>
" end

" Command
cnoremap <c-p> <c-r>"
cnoremap <c-o> \<c-r>"
" end

" Normal
nnoremap <bs> X
nnoremap <space> i<space><esc><right>
nnoremap <c-m> i<cr><esc>
nnoremap <tab> i<tab><esc><right>
nnoremap <a-h> <c-o>
nnoremap <a-l> <c-i>
nnoremap <a-j> <c-d>
nnoremap <a-k> <c-u>
nnoremap <a-s-k> <c-y>
nnoremap <a-s-j> <c-e>
nnoremap <silent> <right> :vertical resize +3<cr>
nnoremap <silent> <left>  :vertical resize -3<cr>
nnoremap <silent> <up>    :resize +3<cr>
nnoremap <silent> <down>  :resize -3<cr>
nnoremap <silent> <c-a> :bprevious<cr>
nnoremap <silent> <c-s> :bnext<cr>
nnoremap <silent> <leader>w :w<cr>
nnoremap <leader>xa <esc>ggVG
nnoremap <leader>xc :set ignorecase! ignorecase?<cr>
nnoremap <leader>xr :source init.vim<cr>
nnoremap <silent> <leader>xp :call system('xclip -i -selection clipboard', expand('%'))<cr>
nnoremap <leader>o %
nnoremap <leader>j ^
nnoremap <leader>k $
nnoremap <silent> ; <esc>:noh<cr>:echo ''<cr>
nnoremap <leader>rr :%s///g<left><left>
nnoremap U <c-r>
nnoremap - ~
nnoremap * *N
nnoremap # #n
nnoremap Z <esc>:q!<cr>
nnoremap Q <esc>:%bd!<cr><esc>:q!<cr>
nnoremap <leader>zm zm
nnoremap <leader>zr zr
nnoremap <leader>/ /\<\><left><left>
nnoremap > >>
nnoremap < <<
" end

" Insert
inoremap <leader>j <home>
inoremap <leader>k <end>
inoremap <silent> ; <esc>:noh<cr>
inoremap <a-;> ;
inoremap <leader>z z
" end
