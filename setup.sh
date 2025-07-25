#!/bin/bash

function install_node() {
    # installs nvm (Node Version Manager)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    # download and install Node.js (you may need to restart the terminal)
    nvm install 20
    # verifies the right Node.js version is in the environment
    node -v # should print `v20.18.0`
    # verifies the right npm version is in the environment
    npm -v # should print `10.8.2`
}

function install_neovim() {
    wget --output-document="${CUSTOM_CONFIG_ROOT}/nvim-linux64.tar.gz" https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
    pwd
    tar xzvf "${CUSTOM_CONFIG_ROOT}/nvim-linux64.tar.gz"
}

mkdir -p "$CUSTOM_CONFIG_ROOT"
cd "$CUSTOM_CONFIG_ROOT"

# sudo apt install -y neofetch tree fzf git gcc g++ python3-full curl wget unzip file net-tools
# install_node

install_neovim

# mkdir -p ~/.config/nvim
# ln nvim-config/init.lua ~/.config/nvim/init.lua

# echo "$BASHRC_APPEND" >> ~/.bashrc_test