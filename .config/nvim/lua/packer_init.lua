-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	--- Colorscheme
	use("rebelot/kanagawa.nvim")

	use({
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			{
				"j-hui/fidget.nvim",
				tag = "v1.2.0",
			},
			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	use({
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Adds LSP completion capabilities
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	})

	use({
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	use("folke/lsp-colors.nvim")

	use("nvim-tree/nvim-web-devicons")

	use("kevinhwang91/nvim-bqf")

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				indent = {
					char = "▏",
					tab_char = nil,
					highlight = "IblIndent",
					smart_indent_cap = true,
					priority = 1,
				},
				exclude = {
					filetypes = {
						"lspinfo",
						"packer",
						"checkhealth",
						"help",
						"man",
						"dashboard",
						"git",
						"markdown",
						"text",
						"terminal",
						"NvimTree",
					},
					buftypes = {
						"terminal",
						"nofile",
						"quickfix",
						"prompt",
					},
				},
			})
		end,
	})

	use({
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_patterns = { ".git" }
		end,
	})

	--------------------------------
	------ Git Related Plugins -----
	--------------------------------
	use("tpope/vim-fugitive")

	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	use("lewis6991/gitsigns.nvim")

	use("tpope/vim-rhubarb")

	use("rhysd/conflict-marker.vim")
	--------------------------------

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	use("tpope/vim-commentary")

	use("mbbill/undotree")

	use("godlygeek/tabular")

	use("wellle/targets.vim")

	use("tpope/vim-surround")

	use("tpope/vim-repeat")

	use("christoomey/vim-sort-motion")

	use("gko/vim-coloresque")

	use("michaeljsmith/vim-indent-object")

	use("kana/vim-textobj-user")

	use("preservim/vim-textobj-sentence")

	use("powerman/vim-plugin-AnsiEsc")

	use("preservim/vimux")

	use("echasnovski/mini.nvim")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({ "mhartington/formatter.nvim" })

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({ "github/copilot.vim" })

	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"topaxi/gh-actions.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function(_, opts)
			require("gh-actions").setup(opts)
		end,
	})

	use("nanotee/zoxide.vim")

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})

	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	})

	-- Discord
	use("andweeb/presence.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
