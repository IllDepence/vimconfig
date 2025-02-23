local M = {}

function M.setup()
    -- Nvim-tree setup
    require('nvim-tree').setup()
    vim.api.nvim_set_keymap(
        'n',
        'fm',
        '<cmd>NvimTreeToggle<cr>',
        { noremap = true, silent = true }
    )
end

return M 
