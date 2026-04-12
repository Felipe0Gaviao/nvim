Pack({
	"https://github.com/stevearc/oil.nvim",
})

require("lze").load({
	{
		"oil.nvim",
		keys = { { "<leader>e", "<cmd>Oil<cr>", mode = "n", desc = "Open oil" } },
		after = function()
			require("oil").setup({
				skip_confirm_for_simple_edits = true,
				lsp_file_methods = {
					auto_save_changes = "unmodified",
				},
				watch_for_changes = true,
			})
		end,
	},
})
