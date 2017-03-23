call plug#begin('~/.vim/bundle')

"" Text
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-peekaboo'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'Valloric/YouCompleteMe'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
"Plug 'junegunn/rainbow_parentheses.vim', {'on': 'RainbowParentheses'}
"Plug 'junegunn/vim-after-object'
"Plug 'AndrewRadev/splitjoin.vim'
"Plug 'chiel92/vim-autoformat'

"" Buffers
Plug 'junegunn/fzf.vim'
Plug 'spolu/dwm.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

"" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

"" Themes
Plug 'chriskempson/base16-vim'

"" Formats
Plug 'harishnavnit/vim-qml'
"Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

" ============================================= PLUGIN CONFIGURATION


"" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1


"" Commentary
map -- gc


"" RRrplaceWithRegister
nmap rr gr


"" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"" CamelCaseMotion
map <silent> W <Plug>CamelCaseMotion_w
map <silent> B <Plug>CamelCaseMotion_b
map <silent> E <Plug>CamelCaseMotion_e
"map <silent> ge <Plug>CamelCaseMotion_ge


"" FSwitch
noremap <F4> :FSHere<CR>


"" DWM
let g:dwm_map_keys=0
nnoremap <C-M> <C-W>o
nmap <C-Space> <Plug>DWMFocus
nmap <C-C> <Plug>DWMClose
nnoremap <C-J> <C-W>w
nnoremap <C-K> <C-W>W

"" FZF
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'topleft vsplit' }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

nmap <c-g> :Ggrep<Space>
nmap <c-f> :Ag<CR>
nmap <c-l> :Files<CR>
nmap <c-h> :History<CR>
nmap <Space> :Buffers<CR>

"" Fugitive
nmap <leader>glog :Commits<CR>
nmap <leader>gls :GFiles<CR>
nmap <leader>gs :GFiles?<CR>


"" YouCompleteMe
let g:ycm_confirm_extra_conf = ''
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <c-}> :YcmCompleter GoTo<CR>


"" NERDTree
map <F3> :NERDTreeToggle<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"" Unimpired
nmap [<Tab> gT
nmap ]<Tab> gt

"=============================================  GENERAL


"" Tabbing and indentation
set tabstop=2
set shiftwidth=2
set expandtab
"set cindent
"set backspace=indent,eol
set softtabstop=2


"" Window managment
set autowrite   " Automatically save before commands like :next and :make
set autoread
set hidden          " Hide buffers when they are abandoned
set nosplitright
set splitbelow
nmap _ :ls!<Return>
:imap <C-w> <C-o><C-w> "not accidentally deleting words anymore :-)
" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


"" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1
hi Folded ctermbg=none


"" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :make
autocmd QuickFixCmdPost [^l]* nested cwindow " open quikfix with errors
autocmd QuickFixCmdPost    l* nested lwindow "


"" Clipboard
set clipboard=autoselect " System clipboard
set mouse=a   " Enable mouse usage (all modes)


"" Disable Replace mode by second <Insert>
inoremap <Insert> <Esc><Right>
inoremap jj <Esc><Right>


"" Line breaks
set nowrap
set textwidth=0
set wrapmargin=0
set formatoptions=cq "t


"" Automatically removing all trailing whitespace
autocmd BufWritePre <buffer> :%s/\s\+$//e


"" Colors
syntax on
set hlsearch " Highlight searched word
set cursorline " Highlight current line
hi CursorLine cterm=bold ctermbg=none ctermfg=none
hi MatchParen cterm=none ctermbg=none ctermfg=blue
set background=dark


"" Fast vimrc update
let $MYVIMRC="/home/azzel/favconf/vim/.vimrc"
nnoremap <leader>v :e $MYVIMRC<CR>
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }


"" visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


"" Header Guard for C/Cpp
function! g:MyAddGuard(s)
  let b:macro=a:s . toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g'))
  call append(0, ["#ifndef " . b:macro, "#define " . b:macro, ""])
  call append(line("$"), ["#endif /*" . b:macro . "*/"])
endfunction
command! -nargs=1 HeaderguardAdd call g:MyAddGuard(<f-args>)

inoremap \fn <C-R>=@%<CR>
inoremap \fh #include "<C-R>=expand("%:t:r").".h"<CR>"


"" Searching
set  ignorecase   " Do smart case matching
set  smartcase    " Do smart case matching
set  nocompatible " be iMproved, required
vnoremap // y/<C-R>"<CR><C-o>     " Search for visual selectio
map ** *:%s///gn<CR>2<C-o>

"" Essential
set number " Show line numbers
set noswapfile
filetype plugin indent on
set encoding=utf-8

" copy line N to cursor position
nnoremap gp ggyy<c-o>p

map J <PageDown>
map K <PageUp>

" for gf jumps
set path+=$PWD/**

" Stop that stupid window from popping up
map q: :q
command! W w

set tags=./tags;/

