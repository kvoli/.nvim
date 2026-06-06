pcall(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      -- core languages
      'c', 'cpp', 'rust', 'bash', 'comment', 'lua', 'go', 'zig',
      -- markdown + parsers used as injected code-fence languages
      'markdown', 'markdown_inline',
      'python', 'javascript', 'typescript', 'tsx',
      'json', 'jsonc', 'yaml', 'toml',
      'html', 'css', 'scss',
      'sql', 'dockerfile',
      'vim', 'vimdoc', 'regex', 'diff', 'query', 'make',
    },
    highlight = { enable = true },
    indent = { enable = true },
  }
end)

pcall(function()
  require('hlargs').setup {
    color = '#fddac9',
    -- Skip large buffers; treesitter arg-highlight on every text change is
    -- the dominant typing-lag source on big files.
    disable = function(_, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
  }
end)

-- Rich markdown highlighting. VimEnter handles the initial paint (after the
-- colorscheme loads at startup); ColorScheme re-applies on any later switch.
local function set_markdown_highlights()
  local set = vim.api.nvim_set_hl
  -- Headings: bold, distinct color per level
  set(0, '@markup.heading.1.markdown', { fg = '#82AAFF', bold = true })
  set(0, '@markup.heading.2.markdown', { fg = '#89DDFF', bold = true })
  set(0, '@markup.heading.3.markdown', { fg = '#C3E88D', bold = true })
  set(0, '@markup.heading.4.markdown', { fg = '#C792EA', bold = true })
  set(0, '@markup.heading.5.markdown', { fg = '#FFCB6B', bold = true })
  set(0, '@markup.heading.6.markdown', { fg = '#80CBC4', bold = true })

  -- Lists
  set(0, '@markup.list.markdown', { fg = '#F78C6C' })
  set(0, '@markup.list.unchecked.markdown', { fg = '#F78C6C' })
  set(0, '@markup.list.checked.markdown', { fg = '#C3E88D' })

  -- Quotes
  set(0, '@markup.quote.markdown', { fg = '#676E95', italic = true })

  -- Links
  set(0, '@markup.link.label.markdown_inline', { fg = '#82AAFF' })
  set(0, '@markup.link.url.markdown_inline', { fg = '#C3E88D', underline = true })

  -- Code text colour. Inline `code` and fenced blocks with no language fall
  -- back to Comment's fg (the colour python/other comments use). For fenced
  -- blocks with a language, the injected parser's captures stack on top and
  -- override fg per-token, so this only shows through where no injection
  -- matched (i.e. unspecified-language blocks).
  local comment = vim.api.nvim_get_hl(0, { name = 'Comment', link = false })
  if comment.fg then
    local fg = string.format('#%06x', comment.fg)
    set(0, '@markup.raw.markdown_inline', { fg = fg })
    set(0, '@markup.raw.block.markdown', { fg = fg })
  end

  -- Emphasis
  set(0, '@markup.strong.markdown_inline', { bold = true })
  set(0, '@markup.italic.markdown_inline', { italic = true })
  set(0, '@markup.strikethrough.markdown_inline', { strikethrough = true })
end

vim.api.nvim_create_autocmd({ 'ColorScheme', 'VimEnter' }, {
  group = vim.api.nvim_create_augroup('markdown_rich_highlights', { clear = true }),
  callback = set_markdown_highlights,
})
