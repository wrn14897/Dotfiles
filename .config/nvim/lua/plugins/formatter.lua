-- Plugin: formatter
-- url: https://github.com/mhartington/formatter.nvim

local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
	return
end

formatter.setup({
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
		java = {
			require("formatter.filetypes.java").clangformat,
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
    ruby = {
			require("formatter.filetypes.ruby").rubocop,
    },
		sql = {
			require("formatter.filetypes.sql").pgformat,
		},
		go = {
			require("formatter.filetypes.go").gofmt,
		},
	},
})
