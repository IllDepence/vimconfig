local M = {}

function M.setup()
    -- Disable Copilot when in /dev/shm
    vim.api.nvim_create_autocmd("BufReadPre", {
        pattern = "*",
        callback = function()
            local path = vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':p')
            if string.match(path, "^/dev/shm") then
                vim.b.copilot_enabled = false
            end
        end
    })

    -- Ctrl + j to accept Copilot suggestions
    vim.cmd[[imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")]]

    -- Disable tab mapping for Copilot
    vim.g.copilot_no_tab_map = true
end

return M 