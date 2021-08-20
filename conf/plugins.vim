" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'dylanaraps/wal'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'antoinemadec/coc-fzf'
Plug 'mbbill/undotree'
Plug 'chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'TovarishFin/vim-solidity'
Plug 'tpope/vim-surround'
Plug 'ap/vim-buftabline'
Plug 'ziglang/zig.vim'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'vimsence/vimsence'
Plug 'florentc/vim-tla'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'chriskempson/base16-vim'


call plug#end()
