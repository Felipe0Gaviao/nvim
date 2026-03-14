Pack({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local treesitter = require("nvim-treesitter")

treesitter.install({
	"bash",
	"comment",
	"css",
	"diff",
	"ecma",
	"git_config",
	"git_rebase",
	"gitcommit",
	"gitignore",
	"html",
	"html_tags",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"requirements",
	"rust",
	"toml",
	"typescript",
	"zsh",
	"htmljango",
	"jinja",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if pcall(vim.treesitter.start, args.buf) then
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript" },
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("treesitter-context").setup({
	mode = "topline",
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local kind, name = ev.data.kind, ev.data.spec.name

		if kind ~= "install" and kind ~= "update" then
			return
		end

		if name ~= "nvim-treesitter" then
			return
		end

		vim.notify("Checking Treesitter parsers…", vim.log.levels.INFO)

		treesitter.update(treesitter.get_installed(), { summary = true })
	end,
})
