local M = {}

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)

function M.create_undo()
	if vim.api.nvim_get_mode().mode == "i" then
		vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
	end
end

function M.confirm(opts)
	local cmp = require("cmp")

	opts = vim.tbl_extend("force", {
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}, opts or {})

	return function(fallback)
		if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
			M.create_undo()

			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

M.map_item = {
	source = {
		buffer = "BUF │",
		path = "PTH │",
		nvim_lsp = "LSP │",
		luasnip = "SNP │",

		nvim_lsp_signature_help = "",
	},
	type = {
		Class = " CLS",
		Color = " CLR",
		Constant = " CON",
		Constructor = " CTR",
		Enum = " ENM",
		EnumMember = " ENM",
		Event = " EVT",
		Field = " FLD",
		File = " FIL",
		Folder = " FOL",
		Function = " FUN",
		Interface = " INT",
		Keyword = " KEY",
		Method = " MTH",
		Module = " MOD",
		Operator = " OPR",
		Property = " PRP",
		Reference = " REF",
		Snippet = " SNP",
		Struct = " STR",
		Text = " TXT",
		TypeParameter = " TYP",
		Unit = " UNT",
		Value = " VAL",
		Variable = " VAR",
	},
}

return M
