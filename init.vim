lua vim.g.did_load_filetypes = 1
source $HOME/.config/nvim/conf/settings.vim
source $HOME/.config/nvim/conf/mappings.vim
source $HOME/.config/nvim/conf/plugins.vim
source $HOME/.config/nvim/conf/complete.vim
source $HOME/.config/nvim/conf/start-screen.vim
source $HOME/.config/nvim/conf/git.vim
source $HOME/.config/nvim/conf/tex.vim
source $HOME/.config/nvim/conf/buftabline.vim
source $HOME/.config/nvim/conf/neovide.vim
source $HOME/.config/nvim/conf/ctags.vim
source $HOME/.config/nvim/conf/telescope.vim

lua require('mod')
lua require('lsp')
lua require('completion')
lua require('telescope_config')
lua require('dap_config')
lua require('git')
lua require('treesitter')
lua require('tools')
