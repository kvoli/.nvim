local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then return end

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
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
        end)
      end
    end
  }):sync()
end

local actions = require('telescope.actions')
telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
    vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
    results_title = false,
    preview_title = false,
    prompt_prefix = "❱ ",
    selection_caret = "❱ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = { width = 0.8, height = 0.6, prompt_position = "bottom" },
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    winblend = 10,
    previewer = true,
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

pcall(function() telescope.load_extension('neoclip') end)
pcall(function() telescope.load_extension('fzf') end)
pcall(function() telescope.load_extension('gh') end)
pcall(function() telescope.load_extension('harpoon') end)
pcall(function() telescope.load_extension('aerial') end)
