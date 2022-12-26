local utils = require("utils")

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

--- Tabs
utils.nmap("H", "gT")
utils.nmap("L", "gt")
utils.nmap("tt", ":tabedit<return>::FzfLua files<CR>")
utils.nmap("tw", ":tabclose<return>")

--- Easier horizontal scrolling
utils.nmap("zl", "zL")
utils.nmap("zh", "zH")

--- Edit/Source vimrc file
utils.nmap("<leader>ev", ":vsplit $MYVIMRC<CR>")
utils.nmap("<leader>sv", ":source $MYVIMRC<CR>")

--- Macro
utils.xmap(".", ":normal .<CR>")
