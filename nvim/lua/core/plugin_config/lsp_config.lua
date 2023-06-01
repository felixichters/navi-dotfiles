require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"lua_ls"}
})

require("lspconfig").pylsp.setup{}
require("lspconfig").lua_ls.setup{}
