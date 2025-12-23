-- ===============================
-- Core Editor Options
-- ===============================

-- UI
vim.o.cursorline = true -- highlight current line
vim.o.termguicolors = true -- true color support
vim.o.signcolumn = "yes:1" -- reserve a single column
vim.o.winborder = "rounded" -- make window borders rounded
vim.o.wrap = false -- remove line wrap
vim.o.scrolloff = 8 -- vertical scroll buffer
vim.o.sidescrolloff = 8 -- horizontal scroll buffer

-- Numbers
vim.o.number = true -- add numbers at the start of the line as reference
vim.o.relativenumber = true -- add relative numbers so that i know how many number i am from each line other than the one i'm currently at

-- Tabs & Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Clipboard
vim.o.clipboard = "unnamedplus" -- use system clipboard

-- Split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Misc / Performance
vim.o.mouse = "a" -- enable mouse support
vim.o.updatetime = 300 -- faster CursorHold and completion
vim.o.completeopt = "menuone,noselect,popup"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false -- no swapfiles
vim.o.undofile = true -- persistent undo
vim.o.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.ttyfast = true -- terminal optimizations

-- Diagnostic
vim.diagnostic.config({ virtual_text = true }) -- inline diagnostics

-- ===============================
-- Load Colorscheme Separately
-- ===============================
vim.pack.add({
	"https://github.com/scottmckendry/cyberdream.nvim",
})

vim.cmd("colorscheme cyberdream")

-- ===============================
-- Load Modular Config
-- ===============================
require("keymaps")
