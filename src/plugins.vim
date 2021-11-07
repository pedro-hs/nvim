call plug#begin()
Plug 'rhysd/clever-f.vim' " TODO
Plug 'rhysd/conflict-marker.vim' " TODO
Plug 'lambdalisue/fern.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine' " TODO
Plug 'cohama/lexima.vim' " TODO
Plug 'ap/vim-buftabline' " TODO
Plug 'dominikduda/vim_current_word' " TODO
Plug 'airblade/vim-gitgutter'
Plug 'whatyouhide/vim-gotham'
Plug 'sheerun/vim-polyglot'
Plug 'machakann/vim-sandwich'

" extra.vim
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install', 'for': 'markdown'  }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }
Plug 'knubie/vim-kitty-navigator'
call plug#end()


" Theme
set termguicolors
colorscheme gotham
" end


" Fzf
vnoremap <silent> <leader>ss y:Ag <c-r>"<cr>

nnoremap <silent> <leader>ss yiw:Ag <c-r>"<cr>
nnoremap <silent> <leader>sd :Files<cr>
nnoremap <silent> <leader>sc :GFiles?<cr>
nnoremap <silent> <leader>sf :Ag<cr>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '-m --bind ctrl-a:select-all,ctrl-d:deselect-all'
" end


" BufTabline
let g:buftabline_indicators    = 1

hi TabLineSel   ctermfg=fg guifg=#33859E guibg=bg ctermbg=bg
hi TabLine      cterm=bold   gui=bold guifg=#D8DEE9 ctermfg=none ctermbg=none guibg=bg
hi TabLineFill  guifg=bg
" end


" Clever F
let g:clever_f_mark_char_color = 'PmenuSel'
" end


" Sandwich
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:sandwich#recipes = [
            \ {'buns': ['(', ')'], 'nesting': 1, 'match_syntax': 1, 'input': ['('] },
            \ {'buns': ['[', ']'], 'nesting': 1, 'match_syntax': 1, 'input': ['['] },
            \ {'buns': ['{', '}'], 'nesting': 1, 'match_syntax': 1, 'input': ['{'] },
            \ {'buns': ['<', '>'], 'nesting': 1, 'match_syntax': 1, 'input': ['<'] },
            \ {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1, 'input': [')'] },
            \ {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1, 'input': [']'] },
            \ {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1, 'input': ['}'] },
            \ {'buns': ['< ', ' >'], 'nesting': 1, 'match_syntax': 1, 'input': ['>'] },
            \ ]
silent! nmap <unique> ca <Plug>(operator-sandwich-add)
silent! xmap <unique> ca <Plug>(operator-sandwich-add)
silent! omap <unique> ca <Plug>(operator-sandwich-g@)
nmap cr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap cr <Plug>(operator-sandwich-replace)
nmap cd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
xmap cd <Plug>(operator-sandwich-delete)
" end


" Indent Line
let g:indentLine_char                   = '▏'
let g:indentLine_color_gui              = '#3B4252'
let g:vim_json_syntax_conceal           = 0
let g:vim_markdown_conceal              = 0
let g:vim_markdown_conceal_code_blocks  = 0
let g:indentLine_fileTypeExclude        = ['fern']
" end


" Git Gutter
let g:gitgutter_sign_added              = '▌'
let g:gitgutter_sign_modified           = '▌'
let g:gitgutter_sign_removed            = '▁'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_modified_removed   = '▌'

hi GitGutterAdd          guibg=bg
hi GitGutterChange       guibg=bg
hi GitGutterDelete       guibg=bg
hi GitGutterChangeDelete guibg=bg
"  end


" Conflict Marker
let g:conflict_marker_begin           = '^<<<<.\+'
let g:conflict_marker_end             = '^>>>>.\+'
let g:conflict_marker_enable_mappings = 0

hi ConflictMarkerBegin     ctermfg=195 ctermbg=30 guifg=#c6c8d1 guibg=#5b7881
hi ConflictMarkerEnd       ctermfg=255 ctermbg=240 guifg=#eff0f4 guibg=#5b6389
hi ConflictMarkerSeparator guifg=#272c42
hi ConflictMarkerOurs      ctermfg=159   ctermbg=23 guifg=#b3c3cc guibg=#384851
hi ConflictMarkerTheirs    ctermbg=236   guibg=#3d425b

