return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "python", "lua", "javascript", "bash", "rust", "css", "yaml", "json" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      }
    end,
  },
}
