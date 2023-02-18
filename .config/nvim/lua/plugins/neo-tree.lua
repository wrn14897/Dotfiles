-- Plugin: neo-tree
-- url: https://github.com/nvim-neo-tree/neo-tree.nvim

local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
	return
end

neo_tree.setup({
	close_if_last_window = false,
	enable_diagnostics = true,
	enable_git_status = true,
	popup_border_style = "rounded",
	sort_case_insensitive = false,
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = true,
	},
	window = { width = 30 },
})
