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
    Plug 'tpope/vim-fugitive'
    Plug 'preservim/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-surround'
    Plug 'windwp/nvim-autopairs'
    Plug 'chiel92/vim-autoformat'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'karb94/neoscroll.nvim'
    Plug 'phaazon/hop.nvim'

    " tabs/buffers
    Plug 'ap/vim-buftabline'

    " theme
    Plug 'RRethy/nvim-base16'

    " ctags
    Plug 'majutsushi/tagbar'
    Plug 'ternjs/tern_for_vim'

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
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " snippets
    Plug 'honza/vim-snippets'
    Plug 'L3MON4D3/LuaSnip'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    " lsp 
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'nvim-lua/lsp_extensions.nvim'

    " lsp completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'ray-x/lsp_signature.nvim'

    " debug
    Plug 'mfussenegger/nvim-dap'
    Plug 'nvim-telescope/telescope-dap.nvim'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'

    " github
    Plug 'pwntester/octo.nvim'

    " pops
    Plug 'nvim-lua/popup.nvim'

    " Browser!
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) },  'tag': 'v0.2.6' }

call plug#end()
