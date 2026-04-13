Pack({
	"https://github.com/rmagatti/logger.nvim",
	"https://github.com/rmagatti/goto-preview",
})

local goto_preview = require("goto-preview")

goto_preview.setup()

Map("n", "gd", goto_preview.goto_preview_definition, { desc = "Preview definition" })
Map("n", "gt", goto_preview.goto_preview_type_definition, { desc = "Preview type definition" })
Map("n", "gi", goto_preview.goto_preview_implementation, { desc = "Preview implementation" })
Map("n", "gD", goto_preview.goto_preview_declaration, { desc = "Preview declaration" })
