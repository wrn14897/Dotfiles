local telescope = require 'telescope'
local telescope_builtin = require 'telescope.builtin'
local telescope_actions = require 'telescope.actions'

local trouble = require("trouble.providers.telescope")

telescope.setup({
	defaults = {
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
		layout_config = {
			height = 0.9, -- maximally available lines
			width = 0.9, -- maximally available columns
			prompt_position = "top",
		},
    mappings = {
      -- swap default <C-q> and <M-q> mappings
      i = {
        ["<C-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
        ["<M-q>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
        ["<C-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-q>"] = telescope_actions.send_selected_to_qflist + telescope_actions.open_qflist,
        ["<M-q>"] = telescope_actions.send_to_qflist + telescope_actions.open_qflist,
        ["<C-t>"] = trouble.open_with_trouble,
      },
    }
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
