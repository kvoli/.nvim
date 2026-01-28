local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then return end

local types = require('cmp.types')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then luasnip = nil end

cmp.setup {
  snippet = {
    expand = function(args)
      if luasnip then luasnip.lsp_expand(args.body) end
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
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
      elseif luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
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
      elseif luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  completion = {
    autocomplete = { types.cmp.TriggerEvent.TextChanged },
    completeopt = 'menu,menuone,noselect',
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'tmux', option = { all_panes = false, label = '[tmux]' } },
    { name = 'buffer' },
    { name = 'path' },
  },
}

local npairs_ok, npairs = pcall(require, 'nvim-autopairs')
if npairs_ok then
  npairs.setup({})
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
  npairs.enable()

  local Rule = require('nvim-autopairs.rule')
  local cond = require('nvim-autopairs.conds')
  npairs.add_rule(Rule("$$", "$$", "tex"))
  npairs.add_rules({
    Rule("$", "$", { "tex", "latex" })
      :with_pair(cond.not_after_regex_check("%%"))
      :with_pair(cond.not_before_regex_check("xxx", 3))
      :with_move(cond.none())
      :with_del(cond.not_after_regex_check("xx"))
      :with_cr(cond.none())
  })
end
