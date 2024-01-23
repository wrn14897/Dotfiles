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
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	use({
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	use("folke/lsp-colors.nvim")

	use("ryanoasis/vim-devicons")

	use("andymass/vim-matchup")

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

	use("junegunn/gv.vim")

	use("tpope/vim-rhubarb")
	--------------------------------

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
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

	-- use({
	-- 	"ibhagwan/fzf-lua",
	-- 	-- optional for icon support
	-- 	requires = { "kyazdani42/nvim-web-devicons" },
	-- })

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

	use("lewis6991/impatient.nvim")

	use("preservim/vimux")

	use("echasnovski/mini.nvim")

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

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

	-- DAP
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
