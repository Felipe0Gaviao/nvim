vim.pack.add({
	{
		src = "https://github.com/rmagatti/logger.nvim",
	},
	{
		src = "https://github.com/rmagatti/goto-preview",
	},
})

local goto_preview = require("goto-preview")

goto_preview.setup()

vim.keymap.set("n", "gd", goto_preview.goto_preview_definition)
vim.keymap.set("n", "gt", goto_preview.goto_preview_type_definition)
vim.keymap.set("n", "gi", goto_preview.goto_preview_implementation)
vim.keymap.set("n", "gD", goto_preview.goto_preview_declaration)
