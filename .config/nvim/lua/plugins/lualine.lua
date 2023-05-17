-- Plugin: lualine
-- url: https://github.com/nvim-lualine/lualine.nvim
local theme = require("kanagawa.colors").setup().theme

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = theme.ui.bg,
  fg       = theme.ui.fg,
  yellow   = theme.syn.identifier,
  cyan     = theme.diag.hint,
  darkblue = theme.diag.info,
  green    = theme.diag.ok,
  orange   = theme.syn.constant,
  violet   = theme.ui.special,
  magenta  = theme.syn.keyword,
  blue     = theme.syn.fun,
  red      = theme.diag.error,
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		theme = "kanagawa",
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
	tabline = {},
	extensions = { "fugitive", "neo-tree", "quickfix" },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	-- mode component
	function()
		return "π"
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
})

ins_left({
	"branch",
	icon = "",
	color = { fg = colors.blue, gui = "bold" },
})

ins_left({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳 ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.yellow, gui = "bold" },
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

ins_left({
	"buffers",
	show_filename_only = true, -- Shows shortened relative path when set to false.
  hide_filename_extension = true,   -- Hide filename extension when set to true.
	show_modified_status = true, -- Shows indicator when the buffer is modified.
	mode = 0, -- 0: Shows buffer name
            -- 1: Shows buffer index
            -- 2: Shows buffer name + buffer index
            -- 3: Shows buffer number
            -- 4: Shows buffer name + buffer number
	-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
	use_mode_colors = true,
	symbols = {
		modified = " ●", -- Text to show when the buffer is modified
		alternate_file = "#", -- Text to show to identify the alternate file
		directory = "", -- Text to show when the buffer is a directory
	},
})

ins_right({
	"filetype",
	colored = true,
	icon_only = false,
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	"progress",
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	"location",
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 1 },
})

lualine.setup(config)
