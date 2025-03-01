# (n)vim config

## makefile targets

* `make load` - copy vim/neovim config from your home directory to this repo
* `make install` - copy the config to home directory
* `make clean` - reset config in repo to last commit

## external setup

### System packages

* Install ripgrep, fd (needed for telescope plugin)
  ```bash
  sudo apt install ripgrep fd-find
  ```

### Python

* Install neovim support, LSP server & code formatter
  ```bash
  sudo apt install python3-pynvim
  pipx install pyright black
  ```

###  Typescript

* Set up directory for global packages
  ```bash
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
  ```

* Install LSP server & code formatter
  ```bash
  npm install -g prettier typescript typescript-language-server
  ```

## Keybindings

* See [keybindings.md](keybindings.md)