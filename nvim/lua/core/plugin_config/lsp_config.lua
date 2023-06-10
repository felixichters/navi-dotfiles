require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"lua_ls"}
})

--require("lspconfig").hls.setup{}
require("lspconfig").clangd.setup{}
require("lspconfig").bashls.setup{}
require("lspconfig").pylsp.setup{}
require("lspconfig").lua_ls.setup{}
