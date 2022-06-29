" Using Lua functions
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-m-f> <cmd>lua require('telescope.builtin').live_grep({cwd = vim.fn.expand "%:p:h"})<cr>
nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <C-m-q> <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <C-x> <cmd>lua require('telescope.builtin').resume()<cr>


" lsp 
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>

" general
nnoremap gv <cmd>lua require('telescope.builtin').treesitter()<cr>

nnoremap <leader>tch <cmd>lua require('telescope.builtin').command_history()<cr>
nnoremap <leader>of <cmd>lua require('telescope.builtin').oldfiles()<cr>

" git 
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gbc <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>gh <cmd>lua require('telescope.builtin').git_stash()<cr>
nnoremap <leader>gd <cmd>lua require('mod').git_diff()<cr>

nnoremap <leader>gi <cmd>lua require('telescope').extensions.gh.issues()<cr>
nnoremap <leader>gp <cmd>lua require('telescope').extensions.gh.pull_request()<cr>
nnoremap <leader>gg <cmd>lua require('telescope').extensions.gh.gist()<cr>
nnoremap <leader>gr <cmd>lua require('telescope').extensions.gh.run()<cr>

" misc
nnoremap my :Telescope neoclip<cr>
nnoremap <leader>tcm <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>tcs <cmd>lua require('telescope.builtin').colorscheme()<cr>
nnoremap <leader>tsp <cmd>lua require('telescope.builtin').spell_suggest()<cr>
nnoremap <leader>thi <cmd>lua require('telescope.builtin').highlights()<cr>
nnoremap <leader>tma <cmd>lua require('telescope.builtin').man_pages()<cr>
nnoremap <leader>tgd <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap mm   <cmd>lua require('telescope').extensions.harpoon.marks()<cr>

" dap
nnoremap <leader>db <cmd>lua require('telescope').extensions.dap.list_breakpoints()<CR>

nnoremap <leader>dc <cmd>lua require('telescope').extensions.dap.commands()<CR>
nnoremap <leader>dv <cmd>lua require('telescope').extensions.dap.variables()<CR>
nnoremap <leader>df <cmd>lua require('telescope').extensions.dap.frames()<CR>

nnoremap <leader>dcf <cmd>lua require('telescope').extensions.dap.configurations()<CR>

