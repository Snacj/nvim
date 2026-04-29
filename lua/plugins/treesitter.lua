return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- 0.12: must use main branch (master is archived)
	build = ":TSUpdate",
	lazy = false,

	config = function()
		-- Parsers to auto-install
		local ensure_installed = {
			"lua", "python", "typescript", "javascript", "rust", "go",
			"bash", "json", "yaml", "toml", "markdown", "markdown_inline",
			"html", "css", "c", "cpp",
		}

		local ts = require("nvim-treesitter")
		if ts.install then
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(p) return not vim.tbl_contains(installed, p) end)
				:totable()
			if #to_install > 0 then
				ts.install(to_install)
			end
		end

		-- 0.12: Highlighting, folding are native
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldlevel = 99
			end,
		})
	end,
}
