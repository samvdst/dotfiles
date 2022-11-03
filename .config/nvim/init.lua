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
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40
    })
  end,
})

require("colorizer").setup()
