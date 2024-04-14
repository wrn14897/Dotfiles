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
-- undotree
utils.nmap("<leader>u", ":UndotreeToggle<CR>")

-- Telescope
utils.nmap("<c-f>", ":Telescope live_grep<CR>")
utils.nmap("<c-p>", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>")
utils.nmap("<Leader>ft", ":Telescope treesitter<CR>")
utils.nmap("<Leader>fb", ":Telescope buffers<CR>")
utils.nmap("<Leader>fd", ":Telescope diagnostics<CR>")
utils.nmap("<Leader>fh", ":Telescope help_tags<CR>")
utils.nmap("<Leader>fm", ":Telescope marks<CR>")
utils.nmap("<Leader>fr", ":Telescope registers<CR>")
utils.nmap("<Leader>fw", ":Telescope grep_string<CR>")
utils.nmap("<Leader>fgb", ":Telescope git_bcommits<CR>")

-- Trouble
utils.nmap("<leader>xx", ":TroubleToggle<CR>")

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

utils.nmap("<Leader>gha", ":GhActions<CR>")

-- Vimux
utils.nmap("<Leader>vp", ":VimuxPromptCommand<CR>")
utils.nmap("<Leader>vs", ":VimuxInterruptRunner<CR>")
utils.nmap("<Leader>vl", ":VimuxRunLastCommand<CR>")

-- ChatGPT
utils.nmap("<Leader>ch", ":ChatGPT<CR>")
utils.vmap("che", ":ChatGPTEditWithInstructions<CR>")
utils.vmap("chrat", ":ChatGPTRun add_tests<CR>")
utils.vmap("chrfb", ":ChatGPTRun fix_bugs<CR>")
utils.vmap("chro", ":ChatGPTRun optimize_code<CR>")
