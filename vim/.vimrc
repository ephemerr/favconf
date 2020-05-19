let $HOME      = "/home/me"
let $FAVHOME   = $HOME."/favconf"
let $MYVIMRC   = $HOME."/favconf/vim/.vimrc"
let $ZSHFILE   = $HOME."/favconf/zsh/.zshrc.local"
let $FISHFILE  = $HOME."/favconf/config.fish"
let $GITCONFIG = $HOME."/.gitconfig"

nnoremap <leader>V :tabe $HOME/.vim/bundle<CR>
nnoremap <leader>v :tabe $MYVIMRC<CR>
nnoremap <leader>z :tabe $ZSHFILE<CR>
nnoremap <leader>f :tabe $FISHFILE<CR>
nnoremap <leader>g :tabe $GITCONFIG<CR>
nnoremap <leader>a :tabe $FAVHOME/ag/agignore"<CR>
nnoremap <leader>x :tabe $FAVHOME/xbk/xbindkeysrc"<CR>
nnoremap <leader>. :tabe $FAVHOME<CR>
nnoremap <leader>p :tabe ~/.vim<CR>

command! Resource source $MYVIMRC

colorscheme base16-atlas

"" Fast vimrc update
augroup vimrc" {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
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
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/AnsiEsc.vim'

"" Text & movement
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'bkad/CamelCaseMotion'
" Plug 'terryma/vim-expand-region'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
" Plug 'sirver/ultisnips'
" Plug 'honza/vim-snippets'
" wellle/targets.vim
" reedes/vim-wordy
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'              "ai/ii
Plug 'kana/vim-textobj-line'                "al/il
Plug 'kana/vim-textobj-syntax'              "ay/iy
Plug 'jceb/vim-textobj-uri'                 "au/iu
Plug 'paulhybryant/vim-textobj-path'        "ap/ip
Plug 'Julian/vim-textobj-brace'             "aj/ij


"" Buffers
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-dirvish'
Plug 'mkitt/tabline.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'skywind3000/vim-terminal-help'

" ++++++ Development

Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar' ", { 'on': 'TagbarToggle' }
Plug 'derekwyatt/vim-fswitch'
Plug 'puremourning/vimspector'
" Plug 'liuchengxu/vista.vim'
" jreybert/vimagit

"" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

"" Formats & colors
Plug 'bronson/vim-trailing-whitespace'
Plug 'Valloric/MatchTagAlways'
Plug 'sheerun/vim-polyglot'
Plug 'fedorenchik/qt-support.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'vim-scripts/TagHighlight'
Plug 'jackguo380/vim-lsp-cxx-highlight'

"" Completion
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'ajh17/VimCompletesMe'
Plug 'neoclide/coc.nvim'
" Plug 'neovim/nvim-lsp'

if !has('nvim')
  Plug 'drmikehenry/vim-fixkey'
endif

call plug#end()

" ============================================= PLUGIN CONFIGURATION

"" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"" textobj-uri
call textobj#uri#add_pattern('', "\\v'[^']+'", 'idrop %s')
call textobj#uri#add_pattern('', "\\v[^ '\"]+", 'idrop %s')

"" Dirvish
map <F4> <Plug>(dirvish_up)
map gt :let $CURDIR=expand('%:p:h')<CR>:tabe<CR>:terminal<CR>icd $CURDIR<CR>
tmap jj <c-\><c-n>

"" vim-terminal-help
let g:terminal_edit="edit"

augroup MyTermMappings
  autocmd!
  autocmd TermOpen * nmap <buffer> <M-Enter> yaui<c-u>drop ./<c-\><c-n>pi<CR>
  autocmd TermOpen * nmap r i<c-u>drop .<CR>
  " autocmd TermOpen * nmap r i<c-c><c-\><c-n>Vy :e <c-r>" <CR>
augroup EN

"" Vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector

"" COC """""""""""""""""""""""""""""""""""""""""""
let g:coc_extension_root="/home/azzel/.config/coc/extensions"
let g:coc_start_at_startup = 0

