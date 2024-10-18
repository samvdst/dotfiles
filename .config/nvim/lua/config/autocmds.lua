-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("samvdst_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "bufWritePre" }, {
  group = augroup("removeTrailingSpaces"),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
