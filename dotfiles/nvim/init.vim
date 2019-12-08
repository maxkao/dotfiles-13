cal plug#begin('~/.local/share/nvim/plugins')

Plug 'SirVer/ultisnips', { 'for': ['python', 'sh', 'snippets', 'tex'] }
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'cohama/lexima.vim'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

cal plug#end()

" LEADERS
let mapleader = ' '
let maplocalleader = ' '

" APPEARANCE
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1
colorscheme nord
hi statusline ctermbg=none ctermfg=16
hi statuslinenc ctermbg=none ctermfg=16
hi vertsplit ctermbg=none ctermfg=16
se fillchars+=eob:\ ,vert:\▏,fold:-,stl:_,stlnc:_
se stl=\  ls=0 noru nosc nosmd scl=yes

" AUTOCOMMANDS
au bufenter * se formatoptions-=cro
au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au bufwritepost * GitGutter
au filetype gitcommit,tex setl spell
au focusgained,vimresume * checkt
au textchanged,insertleave * nested silent up
au vimresized * wincmd =

" CLIPBOARD
nnoremap <c-c> "+yy
vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pa
nnoremap <c-v> "+p
nnoremap <c-x> "+dd
vnoremap <c-x> "+d

" COC
let g:coc_global_extensions = ['coc-diagnostic', 'coc-json', 'coc-python', 'coc-vimtex']
au cursorhold * silent cal CocActionAsync('highlight')
inoremap <silent> <expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nnoremap <silent> K :cal <SID>show_documentation()<cr>
fu! s:show_documentation()
    if index(['vim','help'], &filetype) >= 0
        exe 'h '.expand('<cword>')
    el | cal CocAction('doHover') | en
endfu
se completeopt=menuone,noinsert shortmess+=c

" FOLD
se foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
se foldlevel=4
se foldmethod=expr

" KILL
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :bp\|bd #<cr>
nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>s <c-z>

" LOADED
let g:loaded_gzip = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:python3_host_prog = '/bin/python'

" MAPPINGS
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>
nnoremap <cr> o<esc>
nnoremap <leader>z <c-w>s
nnoremap <leader>x <c-w>v
nnoremap <silent> gs vip:sort u<cr>
vnoremap <silent> gs :sort u<cr>
nnoremap Q <nop>

" SETTINGS
let g:UltiSnipsSnippetDirectories = [ $HOME.'/.config/nvim/UltiSnips' ]
let g:lexima_enable_endwise_rules = 0
se commentstring=//\ %s
se confirm noswapfile
se expandtab shiftwidth=4 tabstop=4
se mouse=a
se notimeout
se path+=** path-=/usr/include
se splitbelow splitright
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" SEARCH & REPLACE
fu! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype == '/' || cmdtype == '?' | retu "\<enter>zz" | en
    retu "\<enter>"
endfu
cnoremap <silent> <expr> <enter> CenterSearch()
nnoremap <silent> <esc> :noh<cr>:echo<cr><esc>
nnoremap <leader>re :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <leader>rw :%s///gI<left><left><left><left>
nnoremap <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
se ignorecase smartcase inccommand=nosplit

" TMUX
au vimenter * call system("tmux rename-window " . expand("%:t"))
au vimleave * call system("tmux setw automatic-rename")

" VIMTEX
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_fold_enabled = 1
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : 'tex',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'options' : [
        \ '-verbose',
        \ '-file-line-error',
        \ '-synctex=0',
        \ '-interaction=nonstopmode'
    \ ],
\}
let g:vimtex_compiler_callback_hooks = ['FocusViewer']
fu! FocusViewer(status)
    if system('pidof zathura')
        exe 'silent !wmctrl -xa zathura'
    el
        exe 'VimtexView'
    en
endfu

" WHITESPACE
hi whitespace ctermbg=red
au bufwinenter * mat Whitespace /\s\+$\| \+\ze\t/
au insertenter * mat Whitespace /\s\+\%#\@<!$\| \+\ze\t/
au insertleave * mat Whitespace /\s\+$\| \+\ze\t/
au bufwinleave * cal clearmatches()

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
