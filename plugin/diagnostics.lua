Pack({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require("lze").load({
	{
		"tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		after = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				options = {
					show_source = {
						enabled = true,
						if_many = true,
					},
					multilines = {
						enabled = true,
						always_show = true,
					},
				},
			})
			vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
		end,
	},
})
