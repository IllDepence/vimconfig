# Vim Configuration

This repository contains my personal Vim and Neovim configurations for Debian 12. It includes a Makefile to easily manage the configuration files.

## Directory Structure

- `config/` - Directory containing all configuration files
  - `vimrc` - Vim configuration file
  - `nvim/` - Neovim configuration directory

## Usage

The following make targets are available:

- `make setup` - Copy your current Vim/Neovim configurations from your home directory to this repo
- `make install` - Install the configurations from this repo to your home directory (requires confirmation)
- `make clean` - Reset the configuration directory to the last git commit

### Setup

To backup your current configurations to this repo:

```bash
make setup
```

### Installation

To install the configurations from this repo to your system:

```bash
make install
```

This will prompt for confirmation before overwriting your existing configurations.

### Clean

To reset the configuration directory to the last git commit:

```bash
make clean
```

## Note

Make sure to commit your changes after running `make setup` to ensure `make clean` works as expected. 