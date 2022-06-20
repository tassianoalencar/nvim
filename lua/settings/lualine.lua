local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
    return
end

local icons = require("settings.icons")

lualine.setup({
    globalstatus = true,
    icons_enabled = true,
})
