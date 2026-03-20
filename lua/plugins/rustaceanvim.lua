return {
	"mrcjkb/rustaceanvim",
	version = "^8", -- Recommended
	lazy = false, -- This plugin is already lazy

	init = function()
		-- This MUST be in init (runs before plugin loads)
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
