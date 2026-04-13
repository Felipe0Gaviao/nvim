Pack({ "https://github.com/folke/lazydev.nvim" })

require("lze").load({
	{
		"lazydev.nvim",
		ft = "lua",
		after = function()
			require("lazydev").setup({
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			})
		end,
	},
})
