# navigation
alias ..='cd ..'
alias ...='cd ../..'

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# adding flags
alias df='df -h'               # human-readable sizes
alias free='free -m'           # show sizes in MB
alias grep='grep --color=auto' # colorize output (good for log files)
alias mv='mv -i'               # interactive don't override
alias cp='cp -L'

# package manager
os_name=$(cat /etc/os-release | grep -E "^ID=" | cut -d"=" -f2)
if [[ "${os_name}" = "arch" ]]; then
    alias i='sudo pacman -S'
    alias s='sudo pacman -Ss'
    alias r='sudo pacman -Runs'
    alias uall='sudo pacman -Syu --noconfirm'
    # remove orphaned
    # sudo pacman -Rs $(pacman -Qdtq)
elif [[ "${os_name}" = "debian" ]]; then
    alias i='sudo apt install -y'
    alias s='sudo apt search'
    alias r='sudo apt purge -y'
    alias uall='sudo apt update; sudo apt upgrade -y'
    # remove orphaned
    # sudo apt autoremove
fi