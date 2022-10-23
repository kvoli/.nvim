-- Bloated file! 
-- need to split it up into lsp, completion and other.
--
vim.g.did_load_filetypes = 1


local lspconfig = require('lspconfig')
local types = require('cmp.types')
local WIDE_HEIGHT = 40


-- Diagnostics {{{
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
-- }}}
--vim.cmd ('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({border="single", focusable=false})')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits', },
}

local virtualtypes = require("virtualtypes")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>gr', '<cmd>lua require("mod").lsp_references()<CR>', opts)
  buf_set_keymap('n', '<space>gi', '<cmd>lua require("mod").lsp_implementations()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>fr', '<cmd>lua require("mod").file_browser()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd> lua vim.lsp.buf.format{ async = true }<CR>', opts)

  vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = border, focusable = false })
  vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = border, focusable = false })

  virtualtypes.on_attach()
  require "lsp_signature".on_attach({
    bind = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    fix_pos = false,
    hint_enable = false,
    hint_prefix = " ",
    hint_scheme = "String",
    use_lspsaga = false,
    hi_parameter = "Cursor",
    max_height = 12,
    max_width = 80,
    transparency = 100,
    handler_opts = { border = "single" },
    trigger_on_newline = false,
    debug = false,
    padding = '',
    shadow_blend = 0,
    shadow_guibg = 'Black',
    timer_interval = 200,
    doc_lines = 20,
  })

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local local_servers = { 'ccls' }
for _, lsp in ipairs(local_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end


local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = { 
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }

  server:setup(opts)
end)

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- luasnip setup
local luasnip = require 'luasnip'

--local tabnine = require('cmp_tabnine.config')
--tabnine:setup({
--        max_lines = 1000;
--        max_num_results = 20;
--        sort = true;
--    run_on_every_keystroke = true;
--    snippet_placeholder = '..';
--})


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.TextChanged,
    },
    completeopt = 'menu,menuone,noselect',
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },
  window= {
    window = {
       completion = cmp.config.window.bordered(),
       documentation = {
          border = { '+', '-', '+', '|', '+', '-', '+', '|' },
          winhighlight = 'NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder',
          maxwidth = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
          maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
       },
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'tmux',
      option = {
        all_panes = false,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {},
      }
    },
    { name = 'cmp_tabnine' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


require('rust-tools').setup({})
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.setup({})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

require('nvim-autopairs').enable()


npairs.add_rule(Rule("$$","$$","tex"))

-- you can use some built-in condition

local cond = require('nvim-autopairs.conds')

npairs.add_rules({
  Rule("$", "$",{"tex", "latex"})
    -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex_check("%%"))
    -- don't add a pair if  the previous character is xxx
    :with_pair(cond.not_before_regex_check("xxx", 3))
    -- don't move right when repeat character
    :with_move(cond.none())
    -- don't delete if the next character is xx
    :with_del(cond.not_after_regex_check("xx"))
    -- disable add newline when press <cr>
    :with_cr(cond.none())
},
  --it is not working on .vim but it working on another filetype
  Rule("a","a","-vim")
)

npairs.add_rules({
  Rule("$$","$$","tex")
    :with_pair(function(opts)
      print(vim.inspect(opts))
      if opts.line=="aa $$" then
        -- don't add pair on that line
        return false
      end
    end)
}
)

require'FTerm'.setup({
  -- Filetype of the terminal buffer
  ft = 'FTerm',

  -- Command to run inside the terminal. It could be a `string` or `table`
  cmd = os.getenv('SHELL'),

  border = { {'╔', "MoreMsg" }, {'═', "MoreMsg"}, {'╗', "MoreMsg"}, {'║', "MoreMsg"}, {'╝', "MoreMsg"}, {'═', "MoreMsg"}, {'╚',"MoreMsg"}, {'║', "MoreMsg"} },

  -- Close the terminal as soon as shell/command exits.
  -- Disabling this will mimic the native terminal behaviour.
  auto_close = true,

  -- Highlight group for the terminal. See `:h winhl`
  hl = 'Normal',

  -- Transparency of the floating window. See `:h winblend`
  blend = 20,

  -- Object containing the terminal window dimensions.
  -- The value for each field should be between `0` and `1`
  dimensions = {
    height = 0.85, -- Height of the terminal window
    width = 0.85, -- Width of the terminal window
    x = 0.5, -- X axis of the terminal window
    y = 0.5, -- Y axis of the terminal window
  },

  -- Callback invoked when the terminal exits.
  -- See `:h jobstart-options`
  on_exit = nil,

  -- Callback invoked when the terminal emits stdout data.
  -- See `:h jobstart-options`
  on_stdout = nil,

  -- Callback invoked when the terminal emits stderr data.
  -- See `:h jobstart-options`
  on_stderr = nil,
})

-- Example keybindings
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

require('neoclip').setup()
require('colorizer').setup()

local previewers = require('telescope.previewers')
local Job = require('plenary.job')
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = 'file',
    args = { '--mime-type', '-b', filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], '/')[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
        end)
      end
    end
  }):sync()
end

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    buffer_previewer_maker = new_maker,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
    vimgrep_arguments = {
      'rg', '--color=never', '--no-heading',
      '--with-filename', '--line-number',
      '--column', '--smart-case'
    },
    results_title = false,
    preview_title = false,
    prompt_prefix = "❱ ",
    selection_caret = "❱ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.8, height = 0.6,
      prompt_position = "bottom",
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    border = {},
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    winblend = 10,
    previewer = true,
    color_devicons = true,
    use_less = false,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

local null_ls = require("null-ls")

require('dap')
require('dap-go').setup({
  external_config = {
    enabled = true,
  }
})
require("nvim-dap-virtual-text").setup {
  enabled = true,                     -- enable this plugin (the default)
  enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,            -- show stop reason when stopped for exceptions
  commented = true,                  -- prefix virtual text with comment string
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

require('Comment').setup()

require('telescope').load_extension('neoclip')
require('telescope').load_extension('fzf')
require('telescope').load_extension('gh')
require("telescope").load_extension('harpoon')
require("telescope").load_extension('goimpl')

require('neogen').setup { enabled = true }


require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})


local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>af", ":lua require('neogen').generate()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ac", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>at", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)

require"gitlinker".setup({
  opts = {
    remote = "source", -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
-- default mapping to call url generation with action_callback
  mappings = "<leader>gy"
})

require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
