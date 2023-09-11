-- Plugin: fzf-lua
-- url: https://github.com/ibhagwan/fzf-lua
local status_ok, fzf_lua = pcall(require, "fzf-lua")
if not status_ok then
	return
end

fzf_lua.setup({
	fzf_bin = "fzf-tmux",
	fzf_opts = { ["--border"] = "rounded" },
	fzf_tmux_opts = { ["-p"] = "80%,90%" },
	winopts = {
		preview = { default = "bat", layout = "horizontal" },
	},
	keymap = {
		fzf = {
			["ctrl-z"] = "abort",
			["ctrl-f"] = "half-page-down",
			["ctrl-b"] = "half-page-up",
			["ctrl-a"] = "beginning-of-line",
			["ctrl-e"] = "end-of-line",
			["alt-a"] = "toggle-all",
			-- Only valid with fzf previewers (bat/cat/git/etc)
			["f3"] = "toggle-preview-wrap",
			["f4"] = "toggle-preview",
			["ctrl-d"] = "preview-page-down",
			["ctrl-u"] = "preview-page-up",
			["ctrl-q"] = "select-all+accept",
		},
	},
	manpages = { previewer = "man_native" },
	helptags = { previewer = "help_native" },
	tags = { previewer = "bat" },
	btags = { previewer = "bat" },
	files = { fzf_opts = { ["--ansi"] = false } },
	global_git_icons = false,
	global_file_icons = false,
})
