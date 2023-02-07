local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("samvdst.lsp.lsp-installer")
require("samvdst.lsp.handlers").setup()
require("samvdst.lsp.null-ls")
