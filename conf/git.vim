" blamer.nvim: disabled by default. It hooks CursorMoved + BufEnter and forks
" `git blame -L` on every cursor pause -- expensive in large repos. Toggle on
" demand with <leader>tb.
let g:blamer_enabled = 0
let g:blamer_delay = 1000
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = ' + '
let g:blamer_date_format = '%d/%m/%y'

nnoremap <leader>tb :BlamerToggle<CR>
