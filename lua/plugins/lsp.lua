return {
	-- Mason: installs LSP servers, formatters, linters, DAP adapters
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	-- mason-lspconfig v2: bridges Mason package names to LSP config names
	-- and auto-enables installed servers via vim.lsp.enable()
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig", -- provides lsp/ config files for vim.lsp.config
		},
		opts = {
			ensure_installed = {
				"bashls",
				"marksman",
				"clangd",
				"lua_ls",
			},
			-- v2: automatically calls vim.lsp.enable() for installed servers
			automatic_enable = true,
		},
	},

	-- mason-tool-installer: ensures formatters/linters/DAP adapters are installed
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"prettierd",
				"codelldb",
				"js-debug-adapter",
			},
		},
	},

	-- Useful LSP status updates
	{ "j-hui/fidget.nvim", opts = {} },

	-- nvim-lspconfig: provides lsp/<server>.lua config files that
	-- vim.lsp.config() reads natively in 0.12
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Per-server config overrides using the 0.12 native API
			-- vim.lsp.config() merges with configs from nvim-lspconfig's lsp/ directory
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						-- uncomment if you want to suppress noisy missing-fields warnings
						-- diagnostics = { disable = { "missing-fields" } },
					},
				},
			})

			-- Extend LSP capabilities with blink.cmp
			local original_capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("blink-cmp").get_lsp_capabilities(original_capabilities)

			-- Apply capabilities to all servers via the wildcard config
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			--  LspAttach: runs when an LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Navigation (using fzf-lua pickers)
					map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
					map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
					map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

					-- Actions
					map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
					map("<leader>ca", require("fzf-lua").lsp_code_actions, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Highlight references under cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "kickstart-lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end

					-- Toggle inlay hints
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
		end,
	},

	-- mason-nvim-dap: installs DAP adapters
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"codelldb",
				"js-debug-adapter",
			},
			automatic_installation = true,
		},
	},
}
