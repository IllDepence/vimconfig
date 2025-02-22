-- Main entry point for Lua configuration
local plugins = require('plugins')
local lsp = require('lsp')

-- Initialize everything
plugins.setup()
lsp.setup() 