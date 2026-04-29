return {
	"mrcjkb/rustaceanvim",
	version = "^9", -- v9 requires Neovim >= 0.12 (v8 was for 0.11)
	lazy = false,

	init = function()
		vim.g.rustaceanvim = {
			dap = {
				adapter = require("rustaceanvim.config").get_codelldb_adapter(
					vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
				),
			},
		}
	end,
}
