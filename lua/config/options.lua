-- linenumbers
vim.opt.nu = true
vim.opt.rnu = true

-- indentation
vim.opt.tabstop = 4 -- default 4
vim.opt.softtabstop = 4 -- default 4
vim.opt.shiftwidth = 4 -- default 4
vim.opt.expandtab = true -- default true
vim.opt.smartindent = true

-- cursor and colors
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.cmd([[colorscheme gruvbox]])
--vim.cmd("colorscheme koehler")

-- clipboard
vim.opt.clipboard = unnamed
vim.opt.clipboard = unnamedplus

-- undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search
vim.opt.incsearch = true

-- scrolling
vim.opt.scrolloff = 8

vim.opt.list = true

-- remove all trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

-- diagnostic
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},
})

-- display of space and tab
vim.opt.listchars = {
	tab = "⋅⋅",
	space = "⋅",
}
