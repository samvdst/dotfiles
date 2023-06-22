local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

null_ls.setup({
  debug = false,
  sources = {
    null_ls.builtins.formatting.prettier,
    --[[ null_ls.builtins.diagnostics.eslint_d, ]]
    --[[ formatting.black.with({ extra_args = { "--fast" } }), ]]
    --[[ null_ls.builtins.formatting.stylua, ]]
    --[[ null_ls.builtins.diagnostics.flake8, ]]
  },
  on_attach = require("samvdst.lsp.handlers").on_attach,
})
