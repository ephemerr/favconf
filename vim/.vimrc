set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required
Plugin 'wincent/command-t'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
" for languges
Plugin 'harishnavnit/vim-qml'
Plugin 'tpope/vim-unimpaired'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ============================================= PLUGINS 

""""""""""""""""""""""" YouCompleteMe 
let g:ycm_confirm_extra_conf = ''

"""""""""""""""""" NERDTree
map <C-n> :NERDTreeToggle<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""" Ack
let g:ackprg = 'rg --vimgrep'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
cnoreabbrev rg Ack
nmap \s :Ack<Space>

" =============================================  GENERAL

"""""""""""""""""""""" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

""""""""""""""""""""" Tabbing and indentation
set tabstop=4
set shiftwidth=4
set expandtab
"set cindent
"set backspace=indent,eol
set softtabstop=4

""""""""""""""""""""""" Window managment
set autowrite		" Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set splitbelow
nmap _ :ls!<Return>
map <C-l> :tabe 

""""""""""""""""""""""""" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1

""""""""""""""""""""""""" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :make -j4
set makeprg=colormake

"""""""""""""""""""""""" Clipboard
set clipboard=unnamedplus " System clipboard
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
"Set vim bracket highlighting colors
hi MatchParen cterm=none ctermbg=none ctermfg=blue
set hlsearch " Highlight searched word
set cursorline " Highlight current line
hi CursorLine cterm=bold ctermbg=none ctermfg=none


""""""""""""""""""""" OTHER

set smartcase		" Do smart case matching

set number " Show line numbers

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif


