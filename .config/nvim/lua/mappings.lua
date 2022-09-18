local utils = require('utils')

utils.nmap('j', 'gj')
utils.nmap('k', 'gk')
utils.nmap('<C-c>', ':noh<return><C-c>')
utils.nmap('H', 'gT')
utils.nmap('L', 'gt')
utils.nmap('tt', ':tabedit<return>:CocCommand fzf-preview.FromResources project_mru git<CR>')
utils.nmap('tw', ':tabclose<return>')
utils.imap('jk', '<esc>')
utils.imap('<esc>', '<nop>')
--- Yank from the cursor to the end of the line, to be consistent with C and D.
utils.nmap('Y', 'y$')

--- Find merge conflict markers
utils.nmap('<leader>fc', '/\v^[<|=>]{7}( .*|$)<CR>')

--- For when you forget to sudo.. Really Write the file.
utils.cmap('w!!', 'w !sudo tee % >/dev/null')

--- Easier horizontal scrolling
utils.nmap('zl', 'zL')
utils.nmap('zh', 'zH')

--- Edit/Source vimrc file
utils.nmap('<leader>ev', ':vsplit $MYVIMRC<CR>')
utils.nmap('<leader>sv', ':source $MYVIMRC<CR>')

--- Macro
utils.xmap('.', ':normal .<CR>')

