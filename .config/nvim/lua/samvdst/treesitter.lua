local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

vim.api.nvim_create_augroup("rainbow", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "Filetype" }, {
  group = "rainbow",
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "rainbowcol1", {
      fg = "#ffd700",
    })
  end,
})
