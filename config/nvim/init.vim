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

" Python-specific settings
augroup python_files
    autocmd!
    " Enable Black formatting on save
    autocmd BufWritePre *.py Black
    " Set Python path for Neovim
    if has('nvim') && !empty($VIRTUAL_ENV)
        let g:python3_host_prog = $VIRTUAL_ENV . '/bin/python'
    endif
augroup END

" Replace current Black configuration with:
augroup python_formatting
    autocmd!
    " Format on save if Black is available
    autocmd BufWritePre *.py if executable('black') | 
        \ silent! execute '!black --quiet %' |
        \ endif
    " Show formatting errors if any
    autocmd BufWritePost *.py if v:shell_error | echohl WarningMsg |
        \ echo 'Black formatting failed' |
        \ echohl None |
        \ endif
augroup END

" Add pipenv configuration
augroup pipenv_settings
    autocmd!
    " Set Python path for Neovim when in a pipenv environment
    if has('nvim')
        let $PYTHONPATH = system('pipenv --venv 2>/dev/null')
        if v:shell_error == 0
            let g:python3_host_prog = substitute(system('pipenv --py'), '\n\+$', '', '')
        endif
    endif
augroup END

" ================================================
" Final Touches
" ================================================

" Load all packages and generate help tags silently
packloadall
silent! helptags ALL 
