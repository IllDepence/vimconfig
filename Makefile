# Vim configuration management Makefile

# Directories
CONFIG_DIR := config
VIM_CONFIG := $(CONFIG_DIR)/vimrc
NVIM_CONFIG_DIR := $(CONFIG_DIR)/nvim

# Source paths
SRC_VIMRC := $(HOME)/.vimrc
SRC_NVIM_CONFIG := $(HOME)/.config/nvim

.PHONY: load install clean

# Create necessary directories
$(CONFIG_DIR):
	@echo "Creating configuration directories..."
	@mkdir -p $(CONFIG_DIR)
	@mkdir -p $(NVIM_CONFIG_DIR)
	@echo "Directory structure created."

# Copy configurations from home directory to repo
load: $(CONFIG_DIR)
	@echo "Starting configuration backup..."
	@if [ -f $(SRC_VIMRC) ]; then \
		echo "Copying Vim configuration from $(SRC_VIMRC)..."; \
		cp $(SRC_VIMRC) $(VIM_CONFIG); \
		echo "✓ Vim configuration copied successfully."; \
	else \
		echo "⚠ No .vimrc found in home directory, skipping..."; \
	fi
	@if [ -d $(SRC_NVIM_CONFIG) ]; then \
		echo "Copying Neovim configuration from $(SRC_NVIM_CONFIG)..."; \
		cp -r $(SRC_NVIM_CONFIG)/* $(NVIM_CONFIG_DIR)/; \
		echo "✓ Neovim configuration copied successfully."; \
	else \
		echo "⚠ No Neovim configuration directory found, skipping..."; \
	fi
	@echo "Backup complete! Don't forget to commit your changes."

# Install configurations to home directory
install:
	@echo "This will overwrite your existing Vim/Neovim configurations."
	@read -p "Are you sure you want to continue? [y/N] " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		mkdir -p $(dir $(SRC_VIMRC)); \
		mkdir -p $(SRC_NVIM_CONFIG); \
		cp $(VIM_CONFIG) $(SRC_VIMRC); \
		cp -r $(NVIM_CONFIG_DIR)/* $(SRC_NVIM_CONFIG)/; \
		echo "Configuration files installed successfully."; \
	else \
		echo "Installation cancelled."; \
	fi

# Reset configuration directory to last git commit
clean:
	git checkout -- $(CONFIG_DIR)
	@echo "Configuration directory reset to last commit." 