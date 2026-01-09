return {
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
}
