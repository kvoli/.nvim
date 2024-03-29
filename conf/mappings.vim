nnoremap <D-j>    :resize -2<CR>
nnoremap <D-k>    :resize +2<CR>
nnoremap <D-h>    :vertical resize -2<CR>
nnoremap <D-l>    :vertical resize +2<CR>

" Use alt + hjkl to resize windows (normal)
nnoremap <C-j>  :resize -2<CR>
nnoremap <C-k>  :resize +2<CR>
nnoremap <C-h>  :vertical resize -2<CR>
nnoremap <C-l>  :vertical resize +2<CR>

"Make Y act like the other capital letters
nnoremap Y y$

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Place semi-colon at EOL
inoremap ;; <Esc>A;<Esc>

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
"
" change all occurences
nnoremap cn *``cgn
nnoremap cN *``cgN

" Center on movements
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z
nnoremap } }zzzv
nnoremap { {zzzv

" Moving text
vnoremap J :m '>+1'<CR>gv=gv
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

" Easy CAPS
"inoremap <c-u> <ESC>viwUi
"nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Close current buffer
nnoremap <M-w> :bd<CR>

" Use control-c instead of escape
nnoremap <C-c> <Esc>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" Map autocorrect for spelling
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"" Map normal
"vnoremap <C-n> :norm

" Map undo tree toggle
nnoremap <C-0> :UndotreeToggle<CR>

" remap change all occurences
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" map inkscape latex draw figures
inoremap <C-g> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-g> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" map tab swap on leader-<n in (1..9)>
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" Tagbar
nmap <C-s-t> :TagbarToggle<CR>

nmap <leader>fw :HopWord<CR>
nmap <leader>fl :HopLine<CR>
nmap <leader>fc :HopChar2<CR>

" enhanced f/t
nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)

nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)

nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)

"Neogit
nnoremap <leader>ng <cmd>Neogit<CR>

"Diff View
nnoremap <leader>vo <cmd>DiffviewOpen<CR>
nnoremap <leader>vc <cmd>DiffviewClose<CR>
nnoremap <leader>vh <cmd>DiffviewFileHistory %<CR>

" debugger dap mappings
nnoremap <silent> <leader>c        <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>so       <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>si       <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>su       <cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b        <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B        <cmd>lua require'dap'.set_breakpoint()<CR>
nnoremap <silent> <leader>bc       <cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp       <cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>Bdr      <cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl       <cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>rc       <cmd>lua require'dap'.run_to_cursor()<CR>

nnoremap <silent> <leader>td  <cmd>lua require('dap-go').debug_test()<CR>

nnoremap <silent> <leader>do <cmd>lua require("dapui").open()<CR>
nnoremap <silent> <leader>Do <cmd>lua require("dapui").close()<CR>
nnoremap <silent> <leader>du <cmd>lua require("dapui").toggle()<CR>
nnoremap <silent> <leader>ds <cmd>lua require("dapui").float_element('scopes', nil)<CR>

" harpoon mappings
nnoremap <C-n> :lua require("harpoon.mark").add_file()<CR>

" easy align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"markdown preview
nmap <C-Q> <Plug>MarkdownPreviewToggle<CR>

" spell
nnoremap <leader>s       <cmd>setlocal spell!<CR>

" chatgpt
nnoremap <silent> <leader>go <cmd>ChatGPT<CR>
nnoremap <silent> <leader>gn <cmd>ChatGPTCompleteCode<CR>
nnoremap <silent> <leader>ga <cmd>ChatGPTActAs<CR>
nnoremap <silent> <leader>ge <cmd>ChatGPTEditWithInstructions<CR>
