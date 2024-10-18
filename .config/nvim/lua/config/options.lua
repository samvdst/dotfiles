-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.conceallevel = 0
vim.opt.textwidth = 100
vim.opt.colorcolumn = "101"

vim.cmd([[
augroup CustomColorColumn
  autocmd!
  autocmd ColorScheme * highlight ColorColumn ctermbg=0 guibg=#292e42
augroup END
]])
