-- lua/settings/colorscheme.lua
local status_ok, theme = pcall(require, "themer")

if not status_ok then
	print("Erro ao carregar configuração de temas")
	return
end

theme.setup({
	colorscheme = "rose_pine",
	transparent = true,
	enable_installer = true,
})
