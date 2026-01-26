-- Bloated file!
-- need to split it up into lsp, completion and other.
--

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
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
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

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

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
  buf_set_keymap('n', '<space>f', '<cmd> lua vim.lsp.buf.format{ async = true }<CR>', opts)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, focusable = false })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
    { border = border, focusable = false })

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

local lsp_opts = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").gopls.setup(lsp_opts)
require("lspconfig").dockerls.setup(lsp_opts)
require("lspconfig").bashls.setup(lsp_opts)
require("lspconfig").html.setup(lsp_opts)
require("lspconfig").ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_opts.flags,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/language-server",
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
require("lspconfig").lua_ls.setup(lsp_opts)
require("lspconfig").vue_ls.setup(lsp_opts)
require("lspconfig").marksman.setup(lsp_opts)
require("lspconfig").jedi_language_server.setup(lsp_opts)
require("lspconfig").sqlls.setup(lsp_opts)
require("lspconfig").taplo.setup(lsp_opts)
require("lspconfig").yamlls.setup(lsp_opts)

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- luasnip setup
local luasnip = require 'luasnip'

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
  window = {
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
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'tmux',
      option = {
        all_panes = false,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {},
      }
    },
    { name = 'buffer' },
    { name = 'path' },
  },
}



require('rust-tools').setup({})
local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.setup({})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

require('nvim-autopairs').enable()


npairs.add_rule(Rule("$$", "$$", "tex"))

-- you can use some built-in condition

local cond = require('nvim-autopairs.conds')

npairs.add_rules({
    Rule("$", "$", { "tex", "latex" })
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
  Rule("a", "a", "-vim")
)

npairs.add_rules({
  Rule("$$", "$$", "tex")
      :with_pair(function(opts)
        print(vim.inspect(opts))
        if opts.line == "aa $$" then
          -- don't add pair on that line
          return false
        end
      end)
}
)

require('hlargs').setup {
  color = '#fddac9',
}

require 'FTerm'.setup({
  -- Filetype of the terminal buffer
  ft = 'FTerm',
  -- Command to run inside the terminal. It could be a `string` or `table`
  cmd = os.getenv('SHELL'),
  border = { { '╔', "MoreMsg" }, { '═', "MoreMsg" }, { '╗', "MoreMsg" }, { '║', "MoreMsg" }, { '╝', "MoreMsg" }, { '═', "MoreMsg" }, { '╚', "MoreMsg" }, { '║', "MoreMsg" } },
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
    width = 0.85,  -- Width of the terminal window
    x = 0.5,       -- X axis of the terminal window
    y = 0.5,       -- Y axis of the terminal window
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
require('telescope').setup {
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
    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    border = {},
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    winblend = 10,
    previewer = true,
    color_devicons = true,
    use_less = false,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

-- local null_ls = require("null-ls")
--
-- null_ls.setup({
--   sources = {
--     null_ls.builtins.formatting.eslint_d,
--     null_ls.builtins.diagnostics.proselint,
--     null_ls.builtins.code_actions.proselint,
--     null_ls.builtins.hover.printenv,
--   },
-- })
--

vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = '', linehl = '', numhl = '' })

require('Comment').setup()

require('telescope').load_extension('neoclip')
require('telescope').load_extension('fzf')
require('telescope').load_extension('gh')
require("telescope").load_extension('harpoon')
require("telescope").load_extension('goimpl')
require('telescope').load_extension('aerial')

require('neogen').setup { enabled = true }

require("neogit").setup()


local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>af", ":lua require('neogen').generate()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ac", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>at", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)

require "gitlinker".setup({
  opts = {
    remote = "source", -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require "gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
  -- default mapping to call url generation with action_callback
  mappings = "<leader>gy"
})

require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '[', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', ']', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<leader>A', '<cmd>AerialToggle!<CR>')

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' +++ %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end,
  fold_virt_text_handler = handler
})


-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = { 'org' },
  },
}

require 'nvim-web-devicons'.setup()

local actions = require("diffview.actions")

