let $FAVHOME="/home/azzel/favconf"
let $MYVIMRC="/home/azzel/favconf/vim/.vimrc"
let $COLORFILE="/home/azzel/favconf/vim/darktooth.vim"
let $ZSHFILE="/home/azzel/favconf/zsh/.zshrc.local"
let $GITCONFIG="/home/azzel/.gitconfig"
nnoremap <leader>v :tabe $MYVIMRC<CR>
nnoremap <leader>z :tabe $ZSHFILE<CR>
nnoremap <leader>g :tabe $GITCONFIG<CR>
nnoremap <leader>a :tabe $FAVHOME/ag/agignore"<CR>
nnoremap <leader>x :tabe $FAVHOME/xbk/xbindkeysrc"<CR>

"" Fast vimrc update
augroup vimrc" {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd BufWritePost $MYVIMRC source $COLORFILE
augroup END " }
syntax enable

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

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction

" ============================================= PLUGINS

call plug#begin('~/.vim/bundle')


"" General
Plug 'drmikehenry/vim-fixkey'
Plug 'skywind3000/asyncrun.vim'

"" Text & movement
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-expand-region'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
Plug 'brooth/far.vim', { 'on': 'Far' }


"" Buffers
Plug 'junegunn/fzf.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'majutsushi/tagbar' ", { 'on': 'TagbarToggle' }
Plug 'mkitt/tabline.vim'
Plug 'Valloric/ListToggle'
Plug 'justinmk/vim-dirvish'
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'


"" Formats & colors
" Plug 'davidhalter/jedi-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'justinmk/vim-syntax-extra'
Plug 'peterhoeg/vim-qml'
Plug 'artoj/qmake-syntax-vim'
Plug 'Valloric/YouCompleteMe', {'on': 'YcmRestartServer'}
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'othree/xml.vim'
" Plug 'bbchung/clighter8'
" Plug 'vim-syntastic/syntastic' "{'on': 'SyntasticToggleMode'}

call plug#end()

" ============================================= PLUGIN CONFIGURATION

"" Ack
let g:ackprg = 'rg --vimgrep --ignore-file ~/favconf/ag/agignore'
" let g:ackprg = 'ag --vimgrep -p ~/favconf/ag/agignore'


"" Lightline
let g:lightline = {'colorscheme': 'wombat' }

"" clighter
nmap <silent> <Leader>r :call clighter#Rename()<CR>


"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"" Codi
let g:codi#interpreters = {
  \ 'python': {
    \ 'bin': 'python',
    \ 'prompt': '^\(>>>\|\.\.\.\) ',
  \ },
\ }

let g:codi#aliases = {
  \ '*.py': 'python',
\ }

let g:codi#log = '/tmp/codi.log'

function! s:AllowCodi()
   if empty(glob('/tmp/cmd'))
       call system('touch /tmp/cmd')
   endif

   call system('chmod u+x /tmp/cmd')
endfunction

autocmd VimEnter * call s:AllowCodi()


"" T-comment
map -- gcc<Esc>
" let g:tcommentMapLeaderOp2
" let g:tcommentMapLeaderOp2
au BufRead,BufNewFile, *.pro   set filetype=qmake
au BufRead,BufNewFile, *.pri   set filetype=qmake
call tcomment#DefineType('qmake','# %s')


"" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"" CamelCaseMotion
map <silent> <M-w> <Plug>CamelCaseMotion_w
map <silent> <M-b> <Plug>CamelCaseMotion_b
map <silent> <M-e> <Plug>CamelCaseMotion_e
map <silent> <M-Left>  <Plug>CamelCaseMotion_b
map <silent> <M-Right> <Plug>CamelCaseMotion_e
imap <silent> <M-Left> <C-o><Plug>CamelCaseMotion_b
imap <silent> <M-Right> <C-o><Plug>CamelCaseMotion_e
"map <silent> ge <Plug>CamelCaseMotion_ge


"" FSwitch
noremap <F2> :FSHere<CR>
noremap <S-F2> :FSSplitLeft<CR>


"" DWM
let g:dwm_map_keys=0
nnoremap <C-M> <C-W>o
nmap <C-C> :TagbarClose<CR><C-W>c
nmap <C-N> :vnew<CR>


"" FZF
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep('git gr --line-number '.shellescape(<q-args>), 0, <bang>0)
command! -bang -nargs=* Rg
      \ call fzf#vim#grep('rg --vimgrep '.shellescape(<q-args>), 0, <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nmap <C-L> :Files ~<CR>
nmap <C-P> :Files<CR>
nmap <C-Q> :Ag<CR>
nmap <C-H> :History<CR>
nmap <C-B> :Buffers<CR>


" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'



"" Fugitive
call SetupCommandAlias("Gr","Ggrep -I --recurse-submodules")
nmap <c-g> :Ack<Space>
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"" YouCompleteMe
let g:ycm_confirm_extra_conf = ''
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
autocmd vimrc FileType c,cpp nnoremap <buffer> ]d :YcmCompleter GoTo<CR>
autocmd vimrc FileType c,cpp nnoremap <buffer> K :YcmCompleter GetType<CR>
hi YcmErrorSection ctermfg=White ctermbg=Red


"" TagBar
map <F3> :TagbarToggle<CR>
" autocmd filetype cpp nested TagbarOpen


"" Dirvish
map <F4> <Plug>(dirvish_up)
map <F6> :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR; reset<CR>
tmap jj <c-\><c-n>
set termkey=CTRL-\


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
filetype plugin on