" correct comment highlighting, add:
autocmd FileType json syntax match Comment +\/\/.\+$+

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"""
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""

" VimCompletesMe
autocmd FileType vim let b:vcm_tab_complete = 'vim'
autocmd FileType cpp let b:vcm_tab_complete = 'none'

"" Ack
"let g:ackprg = 'rg --vimgrep --ignore-file ~/favconf/ag/agignore'
let g:ackprg = 'ag --vimgrep -p ~/favconf/ag/agignore'
"
"""" Lightline
"""let g:lightline = {
"""      \ 'active': {
"""      \   'left': [ [ 'mode', 'paste' ],
"""      \             [ 'cocstatus', 'readonly', 'absolutepath', 'modified' ] ]
"""      \ },
"""      \ 'component_function': {
"""      \   'cocstatus': 'coc#status'
"""      \ },
"""      \ }
"""autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


"" T-comment
map -- gcc<Esc>
" let g:tcommentMapLeaderOp2
" let g:tcommentMapLeaderOp2
au BufRead,BufNewFile, *.pro   set filetype=qmake
au BufRead,BufNewFile, *.pri   set filetype=qmake
" call tcomment#type#Define('qmake','# %s')
" call tcomment#type#Define('ini',';%s')


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


"" FZF
let g:fzf_preview_window = ''

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep('git gr --line-number '.shellescape(<q-args>), 0, <bang>0)
command! -bang -nargs=* Rg
      \ call fzf#vim#grep('rg --vimgrep '.shellescape(<q-args>), 0, <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#grep(), <bang>0)

nmap g~ :e $HOME<CR>
nmap gp :Files<CR>
nmap gh :History<CR>
nmap gb :Buffers<CR>
nmap gP :tabe<CR>:Files<CR>
nmap gH :tabe<CR>:History<CR>
nmap gB :tabe<CR>:Buffers<CR>
nmap gn :tabe<CR>
nmap di :tabe<CR>:term<CR>idi<CR>

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

"" Gutentags
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1


"" Gutentags_plus
nmap <c-g> viwy<c-c>:GscopeFind<Space>s<Space><c-r>"<CR><c-c><c-c>


"" Fugitive
call SetupCommandAlias("Gr","Ggrep -I --recurse-submodules")
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"" TagBar
map <F3> :TagbarToggle<CR>
" autocmd filetype cpp nested TagbarOpen


"" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"=============================================  GENERAL


"" Tabbing and indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
nnoremap <c-z> <nop>
nnoremap <c-t> :tabe<CR>
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
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

"" Quickfix & Asyncrun
command! CocCleanBufRestart call DeleteHiddenBuffers() | CocRestart
command! DeleteHiddenBuffers call DeleteHiddenBuffers()

aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END


"" AsyncRun
noremap <F7> :wa<CR>:DeleteHiddenBuffers<CR>:CocRestart<CR>
noremap <F8> :wa<CR>:AsyncStop<CR>:AsyncRun make install <CR><F7>
inoremap <F7> <Esc><F7>i
inoremap <F8> <Esc><F8>i
noremap <F5> :AsyncRun make run
nnoremap <c-q> :call asyncrun#quickfix_toggle(10)<cr>zz

let g:asyncrun_open = 10
let g:asyncrun_exit = "!zenity --notification --text 'AsyncRun complete'"
let g:asyncrun_bell = 1

noremap [s :colder<CR>
noremap ]s :cnewer<CR>

"" Clipboard
set clipboard+=unnamedplus
set mouse=a   " Enable mouse usage (all modes)
noremap <Delete> "_d<Right>
inoremap <Backspace> <Left><Delete>
" annihilating
noremap xx "_dd
noremap x "_d
noremap X "_D
" for multiple replaces
vnoremap p p:let @+=@0 <CR>
vnoremap P P:let @+=@0 <CR>
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
hi! link ExtraWhitespace Visual
autocmd FileType vim,js,qml,c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :FixWhitespace


"" Colors
set hlsearch " Highlight searched word
set cursorline " Highlight current line
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256 " 256 color mode
set termguicolors

