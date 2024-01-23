-- Plugin: mini.nvim
-- url: https://github.com/echasnovski/mini.nvim

local mini_cursorword_status_ok, mini_cursorword = pcall(require, "mini.cursorword")
if not mini_cursorword_status_ok then
	return
end

local mini_starter_status_ok, mini_starter = pcall(require, "mini.starter")
if not mini_starter_status_ok then
	return
end

mini_cursorword.setup()
mini_starter.setup({
	content_hooks = {
		mini_starter.gen_hook.adding_bullet(""),
		mini_starter.gen_hook.aligning("center", "center"),
	},
	evaluate_single = true,
	footer = os.date(),
	header = table.concat({
		[[                                     ]],
		[[      __                _            ]],
		[[   /\ \ \___  ___/\   /(_)_ __ ___   ]],
		[[  /  \/ / _ \/ _ \ \ / | | '_ ` _ \  ]],
		[[ / /\  |  __| (_) \ V /| | | | | | | ]],
		[[ \_\ \/ \___|\___/ \_/ |_|_| |_| |_| ]],
		[[                                     ]],
	}, "\n"),
	query_updaters = [[abcdefghilmoqrstuvwxyz0123456789_-,.ABCDEFGHIJKLMOQRSTUVWXYZ]],
	items = {
		mini_starter.sections.builtin_actions(),
		mini_starter.sections.recent_files(10, false),
		mini_starter.sections.recent_files(10, true),
		{ action = "PackerSync", name = "U: Update Plugins", section = "Plugins" },
	},
})
vim.cmd([[
  augroup MiniStarterJK
    au!
    au User MiniStarterOpened nmap <buffer> j <Cmd>lua MiniStarter.update_current_item('next')<CR>
    au User MiniStarterOpened nmap <buffer> k <Cmd>lua MiniStarter.update_current_item('prev')<CR>
    au User MiniStarterOpened nmap <buffer> <C-p> <Cmd>Telescope find_files<CR>
    au User MiniStarterOpened nmap <buffer> <leader>gs <Cmd>Git<CR>
  augroup END
]])
