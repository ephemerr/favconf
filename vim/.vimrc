set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'  " let Vundle manage Vundle, required
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/command-t'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'harishnavnit/vim-qml'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'

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

" Silver Search
let g:ackprg = 'ag --vimgrep'                                                   
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

syntax on
hi MatchParen   ctermbg=black ctermfg=blue
hi Pmenu        ctermbg=black ctermfg=blue
hi PmenuSel     ctermbg=white ctermfg=black
hi PmenuBar     ctermbg=white ctermfg=blue
hi PmenuThumb   ctermbg=white ctermfg=blue
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark
"colorscheme solarized
"set t_Co=16

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
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

""""""""""""""""""""" ctags key
"map <C-[> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"""""""""""""""""""""
set number " Show line numbers
set cursorline " Highlight current line
hi CursorLine cterm=bold ctermbg=none ctermfg=none

""""""""""""""""""""
set hlsearch " Highlight searched word

""""""""""""""""""""""" Window managment
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set splitbelow
nmap _ :ls!<Return>
map <C-l> :tabe ./
map <S-F1> :tab help
nmap <C-h> ggeegf   " Go to header

""""""""""""""""""""""""" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1

""""""""""""""""""""""""" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :make
nmap <F5> :%s=\s\+$==
set makeprg=colormake

"""""""""""""""""""""""" Clipboard
"nmap <C-v> :<C-r>"
"imap <C-i> <Esc>"0P
"nmap <C-P> "0P

"""""""""""""""""""""""""" Tags
nmap <S-Tab> <C-^>
imap <C-_> <C-X><C-]>:buf<Space>
map <C-F11>  :sp tags<CR>:%s/^\([^     :]*:\)\=\([^    ]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
map <C-F12>  :so tags.vim<CR>

"""""""""""""""""""""""""""" Disable Replace mode by second <Insert>
imap <Insert> <Esc><Right>
"imap <Esc> <Esc><Right>

"""""""""""""""""""""""""""" Line breaks
set nowrap
set textwidth=0
set wrapmargin=0
set formatoptions=cq "t

"""""""""""""""""""""""""""" Commenting blocks of code.
augroup filetype_comments
    autocmd!
    autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
    autocmd FileType sh,ruby,python   let b:comment_leader = '# '
    autocmd FileType conf,fstab       let b:comment_leader = '# '
    autocmd FileType tex              let b:comment_leader = '% '
    autocmd FileType mail             let b:comment_leader = '> '
    autocmd FileType vim              let b:comment_leader = '" '
augroup END

"noremap <silent> <C-d> :silent s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> <C-D> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


"""""""""""""""""""""""""""" LATEX.
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

set iskeyword+=:

"""""""""""""""""""""""""""" Sessions
fu! SS()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RS()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
endif
endfunction


command Rs call RS()
command Ss call SS()


"""""""" Automatically removing all trailing whitespace
autocmd FileType c,h,haml autocmd BufWritePre <buffer> :%s/\s\+$//e

""""""""""" Set vim bracket highlighting colors
hi MatchParen cterm=none ctermbg=none ctermfg=blue

au BufNewFile,BufRead *.less set filetype=less

" NERDTree toggle
map <C-n> :NERDTreeToggle<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


