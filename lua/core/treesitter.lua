-- Install tree-sitter-cli first:
-- pacman -S tree-sitter

-- Parsers to install (run :TSInstall <lang> for each, or use the loop below)
local ensure_installed = {
	"lua",
	"python",
	"typescript",
	"javascript",
	"rust",
	"go",
	"bash",
	"json",
	"yaml",
	"toml",
	"markdown",
	"markdown_inline",
	"html",
	"css",
	"c",
	"cpp",
}

-- Auto-install missing parsers on startup
local ok, ts = pcall(require, "nvim-treesitter")
if ok then
	local already_installed = require("nvim-treesitter.config").get_installed()
	local to_install = vim.iter(ensure_installed)
		:filter(function(p)
			return not vim.tbl_contains(already_installed, p)
		end)
		:totable()
	if #to_install > 0 then
		ts.install(to_install)
	end
end

-- Highlighting, indentation, and folding
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		-- Highlighting
		pcall(vim.treesitter.start)
		-- Treesitter-based indentation (experimental) NOT WORKING FOR ME RIGHT NOW 04/2026
		-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		-- Folding
		vim.wo[0][0].foldmethod = "expr"
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldlevel = 99 -- start unfolded
	end,
})

-- Folding hotkeys:
-- zo  → open fold under cursor
-- zO  → open fold recursively
-- zR  → open all folds in file
-- za  → toggle fold under cursor
-- zA  → toggle fold recursively
-- zc  → close fold under cursor
-- zC  → close fold recursively
-- zM  → close all folds in file
