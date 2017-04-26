"" Fast vimrc update
let $MYVIMRC="/home/azzel/favconf/vim/.vimrc"
let $COLORFILE="/home/azzel/favconf/vim/darktooth.vim"
let $ZSHFILE="/home/azzel/favconf/zsh/.zshrc.local"
nnoremap <leader>v :tabe $MYVIMRC<CR>
nnoremap <leader>z :tabe $ZSHFILE<CR>
augroup vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd BufWritePost $MYVIMRC source $COLORFILE
augroup END " }


"" Alias command
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun


""
fun! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

"" Silent clear
command! -nargs=1 Silent execute ':silent '.<q-args> | execute ':redraw!'

" ============================================= PLUGINS

call plug#begin('~/.vim/bundle')

"" General
Plug 'drmikehenry/vim-fixkey'
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'

"" Text
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
"Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-expand-region'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
"Plug 'vim-scripts/ReplaceWithRegister'
Plug 'Valloric/YouCompleteMe'
"Plug 'junegunn/rainbow_parentheses.vim', {'on': 'RainbowParentheses'}
"Plug 'junegunn/vim-after-object'
"Plug 'AndrewRadev/splitjoin.vim'
Plug 'chiel92/vim-autoformat'
"Plug 'vim-syntastic/syntastic'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'brooth/far.vim'
Plug 'metakirby5/codi.vim'

"" Buffers
Plug 'junegunn/fzf.vim'
"Plug 'spolu/dwm.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'mkitt/tabline.vim'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/gv.vim'

"" Formats & colors
Plug 'chriskempson/base16-vim'
Plug 'jeaye/color_coded'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'justinmk/vim-syntax-extra'
Plug 'harishnavnit/vim-qml'
"Plug 'python-mode/python-mode'
Plug 'mattn/emmet-vim'

call plug#end()

" ============================================= PLUGIN CONFIGURATION


"" Commentary
map -- gc


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
noremap <S-F4> :FSSplitLeft<CR>


"" DWM
let g:dwm_map_keys=0
nnoremap <C-M> <C-W>o
nnoremap <C-L> <C-W>o
nmap <C-C> <C-W>c
nmap <C-N> :vnew<CR>
nmap <NUL> <Plug>DWMFocus


"" FZF
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep('git gr --line-number '.shellescape(<q-args>), 0, <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'topleft vsplit' }

nmap <C-L> :Files ~<CR>
nmap <C-P> :Files<CR>
nmap <C-H> :History<CR>
nmap <C-B> :Buffers<CR>


"" Fugitive
call SetupCommandAlias("Gr","Ggrep -I --recurse-submodules")
nmap <c-g> :Gr<Space>
nmap <leader>glog :Commits<CR>
nmap <leader>gls :GFiles<CR>
nmap <leader>gs :GFiles?<CR>
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"" YouCompleteMe
let g:ycm_confirm_extra_conf = ''
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
autocmd vimrc FileType c,cpp nnoremap <buffer> ]d :YcmCompleter GoTo<CR>
autocmd vimrc FileType c,cpp nnoremap <buffer> K :YcmCompleter GetType<CR>


"" NERDTree
map <F3> :NERDTreeToggle<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"=============================================  GENERAL


"" Tabbing and indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
"set cindent
"set backspace=indent,eol
filetype plugin indent on


"" Windows & buffers
set autowrite   " Automatically save before commands like :next and :make
"set autoread
set hidden          " Hide buffers when they are abandoned
set sessionoptions=folds,tabpages,winsize "no buffers
set nosplitright
set splitbelow
nnoremap <c-t> :tabe<CR>
nnoremap <leader>d :tabe .<CR>
" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
autocmd FileType help wincmd H
autocmd WinNew wincmd H
autocmd BufWinEnter wincmd H

"" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1
hi Folded ctermbg=none


"" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :AsyncRun make<CR>
nmap <F5> :Make!<CR>
autocmd QuickFixCmdPost [^l]* nested cwindow " open quikfix with errors
autocmd QuickFixCmdPost    l* nested lwindow "
autocmd QuickFixCmdPost wincmd L


"" Clipboard
set clipboard=autoselect "  clipboard
set mouse=a   " Enable mouse usage (all modes)
noremap <Delete> "_d<Right>
inoremap <Backspace> <Left><Delete>
" annihilating
noremap xx "_dd
noremap x "_d
noremap X "_D
" for multiple replaces
vnoremap p p:let @"=@0<CR>
vnoremap P P:let @"=@0<CR>

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
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256 " 256 color mode
set background=dark


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
vnoremap // y/<C-R>"<CR><C-o>     " Search for visual selection
map ** *:%s///gn<CR>2<C-o>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :.cc<CR><C-W><C-W>
" search in files word under cursor uses fugitive, vv and **
nmap <c-f> viwy**<c-g><c-r>"<CR>


" copy line N to cursor position
nnoremap gp ggyy<c-o>p


" for jumps
set path+=$PWD/**
set tags=./tags;/


nnoremap <C-J> <PageDown>
nnoremap <C-K> <PageUp>


"" Stop that stupid window from popping up
noremap q: :q
command! W w


"" Keep selection after indentation move
vnoremap < <gv
vnoremap > >gv


"" Essential
set nocompatible " be iMproved
set number " Show line numbers
set noswapfile
set encoding=utf-8
set laststatus=2
set history=1024
set viminfo='256

nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt

