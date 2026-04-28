Pack({ "https://github.com/nvim-mini/mini.nvim" })

local miniai = require("mini.ai")
miniai.setup({
	custom_textobjects = {
		-- Function definition (overrides builtin 'f' which does function *calls*)
		f = miniai.gen_spec.treesitter({
			a = "@function.outer",
			i = "@function.inner",
		}),
		c = miniai.gen_spec.treesitter({
			a = "@class.outer",
			i = "@class.inner",
		}),
		o = miniai.gen_spec.treesitter({
			a = "@conditional.outer",
			i = "@conditional.inner",
		}),
		l = miniai.gen_spec.treesitter({
			a = "@loop.outer",
			i = "@loop.inner",
		}),
	},
})

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = { "n", "x" }, keys = "<Leader>" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		{ mode = { "n", "x" }, keys = "g" },
		{ mode = { "n", "x" }, keys = "z" },
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = "n", keys = "<C-w>" },
	},
	clues = {
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.z(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
	},
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
require("mini.sessions").setup({ autoread = true })
require("mini.snippets").setup({
	snippets = {
		require("mini.snippets").gen_loader.from_lang(),
	},
})
require("mini.snippets").start_lsp_server()
require("mini.statusline").setup() -- changes the statusline at the bottom of the window
require("mini.surround").setup() -- surround text by selecting in visual mode and pressing "sa"
