Pack({ "https://github.com/nvim-mini/mini.nvim" })

local MiniAi = require("mini.ai")
MiniAi.setup({
	custom_textobjects = {
		-- Function definition (overrides builtin 'f' which does function *calls*)
		f = MiniAi.gen_spec.treesitter({
			a = "@function.outer",
			i = "@function.inner",
		}),
		c = MiniAi.gen_spec.treesitter({
			a = "@class.outer",
			i = "@class.inner",
		}),
		o = MiniAi.gen_spec.treesitter({
			a = "@conditional.outer",
			i = "@conditional.inner",
		}),
		l = MiniAi.gen_spec.treesitter({
			a = "@loop.outer",
			i = "@loop.inner",
		}),
	},
})

local MiniClue = require("mini.clue")
MiniClue.setup({
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
		MiniClue.gen_clues.square_brackets(),
		MiniClue.gen_clues.g(),
		MiniClue.gen_clues.z(),
		MiniClue.gen_clues.marks(),
		MiniClue.gen_clues.registers(),
		MiniClue.gen_clues.windows(),
	},
})

require("mini.files").setup({
	windows = {
		preview = true,
		width_focus = 40,
		width_nofocus = 15,
		width_preview = 35,
	},
	mappings = {
		go_in = "",
		go_in_plus = "l",
	},
})

vim.keymap.set("n", "-", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end)

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

require("mini.pick").setup({
	options = {
		use_cache = true,
	},
	mappings = {
		scroll_left = "",
		scroll_right = "",
		move_down = "<C-j>",
		move_up = "<C-k>",
	},
	window = {
		config = function()
			local height = math.floor(0.618 * vim.o.lines)
			local width = math.floor(0.618 * vim.o.columns)
			return {
				anchor = "NW",
				height = height,
				width = width,
				row = math.floor(0.5 * (vim.o.lines - height)),
				col = math.floor(0.5 * (vim.o.columns - width)),
			}
		end,
	},
})

vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "fuzzy find Files" })
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "fuzzy find text" })
vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "fuzzy find on currently open buffers" })
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "fuzzy find help" })

require("mini.extra").setup()

require("mini.sessions").setup({ autoread = true })

require("mini.statusline").setup() -- changes the statusline at the bottom of the window
require("mini.surround").setup() -- surround text by selecting in visual mode and pressing "sa"
