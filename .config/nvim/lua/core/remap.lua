local utils = require("core/utils")

utils.nmap("<C-d>", "<C-d>zz")
utils.nmap("<C-u>", "<C-u>zz")
utils.nmap("n", "nzzzv")
utils.nmap("N", "Nzzzv")
utils.nmap("j", "gj")
utils.nmap("k", "gk")
utils.imap("jk", "<esc>")
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

--- Buffers
utils.nmap("H", ":bprevious<CR>")
utils.nmap("L", ":bnext<CR>")
utils.nmap("<leader>bd", ":bd<CR>")

--- Easier horizontal scrolling
utils.nmap("zl", "zL")
utils.nmap("zh", "zH")

--- Edit/Source vimrc file
utils.nmap("<leader>ev", ":vsplit $MYVIMRC<CR>")
utils.nmap("<leader>sv", ":source $MYVIMRC<CR>")

--- Macro
utils.xmap(".", ":normal .<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Neo-Tree
utils.nmap("<C-e>", ":NeoTreeFocusToggle<CR>")

-- undotree
utils.nmap("<leader>u", ":UndotreeToggle<CR>")

-- Formatter
utils.nmap("<Leader>ff", ":Format<CR>")

-- Fzf
utils.nmap("<c-f>", ":FzfLua grep_project<CR>")
utils.nmap("<c-p>", ":FzfLua files<CR>")
utils.nmap("<Leader>f/", ":FzfLua lines<CR>")
utils.nmap("<Leader>fb", ":FzfLua buffers<CR>")
utils.nmap("<Leader>fd", ":FzfLua diagnostics_workspace<CR>")
utils.nmap("<Leader>fh", ":FzfLua help_tags<CR>")
utils.nmap("<Leader>fm", ":FzfLua marks<CR>")
utils.nmap("<Leader>fr", ":FzfLua registers<CR>")
utils.nmap("<Leader>ft", ":FzfLua tabs<CR>")
utils.nmap("<Leader>fw", ":FzfLua grep_cword<CR>")
utils.nmap("<Leader>gbl", ":FzfLua git_bcommits<CR>")

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
utils.nmap("<Leader>gl", ":DiffviewFileHistory<CR>")
-- Open visual selection in the browser
utils.vmap("br", ":GBrowse<CR>")
utils.vmap("b", ":GV<CR>")

-- Vimux
utils.nmap("<Leader>vp", ":VimuxPromptCommand<CR>")
utils.nmap("<Leader>vs", ":VimuxInterruptRunner<CR>")
utils.nmap("<Leader>vl", ":VimuxRunLastCommand<CR>")
