local builtin = require("telescope.builtin")
local neogit = require("neogit")

-- Global Leader
vim.g.mapleader = " "

-- ThePrimeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected lines up
vim.keymap.set("n", "n", "nzzzv") -- find next, center and unfold
vim.keymap.set("n", "N", "Nzzzv") -- find prev, center and unfold
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste over visual selection

-- Copilot (this was neccessary because cmp hijacked the tab key)
-- but my new solution is to completely disable the tab key with cmp (i use <cr> to accept)
--[[ vim.g.copilot_no_tab_map = true ]]
--[[ vim.g.copilot_assume_mapped = true ]]
--[[ vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true }) ]]
-- TELESCOPE
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })
-- close buffer
vim.keymap.set("n", "<leader>q", ":Bdelete<CR>", { noremap = true, silent = true })

-- NEOGIT
vim.keymap.set("n", "<leader>gs", neogit.open, {})
-- vim.keymap.set('n', '<leader>ga', "<cmd>!git fetch --all<CR>", {})

-- HARPOON
local silent = { silent = true }
vim.keymap.set("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, silent)
vim.keymap.set("n", "<C-e>", function()
  require("harpoon.ui").toggle_quick_menu()
end, silent)
vim.keymap.set("n", "<C-h>", function()
  require("harpoon.ui").nav_file(1)
end, silent)
vim.keymap.set("n", "<C-j>", function()
  require("harpoon.ui").nav_file(2)
end, silent)
vim.keymap.set("n", "<C-k>", function()
  require("harpoon.ui").nav_file(3)
end, silent)
vim.keymap.set("n", "<C-l>", function()
  require("harpoon.ui").nav_file(4)
end, silent)

-- CUSTOM
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--[[ vim.keymap.set('n', "<leader>e", "<cmd>:Ex") ]]
-- GIT BLAME
vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true, silent = true })

-- NVIMTREE
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- PRETTIER
vim.keymap.set("n", "<leader>p", ":PrettierAsync<CR>", { noremap = true, silent = true })
