local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- helpers
  use("nvim-lua/plenary.nvim")

  -- theme
  use("morhetz/gruvbox")
  use("folke/tokyonight.nvim")
  use("lunarvim/darkplus.nvim")

  -- syntax highlighting
  use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
  })
  use("p00f/nvim-ts-rainbow") -- bracket colorizer

  -- file navigation and fuzzyfind
  use("junegunn/fzf")
  use("junegunn/fzf.vim")
  use {
   'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use("ThePrimeagen/harpoon")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- the completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("hrsh7th/cmp-nvim-lsp") -- lsp completions
  use("saadparwaiz1/cmp_luasnip") -- luasnip completions
  use("hrsh7th/cmp-nvim-lua") -- lua completions

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippets

  -- lsp
  --use("williamboman/mason.nvim") -- todo: if i have time change back to mason
  -- use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/null-ls.nvim")

  -- comments
  -- use("tpope/vim-commentary") -- the new ones work better for jsx
  use("numToStr/Comment.nvim") -- easily comment stuff
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- git
  use("github/copilot.vim")
  use("lewis6991/gitsigns.nvim") -- see git changes 
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

  -- explorer
  use("kyazdani42/nvim-web-devicons") -- icons
  use("kyazdani42/nvim-tree.lua") -- file explorer
  -- bufferline
  use("akinsho/nvim-bufferline.lua") -- tabs like vscode
  use("moll/vim-bbye") -- close buffers

  -- misc tools
  use("nvim-lualine/lualine.nvim")
  use("norcalli/nvim-colorizer.lua")
  use("windwp/nvim-autopairs")

  -- wakatime
  use("wakatime/vim-wakatime")
end)
