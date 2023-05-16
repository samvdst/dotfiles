vim.cmd([[packadd packer.nvim]])
vim.cmd([[set iskeyword+=-]])

-- vim.cmd([[colorscheme tokyonight]])
vim.cmd([[colorscheme darkplus]])

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.numberwidth = 4

vim.opt.list = true
--vim.opt.listchars:append("tab:> ")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.cursorline = true
--vim.opt.cursorcolumn = true

vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.timeoutlen = 400

vim.opt.undofile = true

vim.opt.updatetime = 50
vim.opt.writebackup = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.errorbells = false
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
