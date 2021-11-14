" Normal Editing
nnoremap <bs>                       X
nnoremap <space>                    i<space><esc><right>
nnoremap <tab>                      i<tab><esc><right>

nnoremap <c-m>                      i<cr><esc>

nnoremap U                          <c-r>

nnoremap -                          ~
nnoremap >                          >>
nnoremap <                          <<

nnoremap <leader>rr                 :%s///g<left><left>
" end


" Normal Navigation
nnoremap <a-e>                      ge
nnoremap <a-h>                      <c-o>
nnoremap <a-l>                      <c-i>
nnoremap <a-j>                      <c-d>
nnoremap <a-k>                      <c-u>
nnoremap <a-s-k>                    <c-y>
nnoremap <a-s-j>                    <c-e>

nnoremap <silent><c-a>              :bprevious<cr>
nnoremap <silent><c-s>              :bnext<cr>
nnoremap <silent><c-h>              :wincmd h<cr>
nnoremap <silent><c-l>              :wincmd l<cr>
nnoremap <silent><c-j>              :wincmd j<cr>
nnoremap <silent><c-k>              :wincmd k<cr>

nnoremap *                          *N
nnoremap #                          #n

nnoremap <leader>o                  %
nnoremap <leader>j                  ^
nnoremap <leader>k                  $
" end


" Normal Commands
nnoremap <silent><right>            :vertical resize +3<cr>
nnoremap <silent><left>             :vertical resize -3<cr>
nnoremap <silent><up>               :resize +3<cr>
nnoremap <silent><down>             :resize -3<cr>

nnoremap Z                          <esc>:q!<cr>
nnoremap Q                          <esc>:%bd!<cr><esc>:q!<cr>

nnoremap <silent>;                  <esc>:noh<cr>:echo ''<cr>

nnoremap <leader>zm                 zm
nnoremap <leader>zr                 zr
nnoremap <leader>/                  /\<\><left><left>
nnoremap <leader>xa                 <esc>ggVG
nnoremap <silent><leader>xr         :source ~/.config/nvim/init.vim<cr>:echo 'vimrc updated'<cr>
nnoremap <silent><leader>xp         :call system('xclip -i -selection clipboard', expand('%'))<cr>
nnoremap <silent><leader>w          :w<cr>
" end


" Insert
inoremap <a-;>                      ;

inoremap <silent>;                  <esc>:noh<cr>

inoremap <leader>z                  z
inoremap <leader>j                  <home>
inoremap <leader>k                  <end>
" end


" Visual
vnoremap p                          pgvy

vnoremap <silent>;                  <esc>:noh<cr>

vnoremap <leader>j                  ^
vnoremap <leader>k                  $h
vnoremap <leader>o                  %
vnoremap <leader>a                  $A
vnoremap <leader>i                  0I
vnoremap <leader>rr                 :s/\%V\%V//g<left><left><left><left><left><left>
" end


" Command
cnoremap <c-p>                      <c-r>"
cnoremap <c-o>                      \<c-r>"
" end
