" Normal Editing
nnoremap <bs>                       X
nnoremap <space>                    i<space><esc><right>
nnoremap <tab>                      i<tab><esc><right>

nnoremap <c-m>                      i<cr><esc>

nnoremap U                          <c-r>
nnoremap gr                         :%s///g<left><left>

nnoremap -                          ~
nnoremap >                          >>
nnoremap <                          <<
" end


" Normal Navigation
nnoremap <a-j>                      <c-d>
nnoremap <a-k>                      <c-u>
nnoremap <silent><a-h>              :bprevious<cr>
nnoremap <silent><a-l>              :bnext<cr>

nnoremap <a-s-h>                    <c-o>
nnoremap <a-s-l>                    <c-i>

nnoremap <c-e>                      gE
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
nnoremap ga                         <esc>ggVG
nnoremap gw                         :w<cr>

nnoremap <silent>;                  <esc>:noh<cr>:echo ''<cr>

nnoremap <leader>zm                 zm
nnoremap <leader>zr                 zr
nnoremap <leader>zo                 zo
nnoremap <leader>zf                 zf
nnoremap g/                         /\<\><left><left>
" end


" Insert
inoremap <a-z>                      z
inoremap <a-;>                      ;

inoremap <silent>;                  <esc>:noh<cr>

inoremap <leader>j                  <home>
inoremap <leader>k                  <end>
" end


" Visual
vnoremap p                          pgvy
vnoremap gr                         :s/\%V\%V//g<left><left><left><left><left><left>

vnoremap <silent>;                  <esc>:noh<cr>

vnoremap <leader>j                  ^
vnoremap <leader>k                  $h
vnoremap <leader>o                  %
vnoremap <leader>a                  $A
vnoremap <leader>i                  0I
vnoremap <a-j>                      <c-d>
vnoremap <a-k>                      <c-u>
" end


" Command
cnoremap <c-p>                      <c-r>"
cnoremap <c-o>                      \<c-r>"
" end
