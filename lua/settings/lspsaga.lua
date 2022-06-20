-- lua/settings/lspsaga.lua
local status_ok, saga = pcall(require, "lspsaga")

if not status_ok then
	return
end

saga.setup({
	debug = false,
	use_saga_diagnostic_sign = true,
})
