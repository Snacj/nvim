return {
    name = "monokai",
    colorscheme = "monokai",
    lualine = "auto",
    setup = function()
        require("monokai").setup { palette = require("monokai").pro }
    end,
}
