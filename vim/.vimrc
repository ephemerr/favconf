" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
hi MatchParen   ctermbg=black ctermfg=blue 
hi Pmenu        ctermbg=black ctermfg=blue 
hi PmenuSel     ctermbg=white ctermfg=black 
hi PmenuBar     ctermbg=white ctermfg=blue 
hi PmenuThumb   ctermbg=white ctermfg=blue 
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

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
set tabstop=2
set shiftwidth=2 
set expandtab
"set cindent
"set backspace=indent,eol
set softtabstop=2

""""""""""""""""""""" ctags key
"map <C-[> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"""""""""""""""""""""
set number " Show line numbers

""""""""""""""""""""
set hlsearch " Highlight searched word

""""""""""""""""""""""" Window managment
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set splitbelow
nmap _ :ls!<Return>
map <C-l> :tabe 
map <C-F1> :tab help 
nmap <S-Tab> <C-^>
nmap <C-h> ggeegf   " Go to header

""""""""""""""""""""""""" Folding
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1

""""""""""""""""""""""""" Compilation
"au QuickfixCmdPost make splint %
nmap <F8> :make
set makeprg=colormake

"""""""""""""""""""""""" Clipboard
"nmap <C-v> :<C-r>"
"imap <C-i> <Esc>"0P 
nmap <C-P> "0P 

"""""""""""""""""""""""""" Tags
imap <C-_> <C-X><C-]>:buf<Space> 
map <C-F11>  :sp tags<CR>:%s/^\([^     :]*:\)\=\([^    ]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
map <C-F12>  :so tags.vim<CR>

"""""""""""""""""""""""""""" Disable Replace mode by second <Insert>
imap <Insert> <Esc><Right>
"imap <Esc> <Esc><Right>

"""""""""""""""""""""""""""" Line breaks
set textwidth=123
set wrapmargin=0
set formatoptions=cqt

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


"command Rs call RS()
"command Ss call SS()



