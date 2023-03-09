-- disable netrw at the very start of your init.lua (strongly advised by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("samvdst.packer")
require("samvdst.options")
require("samvdst.keymap")
require("samvdst.cmp")
require("samvdst.treesitter")
require("samvdst.lualine")
require("samvdst.lsp")
require("samvdst.telescope")
require("samvdst.autopairs")
require("samvdst.comment")
require("samvdst.gitsigns")
require("samvdst.nvim-tree")
require("samvdst.bufferline")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- highlight line on yank
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- open nvim-tree on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- setup colorizer
require("colorizer").setup()

-- disable gitblame on startup
vim.g.gitblame_enabled = 0
vim.g.gitblame_date_format = "%r (%Y-%m-%d)"
vim.g.gitblame_message_template = '<author>, <date> • <summary>'
