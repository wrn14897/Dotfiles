local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
  {
	  "rebelot/kanagawa.nvim",
    lazy = false,
  },

  {
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
    dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{
				"j-hui/fidget.nvim",
				tag = "v1.2.0",
			},

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
     { 'folke/neodev.nvim', opts = {} },
    }
  },

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Adds LSP completion capabilities
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
      "nvim-treesitter/nvim-treesitter",
    }
	},

	"folke/lsp-colors.nvim",

  {
	  "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

	"kevinhwang91/nvim-bqf",

	{
		"lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup()
    end,
	},

  {
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_patterns = { ".git" }
		end,
	},

	--------------------------------
	------ Git Related Plugins -----
	--------------------------------
	"tpope/vim-fugitive",

	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

	"lewis6991/gitsigns.nvim",

	"tpope/vim-rhubarb",

	"rhysd/conflict-marker.vim",
	--------------------------------
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.5",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},

	"tpope/vim-commentary",

	"mbbill/undotree",

	"godlygeek/tabular",

	"wellle/targets.vim",

	"tpope/vim-surround",

	"tpope/vim-repeat",

	"christoomey/vim-sort-motion",

	"gko/vim-coloresque",

	"michaeljsmith/vim-indent-object",

	"kana/vim-textobj-user",

	"preservim/vim-textobj-sentence",

	"powerman/vim-plugin-AnsiEsc",

	"preservim/vimux",

	"echasnovski/mini.nvim",

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
	},

	{ "mhartington/formatter.nvim" },

	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	"github/copilot.vim",

	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

  {
		"topaxi/gh-actions.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function(_, opts)
			require("gh-actions").setup(opts)
		end,
	},

	"nanotee/zoxide.vim",

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},

	-- Discord
	"andweeb/presence.nvim",

	-- DAP
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
})
