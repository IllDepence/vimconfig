local util = require('lspconfig/util')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP Keymaps and Common Setup
local function setup_common()
    local opts = { noremap=true, silent=true }
    -- Basic diagnostic mappings
    vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys after LSP attaches
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings to magical LSP functions!
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gk', vim.lsp.buf.hover, bufopts)  -- show documentation
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)  -- rename everywhere
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)  -- e.g. convert to named function
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts) -- show where used
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end
end

-- Diagnostic configuration
local function setup_diagnostics()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    })

    -- Diagnostic symbols
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

-- Setup completion
local function setup_completion()
    local cmp = require('cmp')
    local luasnip = require("luasnip")

    -- Helper function for nvim-cmp tab mapping
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' }
        },
    })

    -- Luasnip setup
    require("luasnip.loaders.from_lua").lazy_load()
    vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
    vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
end

-- TypeScript LSP setup
local function setup_tsserver()
    require('lspconfig').ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            }
        }
    })
end

-- Pyright setup
local function setup_pyright()
    require('lspconfig').pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                    diagnosticMode = "workspace",
                    inlayHints = {
                        variableTypes = true,
                        functionReturnTypes = true,
                    },
                    diagnosticSeverityOverrides = {
                        reportGeneralTypeIssues = "warning",
                        reportOptionalMemberAccess = "warning",
                        reportOptionalSubscript = "warning",
                        reportPrivateUsage = "warning",
                        reportUnboundVariable = "error",
                    },
                },
            },
        },
        root_dir = function(fname)
            local root_files = {
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'Pipfile',
                'pyrightconfig.json',
            }
            return util.root_pattern(unpack(root_files))(fname) or
                   util.find_git_ancestor(fname) or
                   util.path.dirname(fname)
        end,
    })
end

-- Initialize all LSP configurations
local function setup()
    setup_common()
    setup_diagnostics()
    setup_completion()
    setup_tsserver()
    setup_pyright()
end

return { setup = setup } 