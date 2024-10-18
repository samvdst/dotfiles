-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Define a global variable to track the toggle state
vim.g.remove_trailing_spaces = true

-- Function to toggle the behavior
function ToggleTrailingSpaces()
  vim.g.remove_trailing_spaces = not vim.g.remove_trailing_spaces
  if vim.g.remove_trailing_spaces then
    print("Trailing spaces removal enabled")
  else
    print("Trailing spaces removal disabled")
  end
end

-- Define the autogroup and autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("samvdst_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("removeTrailingSpaces"),
  pattern = "*",
  callback = function()
    if vim.g.remove_trailing_spaces then
      vim.cmd([[silent! %s/\s\+$//e]])
    end
  end,
})

-- Create a command to toggle the behavior
vim.api.nvim_create_user_command("ToggleTrailingSpaces", ToggleTrailingSpaces, {})
