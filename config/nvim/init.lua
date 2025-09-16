-- Basic settings: tabs, line numbers, colors, etc.
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
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.clipboard = "unnamedplus"

-- Add config directory to runtimepath for colorscheme loading
vim.opt.rtp:append("~/.config/nvim")

-- Default colorscheme
vim.cmd("colorscheme binaryharbinger")

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup using lazy.nvim
require("lazy").setup({

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup{}
    end,
  },

-- Markdown
    {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
},

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "python", "lua", "javascript", "bash", "rust", "css", "yaml", "json" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent    = { enable = true },
      }
    end,
  },

  -- Completion framework
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- LSP configurations
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup{}
      lspconfig.pyright.setup{}
      lspconfig.lua_ls.setup{}
      lspconfig.ts_ls.setup{}
      lspconfig.bashls.setup{}
      lspconfig.rust_analyzer.setup{}
      lspconfig.cssls.setup{}
      lspconfig.yamlls.setup{}
      lspconfig.jsonls.setup{}
    end,
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local db = require("dashboard")
      db.setup({
        theme = "doom",
        config = {
          header = {
          "","","","","",
          "░█▀▄░▀█▀░█▀█░█▀█░█▀▄░█░█░░░█▀█░█░█░▀█▀░█▄█",
          "░█▀▄░░█░░█░█░█▀█░█▀▄░░█░░░░█░█░▀▄▀░░█░░█░█",
          "░▀▀░░▀▀▀░▀░▀░▀░▀░▀░▀░░▀░░░░▀░▀░░▀░░▀▀▀░▀░▀",
          "","","","","",
          },
          center = {
            { icon = "  ", desc = "Colorscheme", action = "Telescope colorscheme" },
            { icon = "  ", desc = "New file", action = "enew" },
            { icon = "  ", desc = "Find file", action = "Telescope find_files" },
            { icon = "  ", desc = "File browser", action = "Telescope file_browser" },
            { icon = "󰩈  ", desc = "Quit", action = "qa" },
          },
          footer = { "Binaryharbinger's Dotfiles" },
        },
        -- Center Menu in X
        hide_statusline = true,
        hide_tabline = true,
        noautocmd = true,
        center = true,
      })
  
    end,
  },

{
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons" 
  },
  config = function()
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
                }
    }
  end
},

  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("lualine").setup {
        options = {
          theme = "nord",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          icons_enabled = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  }
  

})

-- Load telescope file browser extension
require("telescope").load_extension("file_browser")

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
  })
end, { desc = "Telescope File Browser (includes hidden)" })

