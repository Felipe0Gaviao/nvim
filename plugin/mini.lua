Pack({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.icons").setup()
require("mini.indentscope").setup({
	draw = {
		animation = require("mini.indentscope").gen_animation.none(), -- disable scope animation
	},
}) -- highlight indentation scope, really good for things like dealing with lengthy HTML and function bodies
require("mini.move").setup() -- move things (use Alt + the direction)
require("mini.notify").setup({
	lsp_progress = {
		enable = false, -- disable lsp notifications of things like "loading workspace"
	},
}) -- adds better notifications
require("mini.operators").setup() -- not sure if i'm going to use this enough to be worth it, remember keymap "g="
require("mini.pairs").setup() -- auto pairs
require("mini.statusline").setup() -- changes the statusline at the bottom of the window
require("mini.surround").setup() -- surround text by selecting in visual mode and pressing "sa"
