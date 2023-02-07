local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- Register a handler that will be called for all installed servers
-- Alternatively, you may also register handlers on specific server instances instead (see code below)

lsp_installer.on_server_ready(function(server) 
  local opts = {
    on_attach = require("samvdst.lsp.handlers").on_attach,
    capabilities = require("samvdst.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("samvdst.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("samvdst.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "tsserver" then
    opts = vim.tbl_deep_extend("force", {
      root_dir = require'lspconfig'.util.root_pattern("package.json")
    }, opts)
  end

  if server.name == "denols" then
    opts = vim.tbl_deep_extend("force", {
      root_dir = require'lspconfig'.util.root_pattern("deno.json", "deno.jsonc"),
    }, opts)
  end

  -- this setup function is exactly the same as lspconfig's setup function
  -- refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
