-- ===============================
-- Experimenal Stuff
-- ===============================
-- Enables the experimental Lua module loader
-- vim.loader.enable() -- adding this gave some errors, will look into it soon
-- Experimenal Ui2 Module
require("vim._core.ui2").enable()

---Simple wrapper around vim.pack.add with some default opts
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
-- Core Plugins
-- ===============================
Pack({
	"https://github.com/BirdeeHub/lze",
	-- Installing Tiny.cmdlines
	"https://github.com/rachartier/tiny-cmdline.nvim",
	-- Installing mini.nvim to deal with some of those basics for me with mini.basics
	"https://github.com/nvim-mini/mini.nvim",
	-- Installing Snacks here to set some things available in this file
	"https://github.com/folke/snacks.nvim",
})

vim.g.lze = {
	verbose = true,
}

require("tiny-cmdline").setup({
	on_reposition = require("tiny-cmdline").adapters.blink,
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

require("snacks").setup({
	bigfile = {
		enabled = true,
	},
	git = {
		enabled = true,
	},
	lazygit = {
		enabled = true,
	},
	rename = {
		enabled = true,
	},
	terminal = {
		enabled = true,
		win = {
			style = "float",
			border = "rounded",
			width = 0.8,
			height = 0.8,
		},
	},
	input = {
		enabled = true,
	},
})

-- ===============================
-- Core Config Options
-- ===============================

---Create a simple shortcut to vim.opt
local opt = vim.opt

-- UI
opt.scrolloff = 8 -- vertical scroll buffer
opt.sidescrolloff = 8 -- horizontal scroll buffer
opt.cmdheight = 0

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
		-- attach lsp_signature if loaded
		local ok, sig = pcall(require, "lsp_signature")
		if ok then
			sig.on_attach({}, buf)
		end
	end,
})

---Create a keymap with sane defaults
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? snacks.keymap.set.Opts
Map = function(mode, lhs, rhs, opts)
	local defaults = {
		silent = true,
		noremap = true,
	}
	opts = vim.tbl_extend("force", defaults, opts or {})
	require("snacks.keymap").set(mode, lhs, rhs, opts)
end

-- Keymaping
Map("n", "<leader>w", "<cmd>silent write<cr>", { desc = "Easier Write" })
Map("n", "<leader>q", "<cmd> confirm quit<cr>", { desc = "Better quit" })
Map(
	{ "n", "i", "v", "t", "c" },
	"<C-z>",
	"<Nop>",
	{ desc = "disable annoying option that sends neovim to background process" }
)
Map("n", "<esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })
Map("n", "<leader>ca", vim.lsp.buf.code_action, { lsp = { method = "textDocument/codeAction" }, desc = "Code Action" })

-- ===============================
-- Load Colorscheme Separately
-- ===============================
vim.cmd.colorscheme("miniwinter")

-- ===============================
-- Automate nvim-pack-lock.json chore commit
-- ===============================
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		local msg = string.format("chore(plugins): %s %s", kind, name)
		local config = vim.fn.stdpath("config")

		vim.defer_fn(function()
			local result = vim.system({
				"git",
				"-C",
				config,
				"commit",
				"--only",
				"nvim-pack-lock.json",
				"-m",
				msg,
			}, { text = true }):wait()

			if result.code ~= 0 then
				local output = (result.stdout or "") .. (result.stderr or "")
				if not output:find("nothing to commit") then
					vim.notify("lockfile commit failed:\n" .. result.stderr, vim.log.levels.ERROR)
				end
			end
		end, 500)
	end,
})
