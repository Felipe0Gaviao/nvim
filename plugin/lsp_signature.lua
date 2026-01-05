Pack({
	"https://github.com/ray-x/lsp_signature.nvim",
})

require("lsp_signature").setup({
	bind = true,
	floating_window = true,
	hint_enable = false, -- i already use built-in inlay hints

	handler_opts = {
		border = "rounded",
	},

	floating_window_above_cur_line = true,
	timer_interval = 200,
	always_trigger = false,
	zindex = 50,

	max_width = function()
		return math.floor(vim.api.nvim_win_get_width(0) * 0.8)
	end,
})
