-- Plugin: neodev
-- url: https://github.com/folke/neodev.nvim

local status_ok, neodev = pcall(require, "neodev")
if not status_ok then
	return
end

neodev.setup()
