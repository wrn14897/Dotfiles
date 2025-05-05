local utils = require("core/utils")

utils.nmap("<C-d>", "<C-d>zz")
utils.nmap("<C-u>", "<C-u>zz")
utils.nmap("n", "nzzzv")
utils.nmap("N", "Nzzzv")
utils.nmap("j", "gj")
utils.nmap("k", "gk")
utils.imap("jk", "<esc>")
utils.imap("kj", "<esc>")
utils.imap("<esc>", "<nop>")
utils.imap("<C-c>", "<Esc>")

--- Yank from the cursor to the end of the line, to be consistent with C and D.
utils.nmap("Y", "y$")

--- Preserve copied word
utils.xmap("<leader>p", [["_dP]])

--- Find merge conflict markers
utils.nmap("<leader>fc", "/\v^[<|=>]{7}( .*|$)<CR>")

--- For when you forget to sudo.. Really Write the file.
utils.cmap("w!!", "w !sudo tee % >/dev/null")

--- Buffers / Tabs
utils.nmap("H", ":bprevious<CR>")
utils.nmap("L", ":bnext<CR>")
utils.nmap("<leader>q", ":bd<CR>")
utils.nmap("<leader>w", ":tabclose<CR>")

--- QuickFix
utils.nmap("<c-q>j", ":cnext<CR>")
utils.nmap("<c-q>k", ":cprev<CR>")

--- Easier horizontal scrolling
utils.nmap("zl", "zL")
utils.nmap("zh", "zH")

--- Edit/Source vimrc file
utils.nmap("<leader>ev", ":vsplit $MYVIMRC<CR>")
utils.nmap("<leader>sv", ":source $MYVIMRC<CR>")

--- Diagnostics
utils.nmap("<leader>dl", ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>')

--- Macro
utils.xmap(".", ":normal .<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------
-- undotree
utils.nmap("<leader>u", ":UndotreeToggle<CR>")

-- fzf-lua
utils.nmap("<c-f>", ":FzfLua live_grep<CR>")
utils.nmap("<c-p>", ":FzfLua files<CR>")
utils.nmap("<c-e>", ":FzfLua buffers<CR>")
utils.nmap("<Leader>ft", ":FzfLua treesitter<CR>")
utils.nmap("<Leader>fd", ":FzfLua diagnostics_workspace<CR>")
utils.nmap("<Leader>fh", ":FzfLua helptags<CR>")
utils.nmap("<Leader>fm", ":FzfLua marks<CR>")
utils.nmap("<Leader>fr", ":FzfLua registers<CR>")
utils.nmap("<Leader>fw", ":FzfLua grep_cword<CR>")
utils.nmap("<Leader>fgb", ":FzfLua git_bcommits<CR>")
utils.nmap("<Leader>fg", ":FzfLua git_commits<CR>")

-- Oil
utils.nmap("-", ":Oil<CR>")

-- Git Stuff
utils.nmap("<leader>gs", ":Git<CR>")
utils.nmap("<leader>gd", ":Gvdiffsplit<CR>")
utils.nmap("<leader>gc", ":Git commit<CR>")
utils.nmap("<leader>gb", ":Git blame<CR>")
-- nnoremap <silent> <leader>gl :Gclog<CR>
-- nnoremap <silent> <leader>gp :Git push<CR>
utils.nmap("<leader>gp", ":Git -c push.default=current push<CR>")
utils.nmap("<leader>gr", ":Gread<CR>")
utils.nmap("<leader>gw", ":Gwrite<CR>")
utils.nmap("<leader>ge", ":Gedit<CR>")
utils.nmap("<leader>gi", ":Git add -p %<CR>")
utils.nmap("<Leader>gl", ":DiffviewFileHistory %<CR>")
-- Open visual selection in the browser
utils.vmap("br", ":GBrowse<CR>")
utils.vmap("<Leader>gl", ":DiffviewFileHistory<CR>")

-- codecompanion
utils.nmap("<C-a>", ":CodeCompanionAction<CR>")
utils.vmap("<C-a>", ":CodeCompanionAction<CR>")
utils.vmap("ga", ":CodeCompanionChat Add<CR>")

-- Vimux
utils.nmap("<Leader>vl", ":VimuxRunLastCommand<CR>")
utils.nmap("<Leader>vp", ":VimuxPromptCommand<CR>")
utils.nmap("<Leader>vs", ":VimuxInterruptRunner<CR>")

-- Zen Mode
utils.nmap("<Leader>zm", ":ZenMode<CR>")
