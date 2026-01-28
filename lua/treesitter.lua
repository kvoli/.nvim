pcall(function()
  require('nvim-treesitter').install {
    ensure_installed = { "c", "cpp", "rust", "bash", "comment", "lua", "go", "zig" },
  }
end)

pcall(function()
  require('hlargs').setup { color = '#fddac9' }
end)
