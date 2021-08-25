lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  highlight = {
    indent = {
      enable = true
    },
    enable = true,
    -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF

"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()
