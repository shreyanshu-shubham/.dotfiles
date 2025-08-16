# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# node install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# shreyanshu
export PATH="/home/shreyanshu/shreyanshu/nvim-linux64/bin:${PATH}"

alias aptall='figlet update;sudo apt update;figlet upgrade;sudo apt upgrade -y;figlet autoremove;sudo apt autoremove -y'
alias ll='ls -la'
alias clip='clip.exe'
#alias docker='docker.exe'
alias gitstorecreds='git config --global credential.helper store'
[ -f /mnt/c/minikube/minikube.exe ] && alias minikube='minikube.exe'
[ -f /mnt/c/minikube/minikube.exe ] && alias kubectl='minikube.exe kubectl'
# alias time='TZ=$(awk '/^Z/ { print $2 }; /^L/ { print $3 }' /usr/share/zoneinfo/tzdata.zi | fzf) date'
# add check to see if python exist before adding alias
alias py='python3'
alias k='kubectl'
alias dokcer='docker'
alias cls='clear'

#neofetch

# enable ssh-agent and add keys
eval $(ssh-agent)
# cat ~/.ssh/ps/gcp | clip.exe
# ssh-add ~/.ssh/keys/anoop-gcpkey
# ssh-add ~/.ssh/keys/id_rsa_openstack2

export SCREENDIR=$HOME/.screen
alias top='btop'

if [ "$color_prompt" = yes ]; then
    # PS1="\n┌──\[$(tput setaf 2)\][\u@\h]\[$(tput sgr0)\]-\[$(tput setaf 1)\][\j]\[$(tput sgr0)\]-\[$(tput setaf 12)\][\w]\[$(tput sgr0)\]-\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/')\n└$ "
    PS1="\[$(tput setaf 2)\][\u@\h]\[$(tput sgr0)\]-\[$(tput setaf 1)\][\j]\[$(tput sgr0)\]-\[$(tput setaf 12)\][\w]\[$(tput sgr0)\]-\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/')\n$ "
else
    # PS1="\n┌──[\u@\h]-[\j]-[\w]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/-[\1]/')\n└$ "
    PS1="[\u@\h]-[\j]-[\w]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/-[\1]/')\n$ "
fi
unset color_prompt force_color_prompt

### FZF ###
# Enables the following keybindings:
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd
eval "$(fzf --bash)"

# function ex {
#  if [ -z "$1" ]; then
#     # display usage if no parameters given
#     echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
#     echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
#  else
#     for n in "$@"
#     do
#       if [ -f "$n" ] ; then
#           case "${n%,}" in
#             *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
#                          tar xvf "$n"       ;;
#             *.lzma)      unlzma ./"$n"      ;;
#             *.bz2)       bunzip2 ./"$n"     ;;
#             *.cbr|*.rar)       unrar x -ad ./"$n" ;;
#             *.gz)        gunzip ./"$n"      ;;
#             *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
#             *.z)         uncompress ./"$n"  ;;
#             *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
#                          7z x ./"$n"        ;;
#             *.xz)        unxz ./"$n"        ;;
#             *.exe)       cabextract ./"$n"  ;;
#             *.cpio)      cpio -id < ./"$n"  ;;
#             *.cba|*.ace)      unace x ./"$n"      ;;
#             *)
#                          echo "ex: '$n' - unknown archive method"
#                          return 1
#                          ;;
#           esac
#       else
#           echo "'$n' - file does not exist"
#           return 1
#       fi
#     done
# fi
# }


clear;fastfetch

