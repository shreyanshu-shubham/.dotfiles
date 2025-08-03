#!/bin/bash

###################################################################################################################
# UTIL FUNCTIONS
###################################################################################################################

function get_latest_tag_for_remote(){
    local remote_url=$1
    latest_tag=$(git ls-remote --tags --sort='v:refname' "${remote_url}" | grep -vE "\^\{\}$"  | tail -n1 |awk -F' ' '{print $NF}' | cut -d '/' -f3)
    printf "%s" "${latest_tag}"
}

function print_separator(){
    local separator_width=$1
    local separator_character=$2
    if [[ ${separator_width} -le 1 ]]; then
        return 1
    fi
    if [[ ${#separator_character} -ne 1 ]]; then
        return 1
    fi
    printf -v separator_string "%*s" "${separator_width}" ""
    echo "${separator_string}" | tr " " "${separator_character}"
}

function print_separator_with_string(){
    local separator_width=$1
    local separator_character=$2
    local string=$3
    if [[ ${separator_width} -le $(( ${#string} + 3 )) ]]; then
        return 1
    fi
    if [[ ${#separator_character} -ne 1 ]]; then
        return 1
    fi
    printf -v separator_string "%*s" $(( separator_width - ${#string} - 3 )) ""
    separator_string=$(echo -n "${separator_string}" | tr " " "${separator_character}" )
    echo "${separator_character} ${string} ${separator_string}"
}

function print_left_padded_string(){
    local pad_length=$1
    local pad_character=$2
    local string=$3
    printf -v pad_string "%*s" $(( pad_length - ${#string} )) ""
    pad_string=$(echo -n "${pad_string}" | tr " " "${pad_character}" )
    echo "${string}${pad_string}"
}

function print_right_padded_string(){
    local pad_length=$1
    local pad_character=$2
    local string=$3
    printf -v pad_string "%*s" $(( pad_length - ${#string} )) ""
    pad_string=$(echo -n "${pad_string}" | tr " " "${pad_character}" )
    echo "${pad_string}${string}"
}

###################################################################################################################
# INSTALL FUNCTIONS
###################################################################################################################

function install_node() {
    latest_tag=$(get_latest_tag_for_remote https://github.com/nvm-sh/nvm.git)

    # installs nvm (Node Version Manager)
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${latest_tag}/install.sh" | bash
    # download and install Node.js (you may need to restart the terminal)
    source ~/.bashrc
    nvm install 20
    # verifies the right Node.js version is in the environment
    node -v
    # verifies the right npm version is in the environment
    npm -v
}

function install_neovim() {
    latest_tag=$(get_latest_tag_for_remote https://github.com/neovim/neovim.git)
    git clone --branch "${latest_tag}" --single-branch https://github.com/neovim/neovim.git 
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd "${CUSTOM_CONFIG_SOURCE_ROOT}"
}

# function install_custom_postgres_version(){
#     # Import the repository signing key:
#     sudo apt install curl ca-certificates
#     sudo install -d /usr/share/postgresql-common/pgdg
#     sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

#     # Create the repository configuration file:
#     . /etc/os-release
#     sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"

#     # Update the package lists:
#     sudo apt update
# }

function install_fzf(){
    git clone --depth 1 https://github.com/junegunn/fzf.git
    bash fzf/install
    cd "${CUSTOM_CONFIG_SOURCE_ROOT}"
}

function install_fastfetch(){
    latest_tag=$(get_latest_tag_for_remote https://github.com/fastfetch-cli/fastfetch.git)
    git clone --branch "${latest_tag}" --single-branch https://github.com/fastfetch-cli/fastfetch.git 
    cd fastfetch
    mkdir -p build
    cd build
    cmake ..
    cmake --build . --target fastfetch
    cd "${CUSTOM_CONFIG_SOURCE_ROOT}"
}

# TODO : install and setup sudo for arch
# TODO : install and setup tmux

TERMINAL_COLUMNS=$(tput cols)
TERMINAL_ROWS=$(tput lines)
CUSTOM_CONFIG_SOURCE_ROOT="$(dirname "$(realpath "$0")")/source"
CUSTOM_CONFIG_STASH_ROOT="$(dirname "$(realpath "$0")")/stashed_files_$(date +%s)"

mkdir -p "${CUSTOM_CONFIG_STASH_ROOT}"
mkdir -p "${CUSTOM_CONFIG_SOURCE_ROOT}"
cd "${CUSTOM_CONFIG_SOURCE_ROOT}"

# install from apt
packages_to_install=("tldr" "wget" "git" "curl" "gcc" "g++" "make" "cmake" "curl" "unzip" "net-tools" "sudo" "pkgconfig")

# sudo apt -qq update
pacman -Syu --noconfirm # TODO make noconfirm a script flag
for itm in "${packages_to_install[@]}"; do
	echo "Installing ${itm}"
	# sudo apt install -qq -y "${itm}"
    pacman -S "${itm}"
done

install_node
install_neovim
install_fastfetch
install_fzf

# # mkdir -p ~/.config/nvim
# # ln -s nvim/init.lua ~/.config/nvim/init.lua

# # echo "$BASHRC_APPEND" >> ~/.bashrc_test


# tldr -u


# print_separator_with_string "2" '0' "hello"
