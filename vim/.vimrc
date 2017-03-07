set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required
Plugin 'Valloric/YouCompleteMe'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'junegunn/fzf.vim'
" for languges
Plugin 'harishnavnit/vim-qml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


" ============================================= PLUGINS 

""""""""""""""""""""""" FZF 
" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nmap <leader>a :Ag<CR>
nmap <leader>r :Rg<CR>
nmap <leader>o :Files<CR>
nmap <leader>l :Locate<Space>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
nmap <leader>e :History:<CR>
nmap <leader>s :History/<CR>
nmap <leader>i :Lines<CR>
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

"""""""""""""""""" NERDTree
map <C-n> :NERDTreeToggle<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""" Ack
"let g:ackprg = 'rg --vimgrep'

" =============================================  GENERAL

"""""""""""""""""""""" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

""""""""""""""""""""" Tabbing and indentation
set tabstop=2
set shiftwidth=2
set expandtab
"set cindent
"set backspace=indent,eol
set softtabstop=2

""""""""""""""""""""""" Window managment
set autowrite		" Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set splitright
set splitbelow
autocmd FileType help wincmd L " make help go right
nmap _ :ls!<Return>
nmap [<Tab> gT 
nmap ]<Tab> gt 

""""""""""""""""""""""""" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1
hi Folded ctermbg=none

""""""""""""""""""""""""" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :make 
set makeprg=colormake

"""""""""""""""""""""""" Clipboard
set clipboard=autoselect " System clipboard
set mouse=a		" Enable mouse usage (all modes)

"""""""""""""""""""""""""""" Disable Replace mode by second <Insert>
imap <Insert> <Esc><Right>

"""""""""""""""""""""""""""" Line breaks
set nowrap
set textwidth=0
set wrapmargin=0
set formatoptions=cq "t

"""""""" Automatically removing all trailing whitespace
autocmd FileType haml autocmd BufWritePre <buffer> :%s/\s\+$//e

""""""""" Colors
syntax on
set hlsearch " Highlight searched word
set cursorline " Highlight current line
hi CursorLine cterm=bold ctermbg=none ctermfg=none
hi MatchParen cterm=none ctermbg=none ctermfg=blue   """"Set vim bracket highlighting colors

""""""""""""""""""""" OTHER

set smartcase		" Do smart case matching

set number " Show line numbers

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


