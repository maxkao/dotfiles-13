call plug#begin('~/.local/share/nvim/plugins')

Plug '907th/vim-auto-save'
Plug 'SirVer/ultisnips', { 'for': ['python', 'snippets', 'tex'] }
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator', { 'on': ['TmuxNavigateDown', 'TmuxNavigateLeft', 'TmuxNavigateRight', 'TmuxNavigateUp'] }
Plug 'cohama/lexima.vim'
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'ludovicchabant/vim-gutentags', { 'for': ['python', 'tex'] }
Plug 'moll/vim-bbye', { 'on': 'Bd' }
Plug 'neoclide/coc-vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', { 'for': ['python', 'sh', 'tex'] }
Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

call plug#end()

" LEADERS
let mapleader = ' '
let maplocalleader = ' '

" ALE
au FileType python nnoremap <silent> <leader>i :ALEFix<cr>
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_sh_shfmt_options = '-ci -sr -p -s'
let g:ale_python_pylint_options = '--disable=C0102,C0103,C0111,C0330,C0200,R0903,R0913,R0914,W0511 --max-line-length=88'
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['isort', 'black'],
    \ 'sh': ['shfmt'],
\}

" APPEARANCE
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['help', 'json', 'man', 'markdown', 'tex']
let g:nord_bold = 0
let g:nord_bold_vertical_split_line = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1
colorscheme nord
se fcs+=eob:\ ,fold:\ ,vert:\ 
se scl=yes shm+=c tgc

" AUTOCOMMANDS
au bufenter * se fo-=cro
au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au bufwritepost * GitGutter
au filetype markdown,python,tex setl spell
au focusgained,bufenter,vimresume * checkt
au vimresized * wincmd =

" BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist = ['help']
let g:better_whitespace_guicolor = '#bf616a'
let g:show_spaces_that_precede_tabs = 1
let g:strip_whitelines_at_eof = 1

" CLIPBOARD
nnoremap <RightMouse> "+p
vnoremap <RightMouse> "+y
nnoremap <c-c> "+yy
vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pa
nnoremap <c-v> "+p
vnoremap <c-v> dk"+p
nnoremap <c-x> "+dd
vnoremap <c-x> "+d

" FZF
au filetype fzf se ls=0 | au bufleave <buffer> se ls=2
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>t :Tags<cr>

" KILL
nnoremap <leader>s <c-z>
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <a-d> :Bd<cr>
nnoremap <silent> <leader>x :bd<cr>
nnoremap <silent> <leader>q :qa<cr>

" LOADED
let g:coc_global_extensions = ['coc-python']
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
nnoremap <cr> o<esc>
nnoremap g<cr> O<esc>
nnoremap <leader>z <c-w>s
nnoremap <leader>v <c-w>v
nnoremap <silent> <leader>i :%retab<cr>
nnoremap <silent> gs vip:sort u<cr>
vnoremap <silent> gs :sort u<cr>
nnoremap Q <nop>

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-e> :bp<cr>
nnoremap <silent> <a-r> :bn<cr>
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>

" NERDTREE
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/.NERDTreeBookmarks'
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = 'NERDTree'
nnoremap <silent> <leader>e :NERDTreeToggle<cr><c-w>=

" NETRW
let g:netrw_banner = 0
let g:netrw_dirhistmax = 0
let g:netrw_liststyle = 3
" nnoremap <silent> <leader>e :Explore<cr>

" SAVE
let g:auto_save = 1
let g:auto_save_silent = 1
se cf noswf

" SETTINGS
se et sw=4 ts=4
se mouse=a
se pa+=** pa-=/usr/include
se sb spr
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" SEARCH & REPLACE
" au CursorHold * exec 'mat StatusLineTerm /'.expand('<cword>').'/'
function! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype == '/' || cmdtype == '?'
        return "\<enter>zz"
    endif
    return "\<enter>"
endfunction
cnoremap <silent> <expr> <enter> CenterSearch()
nnoremap <silent> <esc> :noh<cr>:echo<cr><esc>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <leader>rr :%s///gI<left><left><left><left>
nnoremap <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
se ic scs icm=nosplit

" SNIPPETS
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsSnippetDirectories = [ $HOME.'/.config/nvim/UltiSnips' ]

" STATUS- & TABLINE
au winenter * se ls=1 noru nosc nosmd
au vimenter,winenter * WintabsAllBuffers
se ls=1 noru nosc nosmd

" VIMTEX
let g:vimtex_view_general_viewer = 'firefox'
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

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se bri lbr
