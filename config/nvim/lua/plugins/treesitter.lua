local M = {}

function M.setup()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            "python",
            "javascript",
            "typescript",
            "lua",
            "vim",
            "vimdoc"
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    })
end

return M 