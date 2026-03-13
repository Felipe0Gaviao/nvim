-- Experimental Lua Module loader
-- vim.loader.enable() -- adding this gave some errors, will look into it soon
-- ===============================
-- Core Shortcuts
-- ===============================

---Create a simple shortcut to vim.opt
local opt = vim.opt

---Create a keymap with sane defaults
---@param mode string|string[] Mode(s), e.g. "n" or { "n", "v" }
---@param lhs string Left-hand side
---@param rhs string|function Right-hand side
---@param opts? vim.keymap.set.Opts Keymap options
Map = function(mode, lhs, rhs, opts)
	local defaults = {
		silent = true,
		noremap = true,
	}
	opts = vim.tbl_extend("force", defaults, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

---Simple wrapper around vim.pack.add with default opts
---@param specs (string|vim.pack.Spec)[] List of plugin specifications.
---@param opts? vim.pack.keyset.add Options forwarded to vim.pack.add
Pack = function(specs, opts)
	local defaults = {
		confirm = false,
	}
	opts = vim.tbl_extend("force", defaults, opts or {})
	vim.pack.add(specs, opts)
end

-- ===============================
-- Core Editor Options
-- ===============================
--
-- Installing mini.nvim to deal with some of those options for me with mini.basics
Pack({
	"https://github.com/nvim-mini/mini.nvim",
})

require("mini.basics").setup({
	options = {
		basic = true,
		extra_ui = true,
		win_borders = "rounded",
	},
	mappings = {
		basic = true,
		option_toggle_prefix = [[\]],
		windows = false,
		move_with_alt = true,
	},
	auto_commands = {
		basic = true,
	},
	silent = true,
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

-- UI
opt.scrolloff = 8 -- vertical scroll buffer
opt.sidescrolloff = 8 -- horizontal scroll buffer

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- use spaces instead of tabs
opt.smarttab = true

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldcolumn = "1"

-- Clipboard
opt.clipboard = "unnamedplus" -- use system clipboard

-- Misc / Performance
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.updatetime = 200 -- faster CursorHold and completion
opt.swapfile = false -- no swapfiles

-- Diagnostic
vim.diagnostic.config({ virtual_text = false }) -- inline diagnostics

-- Global LSP Settings
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf

		vim.lsp.inlay_hint.enable(true, { bufnr = buf })

		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
	end,
})

-- Keymaping
Map("n", "<leader>w", "<cmd>silent write<cr>", { desc = "Easier Write" })
Map("n", "<leader>q", "<cmd> confirm quit<cr>", { desc = "Better quit" })
Map(
	{ "n", "i", "v", "t", "c" },
	"<C-z>",
	"<Nop>",
	{ desc = "disable annoying option that sends neovim to background process" }
)
Map("n", "<esc>", "<cmd>noh<cr>")

-- ===============================
-- Load Colorscheme Separately
-- ===============================
Pack({
	"https://github.com/scottmckendry/cyberdream.nvim",
})

vim.cmd.colorscheme("cyberdream")

-- ===============================
-- Automate nvim-pack-lock.json chore commit
-- ===============================
local commit_pending = false

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.kind ~= "update" and ev.data.kind ~= "install" then
			return
		end

		commit_pending = true
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if not commit_pending then
			return
		end

		local config = vim.fn.stdpath("config")
		local lockfile = "nvim-pack-lock.json"

		vim.system({
			"git",
			"-C",
			config,
			"commit",
			"--only",
			lockfile,
			"-m",
			"chore(plugins): update neovim config plugins",
		})
	end,
})
