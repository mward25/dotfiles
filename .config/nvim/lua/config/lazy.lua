-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { "idr4n/github-monochrome.nvim",    name = "github-monocrome",priority = 1000 },
    { "tpope/vim-sleuth",                name = "vim-sleuth",      priority = 1000 },
    { "nvim-tree/nvim-tree.lua",         name = "nvim-tree",       priority = 1000 },
    { "nvim-telescope/telescope.nvim",   name = "telescope",       priority = 1000, tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Config Defaults helpers
    { "neovim/nvim-lspconfig", name = "nvim-lspconfig", priority = 1000 },
    -- Completion Helpers
    { "hrsh7th/nvim-cmp", name = "nvim-cmp", priority = 1000,
      dependencies = { "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "hrsh7th/cmp-vsnip",
         "hrsh7th/vim-vsnip"
       }
    },
    -- Tpope!!!
    { "tpope/vim-fugitive", name="vim-fugitive", priority = 1000 },
    { "tpope/vim-commentary", name="vim-commentary", priority = 1000 },
    { "tpope/vim-surround", name="vim-surround", priority = 1000 },

    -- For non-default supported file formats
    { "luisjure/csound-vim", name="csound-vim", priority=1000 },
    
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
