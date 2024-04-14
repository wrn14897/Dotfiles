-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local nmap = function(keys, func)
			vim.keymap.set("n", keys, func, { buffer = event.buf })
		end

		nmap("<leader>rn", vim.lsp.buf.rename)
		nmap("<leader>ca", vim.lsp.buf.code_action)

		nmap("<leader>D", require("telescope.builtin").lsp_type_definitions)
		nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols)
		nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
		nmap("gI", require("telescope.builtin").lsp_implementations)

		nmap("gd", require("telescope.builtin").lsp_definitions)
		nmap("gr", require("telescope.builtin").lsp_references)

		-- See `:help K` for why this keymap
		nmap("K", vim.lsp.buf.hover)

		nmap("gD", vim.lsp.buf.declaration)

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

-- Enable the following language servers
local servers = {
	clangd = {},
	rust_analyzer = {},
	gopls = {},
	pyright = {},
	tsserver = {},
	eslint = {},
	dockerls = {},
	elixirls = {},
	rubocop = {},
	yamlls = {},
	diagnosticls = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				-- diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
cclangformatapabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Setup mason so it can manage external tooling
require("mason").setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	--- Linters
	"eslint_d", -- Used to lint JavaScript codes
	"markdownlint",
	"flake8",
	"luacheck",
	"tflint",
	--- Formatters
	"stylua", -- Used to format Lua code
	"black", -- Used to format Python code
	"prettierd", -- Used to format JavaScript code
	"jq",
	"clang-format",
	"yamlfmt",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			-- This handles overriding only values explicitly passed
			-- by the server configuration above. Useful when disabling
			-- certain features of an LSP (for example, turning off formatting for tsserver)
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

-- Turn on lsp status information
require("fidget").setup()

-- Diagnostics
-- Floating message
vim.diagnostic.config({
	float = { source = "always", border = border },
	virtual_text = false,
	signs = true,
})
-- Diagnostic keymaps
vim.keymap.set("n", "<C-k>", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true })
