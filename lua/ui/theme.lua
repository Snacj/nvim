local M = {}
local current = nil

local theme_file = vim.fn.stdpath("state") .. "/theme.txt"
local darkmode_file = vim.fn.stdpath("state") .. "/darkmode.txt"

local function read_theme()
	local f = io.open(theme_file, "r")
	if not f then return nil end
	local name = f:read("*l")
	f:close()
	return name
end

local function write_theme(name)
	local f = io.open(theme_file, "w")
	if not f then return end
	f:write(name)
	f:close()
end

local function read_darkmode()
	local f = io.open(darkmode_file, "r")
	if not f then return nil end
	local val = f:read("*l")
	f:close()
	return val == "true"
end

local function write_darkmode(is_dark)
	local f = io.open(darkmode_file, "w")
	if not f then return end
	f:write(tostring(is_dark))
	f:close()
end

local function apply_darkmode(is_dark)
	vim.o.background = is_dark and "dark" or "light"
end

function M.load(name, opts)
	opts = opts or {}

	local theme = require("ui.themes." .. name)
	if not theme or not theme.colorscheme then
		vim.notify("Invalid theme: " .. name, vim.log.levels.ERROR)
		return
	end

	local is_dark = theme.darkmode ~= false
	apply_darkmode(is_dark)

	if theme.setup then
		theme.setup()
	end

	local ok = pcall(vim.cmd, "colorscheme " .. theme.colorscheme)
	if not ok then
		vim.notify("Failed to load colorscheme: " .. theme.colorscheme, vim.log.levels.ERROR)
		return
	end

	current = theme

	if package.loaded["lualine"] and theme.lualine then
		require("lualine").setup({
			options = { theme = theme.lualine },
		})
	end

	if not opts.no_persist then
		write_theme(name)
		write_darkmode(is_dark)
	end
end

function M.load_last()
	local last = read_theme()
	if last then
		M.load(last, { no_persist = true })
	end
end

function M.get()
	return current
end

return M
