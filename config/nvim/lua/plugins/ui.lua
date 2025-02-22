local M = {}

function M.setup()
    -- Lualine setup
    require('lualine').setup({
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'filename', 'diagnostics'},
            lualine_c = {'branch', 'diff'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        }
    })

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