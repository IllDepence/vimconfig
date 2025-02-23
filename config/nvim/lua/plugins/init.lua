-- Plugin configurations
local M = {}

function M.setup()
    require('plugins.treesitter').setup()
    require('plugins.completion').setup()
    require('plugins.lualine').setup()
    require('plugins.nvim-tree').setup()
    require('plugins.telescope').setup()
    require('plugins.gitsigns').setup()
end

return M 
