-- Plugin: fzf-lua
-- url: https://github.com/ibhagwan/fzf-lua

local status_ok, fzf_lua = pcall(require, "fzf-lua")
if not status_ok then
	return
end

fzf_lua.setup({
	winopts = {
		height = 0.9,
		width = 0.9,
	},
	previewers = {
		git_diff = {
			pager = "delta --width=$FZF_PREVIEW_COLUMNS",
		},
	},
	keymap = {
		fzf = {
			["ctrl-z"] = "abort",
			["ctrl-k"] = "unix-line-discard",
			["ctrl-d"] = "preview-page-down",
			["ctrl-u"] = "preview-page-up",
		},
	},
	git = {
		commits = {
			preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
		},
		bcommits = {
			preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
		},
	},
})
