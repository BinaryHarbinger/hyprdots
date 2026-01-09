return {
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
            "██████╗ ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
            "██╔══██╗██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝   ████╗  ██║██║   ██║██║████╗ ████║",
            "██████╔╝██║██╔██╗ ██║███████║██████╔╝ ╚████╔╝    ██╔██╗ ██║██║   ██║██║██╔████╔██║",
            "██╔══██╗██║██║╚██╗██║██╔══██║██╔══██╗  ╚██╔╝     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██████╔╝██║██║ ╚████║██║  ██║██║  ██║   ██║      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "","","","","",
          },
          center = {
            { icon = "  ", desc = "Colorscheme", action = "Telescope colorscheme" },
            { icon = "  ", desc = "New file", action = "enew" },
            { icon = "  ", desc = "Find file", action = "Telescope find_files" },
            { icon = "  ", desc = "File browser", action = "Telescope file_browser" },
            { icon = "󰩈  ", desc = "Quit", action = "qa" },
          },
          footer = { "Binaryharbinger's Dotfiles" },
        },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
          theme = "material",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
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
  },
}
