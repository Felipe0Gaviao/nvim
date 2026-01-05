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
---@param opts table? Options forwarded to vim.pack.add
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

-- UI
opt.cursorline = true -- highlight current line
opt.termguicolors = true -- true color support
opt.signcolumn = "yes:1" -- reserve a single column
opt.winborder = "rounded" -- make window borders rounded
opt.wrap = false -- remove line wrap
opt.scrolloff = 8 -- vertical scroll buffer
opt.sidescrolloff = 8 -- horizontal scroll buffer

-- Numbers
opt.number = true -- add numbers at the start of the line as reference
opt.relativenumber = true -- add relative numbers so that i know how many number i am from each line other than the one i'm currently at

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- use spaces instead of tabs
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Clipboard
opt.clipboard = "unnamedplus" -- use system clipboard

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Misc / Performance
opt.mouse = "a" -- enable mouse support
opt.updatetime = 300 -- faster CursorHold and completion
opt.completeopt = { "menuone", "noselect", "popup" }
opt.backup = false
opt.writebackup = false
opt.swapfile = false -- no swapfiles
opt.undofile = true -- persistent undo
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.ttyfast = true -- terminal optimizations

-- Diagnostic
vim.diagnostic.config({ virtual_text = false }) -- inline diagnostics

-- Global LSP Settings
vim.lsp.inlay_hint.enable(true)

-- Keymaping
Map("n", "<leader>w", "<cmd>silent write<cr>")
Map("n", "<leader>q", "<cmd>confirm quit<cr>")
Map({ "n", "i", "v", "t", "c" }, "<C-z>", "<Nop>", { silent = true })
Map("n", "<esc>", "<cmd>noh<cr>", { noremap = true, silent = true })

-- ===============================
-- Load Colorscheme Separately
-- ===============================
Pack({
	"https://github.com/scottmckendry/cyberdream.nvim",
})

vim.cmd.colorscheme("cyberdream")
