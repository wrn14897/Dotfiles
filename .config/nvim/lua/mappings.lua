function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

nmap('j', 'gj')
nmap('k', 'gk')
nmap('<C-c>', ':noh<return><C-c>')
nmap('H', 'gT')
nmap('L', 'gt')
nmap('tt', ':tabedit<return>:CocCommand fzf-preview.FromResources project_mru git<CR>')
nmap('tw', ':tabclose<return>')
imap('jk', '<esc>')
imap('<esc>', '<nop>')
-- " Yank from the cursor to the end of the line, to be consistent with C and D.
nmap('Y', 'y$')

-- " Find merge conflict markers
nmap('<leader>fc', '/\v^[<|=>]{7}( .*|$)<CR>')

-- " For when you forget to sudo.. Really Write the file.
cmap('w!!', 'w !sudo tee % >/dev/null')

-- " Easier horizontal scrolling
nmap('zl', 'zL')
nmap('zh', 'zH')

-- " Edit/Source vimrc file
nmap('<leader>ev', ':vsplit $MYVIMRC<CR>')
nmap('<leader>sv', ':source $MYVIMRC<CR>')

-- " Macro
vim.cmd([[ xnoremap <silent> . :normal .<CR> ]])

