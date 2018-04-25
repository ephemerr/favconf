hi CursorLine ctermfg = none        cterm = bold
hi Normal     ctermfg = LightGray
hi MatchParen ctermfg = Blue        cterm = none    ctermbg = none 
hi Identifier ctermfg = Green       cterm = NONE
hi Type       ctermfg = Cyan        cterm = none
hi PreProc    ctermfg = Magenta     cterm = none
hi Constant   ctermfg = Red         cterm = NONE
hi Comment    ctermfg = DarkGray    cterm = NONE
hi Ignore     ctermfg = Black       cterm = NONE
hi Special    ctermfg = Magenta     cterm = NONE
hi Statement  ctermfg = White       cterm = NONE
hi Delimiter  ctermfg = Cyan        cterm = NONE
hi Visual     ctermfg = none        cterm = NONE    ctermbg = blue 


hi link Function     Identifier
hi link Member       Identifier
hi link Variable     Identifier
hi link Delimiter    Statement
hi link Namespace    Type
hi link EnumConstant Constant


highlight DiffAdd    cterm=bold ctermfg=Black ctermbg=Grey gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=Black ctermbg=Grey gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=Black ctermbg=Grey gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=Black ctermbg=Red gui=none guifg=bg guibg=Red

