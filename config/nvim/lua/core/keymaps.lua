-- Key mappings

-- Terminal mode escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

-- Telescope commands
vim.api.nvim_create_user_command("FindFile", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = true,
    file_ignore_patterns = { ".git/" },
  })
end, { desc = "Find Files (includes hidden)" })

vim.api.nvim_create_user_command("LiveGrep", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden", "--no-ignore" }
    end,
  })
end, { desc = "Live Grep (includes hidden)" })

vim.api.nvim_create_user_command("Browse", function()
  require("telescope").extensions.file_browser.file_browser({
    hidden = true,
    respect_gitignore = false,
    follow_symlinks = true,
    hide_parent_dir = false,
  })
end, { desc = "Telescope File Browser (includes hidden and symlinks)" })
