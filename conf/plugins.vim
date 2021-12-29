" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " startpage
    Plug 'mhinz/vim-startify'

    " misc
    Plug 'preservim/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-surround'
    Plug 'windwp/nvim-autopairs'
    Plug 'chiel92/vim-autoformat'
    Plug 'irfansharif/vim-crlfmt'
    Plug 'numtostr/FTerm.nvim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'phaazon/hop.nvim'
    Plug 'hrsh7th/vim-eft'
    Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-repeat'
    Plug 'jghauser/mkdir.nvim'
    Plug 'junegunn/vim-easy-align'
    
    " tabs/buffers
    Plug 'ap/vim-buftabline'

    " theme
    Plug 'RRethy/nvim-base16'

    " languages
    Plug 'lervag/vimtex'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'ziglang/zig.vim'
    Plug 'florentc/vim-tla'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

    " syntax
    Plug 'vim-syntastic/syntastic'
    Plug 'sheerun/vim-polyglot'

    " fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'ibhagwan/fzf-lua'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    " snippets
    Plug 'honza/vim-snippets'
    Plug 'L3MON4D3/LuaSnip'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'romgrk/nvim-treesitter-context'

    " lsp 
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'williamboman/nvim-lsp-installer'

    " lsp completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'

    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'ray-x/lsp_signature.nvim'
    "Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    Plug 'andersevenrud/compe-tmux', { 'branch': 'cmp' }
    Plug 'nanotee/sqls.nvim'
    Plug 'jubnzv/virtual-types.nvim'

    " debug
    Plug 'Pocco81/DAPInstall.nvim'
    Plug 'mfussenegger/nvim-dap'
    Plug 'nvim-telescope/telescope-dap.nvim'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'

    " git
    "Plug 'pwntester/octo.nvim'
    "Plug 'sindrets/diffview.nvim'
    Plug 'APZelos/blamer.nvim'
    "Plug 'tpope/vim-fugitive'

    " pops
    Plug 'nvim-lua/popup.nvim'

    " Comment Gen
    Plug 'danymat/neogen'
    "
    " clipboard manager
    Plug  'AckslD/nvim-neoclip.lua' 

    " Filetype 
    Plug  'nathom/filetype.nvim'


call plug#end()
