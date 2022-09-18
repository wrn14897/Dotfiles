local M = {}

function M.map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function M.nmap(shortcut, command)
  M.map('n', shortcut, command)
end

function M.imap(shortcut, command)
  M.map('i', shortcut, command)
end

function M.vmap(shortcut, command)
  M.map('v', shortcut, command)
end

function M.cmap(shortcut, command)
  M.map('c', shortcut, command)
end

function M.tmap(shortcut, command)
  M.map('t', shortcut, command)
end

function M.omap(shortcut, command)
  M.map('o', shortcut, command)
end

function M.xmap(shortcut, command)
  M.map('x', shortcut, command)
end

return M
