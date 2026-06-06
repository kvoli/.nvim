local fterm_ok, fterm = pcall(require, 'FTerm')
if fterm_ok then
  fterm.setup({
    ft = 'FTerm',
    cmd = os.getenv('SHELL'),
    border = { { '╔', "MoreMsg" }, { '═', "MoreMsg" }, { '╗', "MoreMsg" }, { '║', "MoreMsg" }, { '╝', "MoreMsg" }, { '═', "MoreMsg" }, { '╚', "MoreMsg" }, { '║', "MoreMsg" } },
    auto_close = true,
    hl = 'Normal',
    blend = 20,
    dimensions = { height = 0.85, width = 0.85, x = 0.5, y = 0.5 },
  })
  vim.api.nvim_set_keymap('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
end

pcall(function() require('neoclip').setup() end)
pcall(function() require('colorizer').setup() end)
pcall(function() require('Comment').setup() end)
pcall(function() require('nvim-web-devicons').setup() end)

local neogen_ok, neogen = pcall(require, 'neogen')
if neogen_ok then
  neogen.setup { enabled = true }
  vim.api.nvim_set_keymap("n", "<Leader>af", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>ac", ":lua require('neogen').generate({ type = 'class' })<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>at", ":lua require('neogen').generate({ type = 'type' })<CR>", { noremap = true, silent = true })
end

pcall(function() require('hop').setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 } end)

local aerial_ok, aerial = pcall(require, 'aerial')
if aerial_ok then
  aerial.setup({
    on_attach = function(bufnr)
      vim.keymap.set('n', '[', '<cmd>AerialPrev<CR>', { buffer = bufnr })
      vim.keymap.set('n', ']', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end
  })
  vim.keymap.set('n', '<leader>A', '<cmd>AerialToggle!<CR>')
end

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local ufo_ok, ufo = pcall(require, 'ufo')
if ufo_ok then
  vim.keymap.set('n', 'zR', ufo.openAllFolds)
  vim.keymap.set('n', 'zM', ufo.closeAllFolds)
  vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
  vim.keymap.set('n', 'zm', ufo.closeFoldsWith)

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

  ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
    fold_virt_text_handler = handler
  })
end