"" Windows & buffers
set autowrite   " Automatically save before commands like :next and :make
"set autoread
set hidden          " Hide buffers when they are abandoned
set sessionoptions=folds,tabpages,winsize "no buffers
set nosplitright
set splitbelow
nnoremap <c-t> :tabe<CR>
nnoremap <leader>d :tabe .<CR>
nnoremap <leader>c :tabe ~/favconf<CR>
" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
autocmd FileType help wincmd H
autocmd WinNew wincmd H
autocmd BufWinEnter wincmd H

"" Folding
set foldmethod=syntax
set foldnestmax=20
set foldlevelstart=99
hi Folded ctermbg=none


"" Quickfix
noremap <F5> :AsyncStop<CR>:AsyncRun make run<CR>
noremap <F7> :!pkill python<CR>:YcmRestartServer<CR>
noremap <F8> :wa<CR>:AsyncStop<CR>:AsyncRun qmake -r; make notify<CR>:copen<CR>G<C-w><C-w>
" autocmd QuickfixCmdPost make splint %
autocmd QuickFixCmdPost    l* nested lwindow "
autocmd QuickFixCmdPost [^l]* nested cwindow " open quikfix with errors

augroup QuickfixWindow
    autocmd!
    autocmd FileType qf wincmd J
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup end
noremap [s :colder<CR>
noremap ]s :cnewer<CR>:QToggle<CR>

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
vnoremap p p:let @"=@0 <CR>
vnoremap P P:let @"=@0 <CR>
noremap <leader>p :!echo <C-r>*
nnoremap <M-p> "*P
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"" Disable Replace mode by second <Insert> or jj
inoremap <Insert> <Esc><Right>
inoremap jj <Esc><Right>


" Unset paste on InsertLeave
au InsertLeave * silent! set nopaste
set pastetoggle=<F9>


"" Line breaks
set nowrap
set textwidth=0
set wrapmargin=0
set formatoptions=cq "t

" Trailing-whitespace
hi ExtraWhitespace ctermbg=DarkGrey
autocmd FileType qml,c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :FixWhitespace

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


""
function! g:GCompare_(rev)
  let b:line_number=line(".")
  normal zz
  vnew
  b#
  exe "Gedit ".a:rev.":%"
  normal b:line_number."ggzz"
endfunction
command! -nargs=1 GCompare call g:GCompare_(<f-args>)

inoremap \fn <C-R>=@%<CR>
noremap  <leader>f :let @*=@%<CR>
inoremap \fh #include "<C-R>=expand("%:t:r").".h"<CR>"


"" Searching
set  ignorecase   " Do smart case matching
set  smartcase    " Do smart case matching
vnoremap // y/<C-R>"<CR><C-o>     " Search for visual selection
"map ** *:%s///gn<CR>2<C-o>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :.cc<CR><C-W><C-W>
" search in files word under cursor uses fugitive, vv and **
nmap <M-f> :cclose<CR>viwy**:Ag <c-r>"<CR>
vmap <M-f> y:cclose<CR>:Ag <c-r>"<CR>
nmap <c-f> :cclose<CR>viwy**<c-g><c-r>"<CR><leader>q<leader>q
vmap <c-f> y:cclose<CR><c-g>'<c-r>"'<CR><leader>q<leader>q
" nnoremap cgn cgn<c-r>"<c-left>


" Cursor
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" copy line N to cursor position
nnoremap gp ggyy<c-o>pkJa<CR><Esc>


" for jumps
set path+=$PWD/**
set tags=./tags;/


nnoremap <C-j> <PageDown>
nnoremap <C-k> <PageUp>

" vnoremap <S-Up> <Up>
" vnoremap <S-Down> <Down>

"" Stop that stupid window from popping up
noremap q: :q
command! W w

"" Stop unwanted scrolling during selection
vnoremap <S-up> <up>
vnoremap <S-down> <down>


"" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap ww w !sudo tee > /dev/null %


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
set virtualedit=block
set lazyredraw
set showtabline=2

"" tab-navigation
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

nnoremap t- :-tabmove<CR>
nnoremap t= :+tabmove<CR>

" <tab> / <s-tab> | Circular windows navigation
" nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" ----------------------------------------------------------------------------
" Move the current line, or a selected block of lines.
" ----------------------------------------------------------------------------
nnoremap <C-S-J> :m .+1<CR>==
nnoremap <C-S-K> :m .-2<CR>==
inoremap <C-S-J> <Esc>:m .+1<CR>==gi
inoremap <C-S-K> <Esc>:m .-2<CR>==gi
vnoremap <C-S-J> :m '>+1<CR>gv=gv
vnoremap <C-S-K> :m '<-2<CR>gv=gv

" ----------------------------------------------------------------------------
" Open FILENAME:LINE:COL
" ----------------------------------------------------------------------------
function! s:goto_line()
  let tokens = split(expand('%'), ':')
  if len(tokens) <= 1 || !filereadable(tokens[0])
    return
  endif

  let file = tokens[0]
  let rest = map(tokens[1:], 'str2nr(v:val)')
  let line = get(rest, 0, 1)
  let col  = get(rest, 1, 1)
  bd!
  silent execute 'e' file
  execute printf('normal! %dG%d|', line, col)
endfunction

autocmd vimrc BufNewFile * nested call s:goto_line()


silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