nnoremap <leader>ho :ConflictMarkerOurselves<cr>
nnoremap <leader>ht :ConflictMarkerThemselves<cr>
nnoremap <leader>hb :ConflictMarkerBoth<cr>
nnoremap <leader>hB :ConflictMarkerBoth!<cr>
nnoremap <leader>hn :ConflictMarkerNone<cr>
" end


" Git Gutter & Conflict Marker
nnoremap ]c :ConflictMarkerNextHunk<cr>:GitGutterNextHunk<cr>:echo ''<cr>
nnoremap [c :ConflictMarkerPrevHunk<cr>:GitGutterPrevHunk<cr>:echo ''<cr>

fun! DisablePluginsOnMerge()
    " {{{
    if filereadable(expand('%:p')) && match(readfile(expand('%:p')), g:conflict_marker_begin) != -1
        let g:indentLine_enabled = 0
        let g:ale_set_highlights = 0
        let g:autosave_on = 0
    else
        let g:indentLine_enabled = 1
        let g:ale_set_highlights = 1
        let g:autosave_on = 1
    endif
endfun
" }}}

au BufEnter * :call DisablePluginsOnMerge()
" end


" Theme Colors
fun! ThemeColors()
    " {{{
    hi LineNr       ctermbg=bg  guibg=bg
    hi SignColumn   ctermbg=bg  guibg=bg
    hi VertSplit    guifg=bg    guibg=bg
    hi FoldColumn   ctermfg=fg guifg=#33859E guibg=bg ctermbg=bg
    hi Folded       ctermfg=fg guifg=#33859E guibg=bg ctermbg=bg
    hi Pmenu        ctermbg=12 guibg=#0a3749
    hi Comment      ctermfg=6 guifg=#33859E
    hi Search       ctermfg=4 guifg=bg guibg=#ad9717
    hi EndOfBuffer  guifg=bg ctermfg=bg ctermbg=bg guibg=bg

    hi DiffAdd      ctermbg=23 ctermfg=255  guifg=#ffffff guibg=#5ba369
    hi DiffDelete   ctermbg=158 ctermfg=158 guifg=#9e4141 guibg=#9e4141
    hi Visual       ctermbg=236 guibg=#3d425b
endfun

call ThemeColors()
" }}}
"  end


" Vim Current Word
hi CurrentWord ctermfg=15 ctermbg=2 guifg=#d3ebe9 guibg=#2aa889
hi CurrentWordTwins ctermfg=15 ctermbg=4 guifg=#d3ebe9 guibg=#195466
" end


" Fern
let g:fern#disable_default_mappings = 1

noremap <silent> <Leader>n :Fern . -drawer -right -reveal=% -toggle -width=35<cr>

fun! InitFern() abort
    " {{{
    nmap <buffer><expr>
        \ <Plug>(fern-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

    nmap <buffer> x <Plug>(fern-action-collapse)
    nmap <buffer> o <Plug>(fern-open-expand-collapse)
    nmap <buffer> O <Plug>(fern-action-open:vsplit)
    nmap <buffer> a <Plug>(fern-action-new-path)
    nmap <buffer> d <Plug>(fern-action-remove)
    nmap <buffer> r <Plug>(fern-action-move)
    nmap <buffer> . <Plug>(fern-action-hidden:toggle)
    nmap <buffer> b <Plug>(fern-action-focus:parent)
    nmap <buffer><nowait> < <Plug>(fern-action-leave)
    nmap <buffer><nowait> > <Plug>(fern-action-enter)

    nmap <buffer> <space> <Plug>(fern-action-mark:toggle)j
    nmap <buffer> n <Plug>(fern-action-diff:select)
endfun
" }}}

augroup FernCustom
    au!
    au FileType fern setlocal norelativenumber | setlocal nonumber | call HideStatusLine() | call InitFern()
augroup END
" end
