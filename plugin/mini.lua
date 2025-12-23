vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.notify").setup({
	lsp_progress = {
		enable = false, -- disable lsp notifications of things like "loading workspace"
	},
})
require("mini.operators").setup() -- not sure if i'm going to use this a lot, remember keymap "g="
require("mini.pairs").setup() -- auto pairs
require("mini.surround").setup() -- like auto pairs but without the auto
require("mini.indentscope").setup({
	draw = {
		animation = require("mini.indentscope").gen_animation.none(), -- disable scope animation
	},
}) -- highlight indentation scope, really good for things like dealing with lenghty HTML bodies
require("mini.statusline").setup()
