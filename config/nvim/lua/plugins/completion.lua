local M = {}

function M.setup()
    local cmp = require('cmp')
    
    -- LuaSnip setup
    local luasnip = require('luasnip')
    
    -- Load VSCode-like snippets from installed plugins
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Custom keymaps for snippet navigation
    vim.keymap.set({"i", "s"}, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end, {silent = true})
    
    vim.keymap.set({"i", "s"}, "<C-l>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, {silent = true})

    cmp.setup({
        mapping = {
            -- Add tab support
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
        },
        -- Enable LSP snippets
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        -- Installed sources with adjusted priority
        sources = cmp.config.sources({
            { name = 'nvim_lsp'},
            { name = 'luasnip'},
            { name = 'path'}
        }, {
            { name = 'buffer'},
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    })
end

return M 
