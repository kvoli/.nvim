local dap_ok, dap = pcall(require, 'dap')
if not dap_ok then return end

local dap_go_ok, dap_go = pcall(require, 'dap-go')
if dap_go_ok then
  dap_go.setup({ external_config = { enabled = true } })
end

local vt_ok, vt = pcall(require, "nvim-dap-virtual-text")
if vt_ok then
  vt.setup {
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
    commented = true,
  }
end

vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = '', linehl = '', numhl = '' })

local dapui_ok, dapui = pcall(require, "dapui")
if dapui_ok then
  dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
      {
        elements = { { id = "scopes", size = 0.25 }, "breakpoints", "stacks", "watches" },
        size = 40,
        position = "left",
      },
      {
        elements = { "repl", "console" },
        size = 0.25,
        position = "bottom",
      },
    },
    floating = { border = "single", mappings = { close = { "q", "<Esc>" } } },
    windows = { indent = 1 },
  })

  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end
