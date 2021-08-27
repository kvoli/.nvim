" Using Lua functions
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-f> <cmd>lua require('telecope.builtin').live_grep()cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" lsp 
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>

" git 
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gbc <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>

" misc
nnoremap <leader>tcm <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>tcs <cmd>lua require('telescope.builtin').colorscheme()<cr>
nnoremap <leader>tsp <cmd>lua require('telescope.builtin').spell_suggest()<cr>
nnoremap <leader>thi <cmd>lua require('telescope.builtin').highlights()<cr>
nnoremap <leader>tma <cmd>lua require('telescope.builtin').man_pages()<cr>
