local util = require('lspconfig/util')

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
    setup_diagnostics()
    setup_pyright()
end

return { setup = setup } 