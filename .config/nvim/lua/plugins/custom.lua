return {
  -- disable the search treesitter command
  {
    "folke/flash.nvim",
    enabled = false,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },

  -- wakatime plugin
  {
    "wakatime/vim-wakatime",
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          prev = "<M-[>",
          next = "<M-]>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        auto_refresh = false,
        keymap = {
          accept = "<CR>",
          jump_prev = "[[",
          jump_next = "]]",
          refresh = "gr",
          open = "<M-CR>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- copilot cmp source
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    -- NOTE: I don't want copilot in my completions. I want ghost text for copilot and completions for intellisense
    -- it appears that if we leave the above and uncomment the below, it works as expected. I'm not sure why we need the above tho.
    --
    -- ---@param opts cmp.ConfigSchema
    -- opts = function(_, opts)
    --   table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
    --   opts.sorting = opts.sorting or require("cmp.config.default")().sorting
    --   table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)
    -- end,
  },
}
