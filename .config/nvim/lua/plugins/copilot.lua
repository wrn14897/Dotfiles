vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-H>", "copilot#Previous()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
vim.g.copilot_filetypes = {
	["*"] = false,
	["c"] = true,
	["c++"] = true,
	["go"] = true,
  ["java"] = true,
	["javascript"] = true,
	["lua"] = true,
	["python"] = true,
	["rust"] = true,
	["toml"] = true,
	["typescript"] = true,
	["typescriptreact"] = true,
	["yaml"] = true,
  ["markdown"] = true,
  ["ruby"] = true,
  ["html"] = true,
  ["dockerfile"] = true,
  ["swift"] = true,
  ["sh"] = true,
  ["json"] = true
}
