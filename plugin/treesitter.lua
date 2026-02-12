Pack({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local treesitter = require("nvim-treesitter")

treesitter.install({
	"python",
	"markdown",
	"markdown_inline",
	"lua",
	"luadoc",
	"luap",
	"regex",
	"requirements",
	"toml",
	"typescript",
	"javascript",
	"ecma",
	"bash",
	"zsh",
	"comment",
	"css",
	"diff",
	"git_config",
	"git",
	"git_rebase",
	"gitcommit",
	"gitignore",
	"json",
	"html",
	"html_tags",
	-- may be needed later
	-- "htmljango",
	-- "jinja",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if pcall(vim.treesitter.start, args.buf) then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
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
