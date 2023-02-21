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
    Plug 'tpope/vim-vinegar'
    Plug 'numToStr/Comment.nvim' 
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
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'folke/todo-comments.nvim'
    Plug 'stevearc/aerial.nvim'
    Plug 'kevinhwang91/promise-async'
    Plug 'kevinhwang91/nvim-ufo'
    Plug 'nvim-orgmode/orgmode'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'jackMort/ChatGPT.nvim'
    Plug 'MunifTanjim/nui.nvim'

    " test
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'nvim-neotest/neotest' 
    Plug 'nvim-neotest/neotest-go'

    " git 
    Plug 'nvim-telescope/telescope-github.nvim'
    Plug 'ruifm/gitlinker.nvim'
    Plug 'nvim-telescope/telescope-frecency.nvim'
    Plug 'tami5/sqlite.lua'
    Plug 'TimUntersberger/neogit'
    Plug 'sindrets/diffview.nvim'
    Plug 'pwntester/octo.nvim'
    Plug 'APZelos/blamer.nvim'
    
    " tabs/buffers
    Plug 'ap/vim-buftabline'

    " theme
    Plug 'RRethy/nvim-base16'
    Plug 'doums/darcula'

    " languages
    Plug 'lervag/vimtex'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'ziglang/zig.vim'
    Plug 'florentc/vim-tla'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    Plug 'mickael-menu/zk-nvim'

    " syntax
    Plug 'vim-syntastic/syntastic'
    Plug 'sheerun/vim-polyglot'

    " fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'edolphin-ydf/goimpl.nvim'
    " snippets
    Plug 'honza/vim-snippets'
    Plug 'L3MON4D3/LuaSnip'

    " treesitter
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'm-demare/hlargs.nvim'

    " lsp 
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'j-hui/fidget.nvim'

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
    Plug 'leoluz/nvim-dap-go'

    " pops
    Plug 'nvim-lua/popup.nvim'

    " Comment Gen
    Plug 'danymat/neogen'
    "
    " clipboard manager
    Plug  'AckslD/nvim-neoclip.lua' 

    " Filetype 

    " Harpoon
    Plug 'ThePrimeagen/harpoon'


call plug#end()
