" ================================================
" Neovim Initialization
" ================================================

" Disable netrw (Vim's default file explorer)
" Required at the very start by nvim-tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Source the main configuration
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" ================================================
" Lua Configurations
" ================================================

lua require('config')

" ================================================
" Additional Neovim Settings
" ================================================

" Set leader key (optional, enhances usability)
let mapleader = " "

" ================================================
" Plugin-Specific Configurations
" ================================================

" Prettier on Save for supported filetypes
augroup PrettierOnSave
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx,*.html,*.css,*.scss Prettier
augroup END

" ================================================
" Final Touches
" ================================================

" Load all packages and generate help tags silently
packloadall
silent! helptags ALL 