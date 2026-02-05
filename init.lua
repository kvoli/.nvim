-- Pre-plugin settings (mapleader MUST be set before lazy.setup)
vim.g.did_load_filetypes = 1
vim.cmd('source $HOME/.config/nvim/conf/settings.vim')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup('plugins', {
  install = { colorscheme = { 'darcula' } },
  change_detection = { enabled = false },
})

-- Source remaining VimL config files
vim.cmd('source $HOME/.config/nvim/conf/mappings.vim')
vim.cmd('source $HOME/.config/nvim/conf/complete.vim')
vim.cmd('source $HOME/.config/nvim/conf/start-screen.vim')
vim.cmd('source $HOME/.config/nvim/conf/git.vim')
vim.cmd('source $HOME/.config/nvim/conf/tex.vim')
vim.cmd('source $HOME/.config/nvim/conf/buftabline.vim')
vim.cmd('source $HOME/.config/nvim/conf/neovide.vim')
vim.cmd('source $HOME/.config/nvim/conf/ctags.vim')
vim.cmd('source $HOME/.config/nvim/conf/telescope.vim')

-- Load Lua modules
require('mod')
require('lsp')
require('completion')
require('telescope_config')
require('dap_config')
require('git')
require('treesitter')
require('tools')
