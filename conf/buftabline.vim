function! s:BufTabLineColors()
  hi BufTabLineCurrent         guibg=#000000 guifg=#ff8c00 ctermbg=0 ctermfg=208
  hi BufTabLineActive          guibg=#000000 guifg=#888888 ctermbg=0 ctermfg=245
  hi BufTabLineHidden          guibg=#000000 guifg=#888888 ctermbg=0 ctermfg=245
  hi BufTabLineFill            guibg=#000000 ctermbg=0
  hi BufTabLineModifiedCurrent guibg=#000000 guifg=#ff8c00 ctermbg=0 ctermfg=208
  hi BufTabLineModifiedActive  guibg=#000000 guifg=#888888 ctermbg=0 ctermfg=245
  hi BufTabLineModifiedHidden  guibg=#000000 guifg=#888888 ctermbg=0 ctermfg=245
endfunction

autocmd ColorScheme * call s:BufTabLineColors()
call s:BufTabLineColors()

let g:buftabline_numbers=2                " show ordinal numbers
