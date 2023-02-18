require("fzf-lua").setup({
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
