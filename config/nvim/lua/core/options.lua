-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.clipboard = "unnamedplus"

-- Add config directory to runtimepath for colorscheme loading
vim.opt.rtp:append("~/.config/nvim")

-- Default colorscheme
vim.cmd("colorscheme binaryharbinger")