hi! link CocHighlightText Special

hi! link CursorLine     clear
hi! link CursorLineNr   Special
hi! link StatusLine     Visual
hi! link QuickFixLine   Special
hi! link Visual         CursorColumn
hi! link MatchParen     Special

hi SignColumn   guibg = none
hi LineNr       guibg = none
hi TabLine      guibg = none
hi TabLineSel   guibg = none

hi! link Repeat       Keyword
hi! link Conditional  Keyword
hi! link Label        Keyword
hi! link Exception    Keyword
hi! link StorageClass Keyword
hi! link cppModifier  Keyword
hi! link Function     Identifier
hi! link Member       Identifier
hi! link Variable     Identifier
hi! link Delimiter    Statement
hi! link Namespace    Type
hi! link EnumConstant Constant

" Coc
hi default CocUnderline    cterm=underline gui=underline
hi default CocErrorSign    ctermfg=Red     guifg=#ff0000
hi default CocWarningSign  ctermfg=Brown   guifg=#ff922b
hi default CocInfoSign     ctermfg=Yellow  guifg=#fab005
hi default CocHintSign     ctermfg=Blue    guifg=#15aabf
hi default CocSelectedText ctermfg=Red     guifg=#fb4934
hi default CocCodeLens     ctermfg=Gray    guifg=#999999
hi default link CocErrorFloat       CocErrorSign
hi default link CocWarningFloat     CocWarningSign
hi default link CocInfoFloat        CocInfoSign
hi default link CocHintFloat        CocHintSign
hi default link CocErrorHighlight   CocUnderline
hi default link CocWarningHighlight CocUnderline
hi default link CocInfoHighlight    CocUnderline
hi default link CocHintHighlight    CocUnderline
hi default link CocListMode ModeMsg
hi default link CocListPath Comment
hi default link CocHighlightText  CursorColumn
if has('nvim')
  hi default link CocFloating NormalFloat
else
  hi default link CocFloating Pmenu
endif


hi default link CocHoverRange     Search
hi default link CocCursorRange    Search
hi default link CocHighlightRead  CocHighlightText
hi default link CocHighlightWrite CocHighlightText


map <M-F11>  :sp tags<CR>:%s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/<CR>:wq! tags.vim<CR>/^<CR><F12>
map <M-F12>  :so tags.vim<CR>

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
" noremap  <leader>f :let @*=@%<CR>
inoremap \fh #include "<C-R>=expand("%:t:r").".h"<CR>"


"" Searching
set  ignorecase   " Do smart case matching
set  smartcase    " Do smart case matching
vnoremap // y/<C-R>"<CR><C-o>     " Search for visual selection
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :.cc<CR><C-W><C-W>
" search in files word under cursor uses fugitive, vv and **
nmap <c-f> :cclose<CR>viwy**:Ack <c-r>"<CR>
vmap <c-f> y:cclose<CR>:Ack '<c-r>"'<CR>
nmap <M-f> viwy**<c-t>:Ack <c-r>"<CR>
vmap <M-f> y<c-t>: Ack '<c-r>"'<CR>
command! CountMatches %s///gn


"" Cursor
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" for jumps
set path+=$PWD/**
set tags=./tags;/
" set cscopetag cscopeverbose

"" Stop that stupid window from popping up
noremap q: :q
command! W w
command! Q q

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
set laststatus=0
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
nnoremap to  :tabe<CR>
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

map <M-J> PgUp
map <M-K> PgDown

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


if !has('nvim')
  let g:terminal_scrollback_buffer_size = 100000
  set clipboard=autoselect "  clipboard
endif

" disable Python2 support
let g:loaded_python_provider = 0

" confirm-quit
fun! ConfirmQuit(command)
	let l:confirmed = confirm('Do you really want to quit?', "&Yes\n&No", 2)
	if l:confirmed == 1
		exec a:command
	endif
endfun

cnoremap <silent> xa<CR>  :call ConfirmQuit('xa')<CR>
cnoremap <silent> qa<CR>  :call ConfirmQuit('qa')<CR>