require("diffview").setup({
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  git_cmd = { "git" },      -- The git executable followed by default args.
  hg_cmd = { "hg" },        -- The hg executable followed by default args.
  use_icons = true,         -- Requires nvim-web-devicons
  show_help_hints = true,   -- Show hints for how to open the help panel
  watch_index = true,       -- Update views and index buffers when the git index changes.
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  hooks = {},                 -- See ':h diffview-config-hooks'
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { "n", "<tab>",      actions.select_next_entry,         { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",    actions.select_prev_entry,         { desc = "Open the diff for the previous file" } },
      { "n", "gf",         actions.goto_file_edit,            { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>", actions.goto_file_split,           { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",    actions.goto_file_tab,             { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",  actions.focus_files,               { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",  actions.toggle_files,              { desc = "Toggle the file panel." } },
      { "n", "<leader>la", actions.cycle_layout,              { desc = "Cycle through available layouts." } },
      { "n", "[x",         actions.prev_conflict,             { desc = "In the merge-tool: jump to the previous conflict" } },
      { "n", "]x",         actions.next_conflict,             { desc = "In the merge-tool: jump to the next conflict" } },
      { "n", "<leader>co", actions.conflict_choose("ours"),   { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>cb", actions.conflict_choose("base"),   { desc = "Choose the BASE version of a conflict" } },
      { "n", "<leader>ca", actions.conflict_choose("all"),    { desc = "Choose all the versions of a conflict" } },
      { "n", "dx",         actions.conflict_choose("none"),   { desc = "Delete the conflict region" } },
    },
    diff1 = {
      -- Mappings in single window diff layouts
      { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
    },
    diff2 = {
      -- Mappings in 2-way diff layouts
      { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
    },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do", actions.diffget("ours"),           { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do", actions.diffget("theirs"),         { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",  actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do", actions.diffget("base"),           { desc = "Obtain the diff hunk from the BASE version of the file" } },
      { { "n", "x" }, "2do", actions.diffget("ours"),           { desc = "Obtain the diff hunk from the OURS version of the file" } },
      { { "n", "x" }, "3do", actions.diffget("theirs"),         { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      { "n",          "g?",  actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
    },
    file_panel = {
      { "n", "j",             actions.next_entry,          { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,          { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,          { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<up>",          actions.prev_entry,          { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<cr>",          actions.select_entry,        { desc = "Open the diff for the selected entry." } },
      { "n", "o",             actions.select_entry,        { desc = "Open the diff for the selected entry." } },
      { "n", "<2-LeftMouse>", actions.select_entry,        { desc = "Open the diff for the selected entry." } },
      { "n", "-",             actions.toggle_stage_entry,  { desc = "Stage / unstage the selected entry." } },
      { "n", "S",             actions.stage_all,           { desc = "Stage all entries." } },
      { "n", "U",             actions.unstage_all,         { desc = "Unstage all entries." } },
      { "n", "X",             actions.restore_entry,       { desc = "Restore entry to the state on the left side." } },
      { "n", "L",             actions.open_commit_log,     { desc = "Open the commit log panel." } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),  { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),   { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,   { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,   { desc = "Open the diff for the previous file" } },
      { "n", "gf",            actions.goto_file_edit,      { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",    actions.goto_file_split,     { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",       actions.goto_file_tab,       { desc = "Open the file in a new tabpage" } },
      { "n", "i",             actions.listing_style,       { desc = "Toggle between 'list' and 'tree' views" } },
      { "n", "f",             actions.toggle_flatten_dirs, { desc = "Flatten empty subdirectories in tree listing style." } },
      { "n", "R",             actions.refresh_files,       { desc = "Update stats and entries in the file list." } },
      { "n", "<leader>e",     actions.focus_files,         { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",     actions.toggle_files,        { desc = "Toggle the file panel" } },
      { "n", "<leader>la",    actions.cycle_layout,        { desc = "Cycle available layouts" } },
      { "n", "[x",            actions.prev_conflict,       { desc = "Go to the previous conflict" } },
      { "n", "]x",            actions.next_conflict,       { desc = "Go to the next conflict" } },
      { "n", "g?",            actions.help("file_panel"),  { desc = "Open the help panel" } },
    },
    file_history_panel = {
      { "n", "g!",            actions.options,                    { desc = "Open the option panel" } },
      { "n", "<C-A-d>",       actions.open_in_diffview,           { desc = "Open the entry under the cursor in a diffview" } },
      { "n", "y",             actions.copy_hash,                  { desc = "Copy the commit hash of the entry under the cursor" } },
      { "n", "L",             actions.open_commit_log,            { desc = "Show commit details" } },
      { "n", "zR",            actions.open_all_folds,             { desc = "Expand all folds" } },
      { "n", "zM",            actions.close_all_folds,            { desc = "Collapse all folds" } },
      { "n", "j",             actions.next_entry,                 { desc = "Bring the cursor to the next file entry" } },
      { "n", "<down>",        actions.next_entry,                 { desc = "Bring the cursor to the next file entry" } },
      { "n", "k",             actions.prev_entry,                 { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<up>",          actions.prev_entry,                 { desc = "Bring the cursor to the previous file entry." } },
      { "n", "<cr>",          actions.select_entry,               { desc = "Open the diff for the selected entry." } },
      { "n", "o",             actions.select_entry,               { desc = "Open the diff for the selected entry." } },
      { "n", "<2-LeftMouse>", actions.select_entry,               { desc = "Open the diff for the selected entry." } },
      { "n", "<c-b>",         actions.scroll_view(-0.25),         { desc = "Scroll the view up" } },
      { "n", "<c-f>",         actions.scroll_view(0.25),          { desc = "Scroll the view down" } },
      { "n", "<tab>",         actions.select_next_entry,          { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>",       actions.select_prev_entry,          { desc = "Open the diff for the previous file" } },
      { "n", "gf",            actions.goto_file_edit,             { desc = "Open the file in the previous tabpage" } },
      { "n", "<C-w><C-f>",    actions.goto_file_split,            { desc = "Open the file in a new split" } },
      { "n", "<C-w>gf",       actions.goto_file_tab,              { desc = "Open the file in a new tabpage" } },
      { "n", "<leader>e",     actions.focus_files,                { desc = "Bring focus to the file panel" } },
      { "n", "<leader>b",     actions.toggle_files,               { desc = "Toggle the file panel" } },
      { "n", "<leader>la",    actions.cycle_layout,               { desc = "Cycle available layouts" } },
      { "n", "g?",            actions.help("file_history_panel"), { desc = "Open the help panel" } },
    },
    option_panel = {
      { "n", "<tab>", actions.select_entry,         { desc = "Change the current option" } },
      { "n", "q",     actions.close,                { desc = "Close the panel" } },
      { "n", "g?",    actions.help("option_panel"), { desc = "Open the help panel" } },
    },
    help_panel = {
      { "n", "q",     actions.close, { desc = "Close help menu" } },
      { "n", "<esc>", actions.close, { desc = "Close help menu" } },
    },
  },
})

vim.g.barbar_auto_setup = false -- disable auto-setup

require'barbar'.setup {
  -- WARN: do not copy everything below into your config!
  --       It is just an example of what configuration options there are.
  --       The defaults are suitable for most people.

  -- Enable/disable animations
  animation = false,

  -- Automatically hide the tabline when there are this many buffers left.
  -- Set to any value >=0 to enable.
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = {},
  exclude_name = {},

  -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
  -- Valid options are 'left' (the default), 'previous', and 'right'
  focus_on_close = 'left',

  -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
  hide = {extensions = true, inactive = true},

  -- Disable highlighting alternate buffers
  highlight_alternate = false,

  -- Disable highlighting file icons in inactive buffers
  highlight_inactive_file_icons = false,

  -- Enable highlighting visible buffers
  highlight_visible = true,

  icons = {
    -- Configure the base icons on the bufferline.
    -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
    buffer_index = true,
    buffer_number = true,
    button = '',
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
      [vim.diagnostic.severity.WARN] = {enabled = false},
      [vim.diagnostic.severity.INFO] = {enabled = false},
      [vim.diagnostic.severity.HINT] = {enabled = true},
    },
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = false,
    },
    separator = {left = '▎', right = ''},

    -- If true, add an additional separator at the end of the buffer list
    separator_at_end = true,

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = {button = '●'},
    pinned = {button = '', filename = true},

    -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
    preset = 'default',

    -- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- Sets the minimum buffer name length.
  minimum_length = 0,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- Set the filetypes which barbar will offset itself for
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {
      text = 'undotree',
      align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
    },
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = {event = 'BufWipeout'},
    -- Or, specify all three
    Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
  },

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustment
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,

  -- sorting options
  sort = {
    -- tells barbar to ignore case differences while sorting buffers
    ignore_case = true,
  },
}
