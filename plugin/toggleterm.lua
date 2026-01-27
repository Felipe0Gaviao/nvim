Pack({
	"https://github.com/akinsho/toggleterm.nvim",
})

require("toggleterm").setup({
	direction = "float",
	open_mapping = [[<C-\>]],
	start_in_insert = true,
	persist_mode = true,
	persist_size = true,
	float_opts = {
		border = "rounded",
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
	},
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*toggleterm#*",
	callback = function()
		local opts = { buffer = true }

		-- Leave terminal mode
		Map("t", "<Esc>", [[<C-\><C-n>]], opts)
	end,
})

Map("n", "<leader>t", "<cmd>ToggleTerm<cr>")
