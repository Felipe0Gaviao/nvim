Pack({
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
	skip_confirm_for_simple_edits = true,
	lsp_file_methods = {
		auto_save_changes = "unmodified",
	},
	watch_for_changes = true,
})

Map("n", "<leader>e", "<cmd>Oil<cr>")
