local M = {
	"lukas-reineke/indent-blankline.nvim",
}

M.main = "ibl"

---@module "ibl"
---@type ibl.config
M.opts = {
	indent = { char = "│" },
	scope = {
		enabled = false,
	},
}

return M
