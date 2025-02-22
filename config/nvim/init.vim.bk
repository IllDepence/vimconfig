" disable netrw (vim standard file browser)
" (required toat the very start of
"  init.[lua/vim] by nvim-tree)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" ensure compatibility w/ vim config and plugins
set runtimepath^=~/.vim runtimepath+=~/.vim/after

" synchronize package path w/ runtime path
let &packpath = &runtimepath

" load vim config
source ~/.vimrc

" Ctrl + j to accpet Copilot suggestions
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
" don’t use tab for a accepting suggestions
let g:copilot_no_tab_map = v:true

" disable Copilot when directory path is /dev/shm (?)
autocmd BufReadPre *
    \ if expand('%:p:h') =~ '/dev/shm'
    \ | let b:copilot_enabled = v:false
    \ | endif

" set color scheme
" (https://vimcolorschemes.com/i/trending)
let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1
colorscheme sonokai

" telescope
" " ff to search by file name
nnoremap ff <cmd>Telescope find_files<cr>
" " fg to search by grepping in file contents
nnoremap fg <cmd>Telescope live_grep<cr>

" - - - - - lua part - - - - -
lua << END

-- lualine
require('lualine').setup()

-- nvim-tree
require("nvim-tree").setup()
vim.api.nvim_set_keymap(
    'n',
    'fm',
    '<cmd>NvimTreeToggle<cr>',
    { noremap = true, silent = true }
)

-- treesitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "javascript", "lua", "vim", "vimdoc" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {  },

  -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    disable = {  },
    additional_vim_regex_highlighting = false,
  },
}

END
