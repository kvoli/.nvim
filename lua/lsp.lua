local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_lsp_ok then return end

local vt_ok, virtualtypes = pcall(require, "virtualtypes")

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
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
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, focusable = false })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border, focusable = false })

  if vt_ok then virtualtypes.on_attach() end

  local sig_ok, lsp_signature = pcall(require, "lsp_signature")
  if sig_ok then
    lsp_signature.on_attach({
      bind = true,
      floating_window = true,
      floating_window_above_cur_line = true,
      fix_pos = false,
      hint_enable = false,
      hint_prefix = " ",
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
end

local lsp_opts = {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 }
}

pcall(function() require("mason").setup() end)
pcall(function() require("mason-lspconfig").setup() end)

local servers = {
  'gopls', 'dockerls', 'bashls', 'html', 'lua_ls',
  'marksman', 'jedi_language_server', 'sqlls', 'taplo', 'yamlls',
}

for _, server in ipairs(servers) do
  pcall(function()
    vim.lsp.config(server, lsp_opts)
    vim.lsp.enable(server)
  end)
end

local null_ls_ok, null_ls = pcall(require, "null-ls")
if null_ls_ok then
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.proselint,
      null_ls.builtins.code_actions.proselint,
      null_ls.builtins.hover.printenv,
    },
  })
end
