-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
	return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
	return
end

local status_ok, telescope = pcall(require, "telescope.builtin")
if not status_ok then
	return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

local fidget_status_ok, fidget = pcall(require, "fidget")
if not fidget_status_ok then
	return
end

local on_attach = function(_, bufnr)
	local nmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, silent = true })
	end

	nmap("<leader>rn", vim.lsp.buf.rename)
	nmap("<leader>ca", vim.lsp.buf.code_action)

	nmap("<leader>D", vim.lsp.buf.type_definition)
	nmap("<leader>ds", telescope.lsp_document_symbols)
	nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols)
	nmap("gI", vim.lsp.buf.implementation)
	nmap("gd", vim.lsp.buf.definition)
	nmap("gr", telescope.lsp_references)

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover)
end

-- Enable the following language servers
local servers = {
	clangd = {},
	rust_analyzer = {},
	pyright = {},
	tsserver = {},
	eslint = {},
	dockerls = {},
	diagnosticls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
mason.setup()

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- Turn on lsp status information
fidget.setup()

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
