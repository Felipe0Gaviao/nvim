-- ===============================
-- Core Editor Options
-- ===============================

-- UI
vim.opt.cursorline = true -- highlight current line
vim.opt.termguicolors = true -- true color support
vim.opt.signcolumn = "yes:1" -- reserve a single column
vim.opt.winborder = "rounded" -- make window borders rounded
vim.opt.wrap = false -- remove line wrap
vim.opt.scrolloff = 8 -- vertical scroll buffer
vim.opt.sidescrolloff = 8 -- horizontal scroll buffer

-- Numbers
vim.opt.number = true -- add numbers at the start of the line as reference
vim.opt.relativenumber = true -- add relative numbers so that i know how many number i am from each line other than the one i'm currently at

-- Tabs & Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- use system clipboard

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Misc / Performance
vim.opt.mouse = "a" -- enable mouse support
vim.opt.updatetime = 300 -- faster CursorHold and completion
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false -- no swapfiles
vim.opt.undofile = true -- persistent undo
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.ttyfast = true -- terminal optimizations

-- Diagnostic
vim.diagnostic.config({ virtual_text = false }) -- inline diagnostics

-- Global LSP Settings
vim.lsp.inlay_hint.enable(true)

-- Keymaping
vim.keymap.set("n", "<leader>w", "<cmd>silent write<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>confirm quit<cr>")
vim.keymap.set({ "n", "i", "v", "t", "c" }, "<C-z>", "<Nop>", { silent = true })

-- ===============================
-- Load Colorscheme Separately
-- ===============================
vim.pack.add({
	"https://github.com/scottmckendry/cyberdream.nvim",
})

vim.cmd("colorscheme cyberdream")
