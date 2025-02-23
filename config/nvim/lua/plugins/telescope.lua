local M = {}

function M.setup()
    -- Telescope setup
    local map = vim.keymap.set
    map('n', 'ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true, desc = 'Find files' })
    map('n', 'fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true, desc = 'Live grep' })
end

return M 
