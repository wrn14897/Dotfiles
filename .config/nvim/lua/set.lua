vim.cmd(
  [[
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
  ]]
)

local set = vim.opt

if vim.fn.has("clipboard") then
  if vim.fn.has("unnamedplus") then
    set.clipboard = "unnamed,unnamedplus"
  else
    set.clipboard = "unnamed"
  end
end

--- General
vim.g.mapleader = ","
vim.o.t_SI = "<Esc>[6 q"
vim.o.t_SR = "<Esc>[4 q"
vim.o.t_EI = "<Esc>[2 q"

set.encoding = "utf-8"
set.mousehide = true
set.shortmess:append("filmnrxoOtT") --- Abbrev. of messages (avoids 'hit enter')
set.viewoptions = "folds,options,cursor,unix,slash" --- Better Unix / Windows compatibility
set.virtualedit = "onemore" --- Allow for cursor beyond last character
set.history = 1000 --- Store a ton of history (default is 20)
set.spell = true --- Spell checking on
set.hidden = true --- Allow buffer switching without saving
set.iskeyword:remove({".", "#", "-"})
set.tags = "./tags,tags;$HOME"

--- UI
vim.o.background = "dark" --- or "light" for light mode
vim.cmd([[ colorscheme gruvbox ]])
set.tabpagemax = 15 --- Only show 15 tabs
set.showmode = true --- Display the current mode
set.cursorline = true --- Highlight current line
set.backspace = "indent,eol,start" --- Backspace for dummies
set.linespace = 0 --- No extra spaces between rows
set.number = true --- Line numbers on
set.relativenumber = true --- Show relative line number
set.showmatch = true --- Show matching brackets/parenthesis
set.incsearch = true --- Find as you type search
set.hlsearch = false --- Highlight search terms
set.winminheight = 0 --- Windows can be 0 line high
set.ignorecase = true --- Case insensitive search
set.smartcase = true --- Case sensitive when uc present
set.wildmenu = true --- Show list instead of just completing
set.wildmode = "list:longest,full" --- Command <Tab> completion, list matches, then longest common part, then all.
set.whichwrap = "b,s,h,l,<,>,[,]" --- Backspace and cursor keys wrap too
set.scrolljump = 5 --- Lines to scroll when cursor leaves screen
set.scrolloff = 8 --- Minimum lines to keep above and below cursor
set.foldenable = true --- Auto fold code
set.list = true
set.listchars.extends = "tab:› ,trail:•,extends:#,nbsp:."

--- Formatting
set.wrap = false --- Do not wrap long lines
set.autoindent = true --- Indent at the same level of the previous line
set.shiftwidth = 2 --- Use indents of 4 spaces
set.expandtab = true --- Tabs are spaces, not tabs
set.tabstop = 2 --- An indentation every four columns
set.softtabstop = 2 --- Let backspace delete indent
set.joinspaces = false --- Prevents inserting two spaces after punctuation on a join (J)
set.splitright = true --- Puts new vsplit windows to the right of the current
set.splitbelow = true --- Puts new split windows to the bottom of the current
