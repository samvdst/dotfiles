local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local lspconfig_ok, _ = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  --[[ vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async: true })' ]]
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

mason.setup({})
mason_lspconfig.setup({})
mason_lspconfig.setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = require("samvdst.lsp.handlers").on_attach,
      capabilities = require("samvdst.lsp.handlers").capabilities,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  --[[ ["rust_analyzer"] = function () ]]
  --[[     require("rust-tools").setup {} ]]
  --[[ end, ]]
  ["lua_ls"] = function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = require("samvdst.lsp.handlers").on_attach,
      capabilities = require("samvdst.lsp.handlers").capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
})

-- old
-- Register a handler that will be called for all installed servers
-- Alternatively, you may also register handlers on specific server instances instead (see code below)

--[[ lsp_installer.on_server_ready(function(server)  ]]
--[[   local opts = { ]]
--[[     on_attach = require("samvdst.lsp.handlers").on_attach, ]]
--[[     capabilities = require("samvdst.lsp.handlers").capabilities, ]]
--[[   } ]]
--[[]]
--[[   if server.name == "jsonls" then ]]
--[[     local jsonls_opts = require("samvdst.lsp.settings.jsonls") ]]
--[[     opts = vim.tbl_deep_extend("force", jsonls_opts, opts) ]]
--[[   end ]]
--[[]]
--[[   if server.name == "sumneko_lua" then ]]
--[[     local sumneko_opts = require("samvdst.lsp.settings.sumneko_lua") ]]
--[[     opts = vim.tbl_deep_extend("force", sumneko_opts, opts) ]]
--[[   end ]]
--[[]]
--[[   if server.name == "tsserver" then ]]
--[[     opts = vim.tbl_deep_extend("force", { ]]
--[[       root_dir = require'lspconfig'.util.root_pattern("package.json") ]]
--[[     }, opts) ]]
--[[   end ]]
--[[]]
--[[   if server.name == "denols" then ]]
--[[     opts = vim.tbl_deep_extend("force", { ]]
--[[       root_dir = require'lspconfig'.util.root_pattern("deno.json", "deno.jsonc"), ]]
--[[     }, opts) ]]
--[[   end ]]
--[[]]
--[[   if server.name == "eslint" then ]]
--[[     opts = vim.tbl_deep_extend("force", { ]]
--[[       root_dir = require'lspconfig'.util.root_pattern("package.json", ".eslintrc.js", ".eslintrc.json", ".eslintrc", ".git"), ]]
--[[     }, opts) ]]
--[[   end ]]
--[[]]
--[[   -- this setup function is exactly the same as lspconfig's setup function ]]
--[[   -- refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md ]]
--[[   server:setup(opts) ]]
--[[ end) ]]
