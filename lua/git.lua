local neogit_ok, neogit = pcall(require, "neogit")
if neogit_ok then
  neogit.setup {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    kind = "tab",
    console_timeout = 2000,
    auto_show_console = true,
    commit_popup = { kind = "split" },
    popup = { kind = "split" },
    signs = { section = { ">", "v" }, item = { ">", "v" }, hunk = { "", "" } },
    integrations = { diffview = true },
    sections = {
      untracked = { folded = false, hidden = false },
      unstaged = { folded = false, hidden = false },
      staged = { folded = false, hidden = false },
      stashes = { folded = true, hidden = false },
      unpulled = { folded = true, hidden = false },
      unmerged = { folded = false, hidden = false },
      recent = { folded = true, hidden = false },
    },
  }
end

local gitlinker_ok, gitlinker = pcall(require, "gitlinker")
if gitlinker_ok then
  gitlinker.setup({
    opts = {
      remote = "source",
      add_current_line_on_normal_mode = true,
      action_callback = require("gitlinker.actions").copy_to_clipboard,
      print_url = true,
    },
    mappings = "<leader>gy"
  })
end

local diffview_ok, diffview = pcall(require, "diffview")
if diffview_ok then
  diffview.setup({
    diff_binaries = false,
    enhanced_diff_hl = false,
    git_cmd = { "git" },
    use_icons = true,
    show_help_hints = true,
    watch_index = true,
    icons = { folder_closed = "", folder_open = "" },
    signs = { fold_closed = "", fold_open = "", done = "✓" },
  })
end
