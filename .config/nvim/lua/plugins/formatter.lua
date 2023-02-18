require("formatter").setup({
	logging = true,
	filetype = {
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
		},
		typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettierd,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettierd,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettierd,
		},
		html = {
			require("formatter.filetypes.html").tidy,
		},
		json = {
			require("formatter.filetypes.json").jq,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		yaml = {
			require("formatter.filetypes.yaml").yamlfmt,
		},
		python = {
			require("formatter.filetypes.python").black,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
	},
})
