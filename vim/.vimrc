set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required
Plugin 'mhinz/vim-signify'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'junegunn/fzf.vim'
Plugin 'chiel92/vim-autoformat'
Plugin 'vim-airline/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'harishnavnit/vim-qml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


" ============================================= PLUGINS

""""""""""""""""""""""" multiple-cursors

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-f>'
let g:multi_cursor_prev_key='<C-d>'
let g:multi_cursor_skip_key='<C-s>'
let g:multi_cursor_quit_key='<Esc>'

""""""""""""""""""""""" Autoformat

noremap <F3> :Autoformat<CR>

"""""""""""""""""""""""" Tagbar
nmap <c-m> :TagbarToggle<CR>

""""""""""""""""""""""" FZF
"To use ripgrep instead of ag:
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

nmap <leader>a :Ag<CR>
nmap <leader>r :Rg<CR>
nmap <leader>g :GGrep<CR>
nmap <leader>o :Files<CR>
nmap <leader>l :Locate<Space>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>e :History:<CR>
nmap <leader>c :Commands<CR>
nmap <leader>s :History/<CR>
nmap <leader>? :Helptags<CR>
nmap <leader>i :Lines<CR>
nmap <leader>t :Tags<CR>
nmap <leader>glog :Commits<CR>
nmap <leader>gls :GFiles<CR>
nmap <leader>gs :GFiles?<CR>

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


""""""""""""""""""""""" YouCompleteMe
let g:ycm_confirm_extra_conf = ''
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'


"""""""""""""""""" NERDTree
map <C-n> :NERDTreeToggle<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""" Unimpired
nmap [<Tab> gT
nmap ]<Tab> gt
nnoremap ]oyh :let g:ycm_enable_diagnostic_highlighting=0<CR>
nnoremap [oyh :let g:ycm_enable_diagnostic_highlighting=1<CR>
let g:ycm_enable_diagnostic_highlighting=1
let g:ycm_enable_diagnostic_signs=1

" =============================================  GENERAL

""""""""""""""""""""" Tabbing and indentation
set tabstop=2
set shiftwidth=2
set expandtab
"set cindent
"set backspace=indent,eol
set softtabstop=2

""""""""""""""""""""""" Window managment
set autowrite   " Automatically save before commands like :next and :make
set autoread
set hidden          " Hide buffers when they are abandoned
set splitright
set splitbelow
autocmd FileType help wincmd L " make help go right
nmap _ :ls!<Return>
nmap <c-l> :tabe<Space>
:imap <C-w> <C-o><C-w> "not accidentally deleting words anymore :-)

""""""""""""""""""""""""" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1
hi Folded ctermbg=none

""""""""""""""""""""""""" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :make
autocmd QuickFixCmdPost [^l]* nested cwindow " open quikfix with errors
autocmd QuickFixCmdPost    l* nested lwindow "

"""""""""""""""""""""""" Clipboard
set clipboard=autoselect " System clipboard
set mouse=a   " Enable mouse usage (all modes)

"""""""""""""""""""""""""""" Disable Replace mode by second <Insert>
imap <Insert> <Esc><Right>

"""""""""""""""""""""""""""" Line breaks
set nowrap
set textwidth=0
set wrapmargin=0
set formatoptions=cq "t

"""""""" Automatically removing all trailing whitespace
autocmd FileType c,cpp,h,haml autocmd BufWritePre <buffer> :%s/\s\+$//e

""""""""" Colors
syntax on
set hlsearch " Highlight searched word
set cursorline " Highlight current line
hi CursorLine cterm=bold ctermbg=none ctermfg=none
hi MatchParen cterm=none ctermbg=none ctermfg=blue   """"Set vim bracket highlighting colors
set background=dark

""""""""""""""""""""" OTHER

set ignorecase   " Do smart case matching
set smartcase   " Do smart case matching

set number " Show line numbers

set noswapfile

""" Header Guard for C/Cpp
function! g:MyAddGuard(s)
  let b:macro=a:s . toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g'))
  call append(0, ["#ifndef " . b:macro, "#define " . b:macro, ""])
  call append(line("$"), ["#endif /*" . b:macro . "*/"])
endfunction
command! -nargs=1 HeaderguardAdd call g:MyAddGuard(<f-args>)

inoremap \fn <C-R>=@%<CR> 
inoremap \fh #include "<C-R>=expand("%:t:r").".h"<CR>"


" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


