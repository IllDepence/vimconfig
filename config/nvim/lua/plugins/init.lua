-- Plugin configurations
local M = {}

function M.setup()
    require('plugins.treesitter').setup()
    require('plugins.completion').setup()
    require('plugins.ui').setup()
end

return M 