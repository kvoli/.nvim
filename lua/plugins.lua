return {
  -- startpage
  { 'mhinz/vim-startify', lazy = false },

  -- misc
  { 'tpope/vim-vinegar', lazy = false },
  { 'numToStr/Comment.nvim', lazy = false },
  { 'mbbill/undotree', lazy = false },
  { 'tpope/vim-surround', lazy = false },
  { 'windwp/nvim-autopairs', lazy = false },
  { 'chiel92/vim-autoformat', lazy = false },
  { 'irfansharif/vim-crlfmt', lazy = false },
  { 'numtostr/FTerm.nvim', lazy = false },
  { 'norcalli/nvim-colorizer.lua', lazy = false },
  { 'phaazon/hop.nvim', lazy = false },
  { 'hrsh7th/vim-eft', lazy = false },
  { 'gelguy/wilder.nvim', lazy = false, build = ':UpdateRemotePlugins' },
  { 'tpope/vim-repeat', lazy = false },
  { 'jghauser/mkdir.nvim', lazy = false },
  { 'junegunn/vim-easy-align', lazy = false },
  { 'AndrewRadev/splitjoin.vim', lazy = false },
  { 'iamcco/markdown-preview.nvim', lazy = false, build = 'cd app && yarn install' },
  { 'folke/todo-comments.nvim', lazy = false },
  { 'stevearc/aerial.nvim', lazy = false },
  { 'kevinhwang91/promise-async', lazy = false },
  { 'kevinhwang91/nvim-ufo', lazy = false },
  { 'nvim-orgmode/orgmode', lazy = false },
  { 'nvim-tree/nvim-web-devicons', lazy = false },
  {
    dir = '/Users/kvoli/Documents/projects/leetcode.nvim',
    lazy = false,
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
      '3rd/image.nvim',
    },
    opts = {
      image_support = true,
    },
    config = function(_, opts)
      require("leetcode").setup(opts)
      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          if vim.bo.filetype == "leetcode.nvim" then
            vim.wo.wrap = true
            vim.wo.linebreak = true
          end
        end,
      })
    end,
  },

  -- test
  { 'nvim-neotest/neotest', lazy = false },
  { 'nvim-neotest/neotest-go', lazy = false },

  -- git
  { 'nvim-telescope/telescope-github.nvim', lazy = false },
  { 'ruifm/gitlinker.nvim', lazy = false },
  { 'nvim-telescope/telescope-frecency.nvim', lazy = false },
  { 'tami5/sqlite.lua', lazy = false },
  { 'TimUntersberger/neogit', lazy = false },
  { 'sindrets/diffview.nvim', lazy = false },
  { 'pwntester/octo.nvim', lazy = false },
  { 'APZelos/blamer.nvim', lazy = false },

  -- tabs/buffers
  { 'ap/vim-buftabline', lazy = false },

  -- theme
  { 'RRethy/nvim-base16', lazy = false },
  { 'kvoli/voidarcula', lazy = false },

  -- languages
  { 'lervag/vimtex', lazy = false },
  { 'mrcjkb/rustaceanvim', lazy = false },
  { 'ziglang/zig.vim', lazy = false },
  { 'florentc/vim-tla', lazy = false },
  { 'peitalin/vim-jsx-typescript', lazy = false },
  { 'pangloss/vim-javascript', lazy = false },
  { 'leafgarland/typescript-vim', lazy = false },
  { 'styled-components/vim-styled-components', lazy = false, branch = 'main' },
  { 'mickael-menu/zk-nvim', lazy = false },

  -- syntax (treesitter + LSP + none-ls cover linting/highlight; polyglot and
  -- syntastic removed to avoid duplicate BufEnter/CursorHold work)

  -- fuzzy finder
  { 'junegunn/fzf', lazy = false, build = function() vim.fn['fzf#install']() end },
  { 'nvim-lua/plenary.nvim', lazy = false },
  { 'nvim-telescope/telescope.nvim', lazy = false },
  { 'nvim-telescope/telescope-fzf-native.nvim', lazy = false, build = 'make' },
  { 'edolphin-ydf/goimpl.nvim', lazy = false },

  -- snippets
  { 'honza/vim-snippets', lazy = false },
  { 'L3MON4D3/LuaSnip', lazy = false },

  -- treesitter (pinned to master; main branch requires nvim 0.12+)
  { 'nvim-treesitter/nvim-treesitter', lazy = false, branch = 'master', build = ':TSUpdate' },
  { 'm-demare/hlargs.nvim', lazy = false },

  -- lsp
  { 'neovim/nvim-lspconfig', lazy = false },
  { 'nvim-lua/lsp_extensions.nvim', lazy = false },
  { 'williamboman/mason-lspconfig.nvim', lazy = false },
  { 'williamboman/mason.nvim', lazy = false },
  { 'nvimtools/none-ls.nvim', lazy = false },
  { 'j-hui/fidget.nvim', lazy = false },

  -- lsp completion
  { 'hrsh7th/nvim-cmp', lazy = false },
  { 'hrsh7th/cmp-buffer', lazy = false },
  { 'hrsh7th/cmp-nvim-lua', lazy = false },
  { 'hrsh7th/cmp-nvim-lsp', lazy = false },
  { 'hrsh7th/cmp-path', lazy = false },
  { 'saadparwaiz1/cmp_luasnip', lazy = false },
  { 'ray-x/lsp_signature.nvim', lazy = false },
  { 'nanotee/sqls.nvim', lazy = false },
  { 'jubnzv/virtual-types.nvim', lazy = false },

  -- debug
  { 'Pocco81/DAPInstall.nvim', lazy = false },
  { 'mfussenegger/nvim-dap', lazy = false },
  { 'nvim-telescope/telescope-dap.nvim', lazy = false },
  { 'rcarriga/nvim-dap-ui', lazy = false },
  { 'theHamsta/nvim-dap-virtual-text', lazy = false },
  { 'leoluz/nvim-dap-go', lazy = false },

  -- popups
  { 'nvim-lua/popup.nvim', lazy = false },

  -- comment gen
  { 'danymat/neogen', lazy = false },

  -- clipboard manager
  { 'AckslD/nvim-neoclip.lua', lazy = false },

  -- harpoon
  { 'ThePrimeagen/harpoon', lazy = false },
}
