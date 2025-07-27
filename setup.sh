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

function install_custom_postgres_version(){
    # Import the repository signing key:
    sudo apt install curl ca-certificates
    sudo install -d /usr/share/postgresql-common/pgdg
    sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

    # Create the repository configuration file:
    . /etc/os-release
    sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"

    # Update the package lists:
    sudo apt update
}

mkdir -p "$CUSTOM_CONFIG_ROOT"
cd "$CUSTOM_CONFIG_ROOT"

# sudo apt install -y neofetch tree fzf git gcc g++ python3-full curl wget unzip file net-tools
# install_node

install_neovim

# mkdir -p ~/.config/nvim
# ln nvim-config/init.lua ~/.config/nvim/init.lua

# echo "$BASHRC_APPEND" >> ~/.bashrc_test

# install from apt
packages_to_install=("tldr" "wget" "git" "curl" "gcc" "g++" "make" "cmake")

sudo apt -qq update
for itm in "${packages_to_install[@]}"; do
	echo "Installing ${itm}"
	sudo apt install -qq -y ${itm}
done

tldr -u

# TODO git config 
