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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
# force_color_prompt=yes

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

OS_ICON=""

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;31m\]\W\[\033[00m\]\$ '
    # PS1="\n \[\033[0;34m\]┌─────(\[\033[1;35m\]\u\[\033[0;34m\])─────(\[\033[1;32m\]\w\[\033[0;34m\]) \n └> \[\033[1;36m\]\$ \[\033[0m\]"
    PS1="\n \[\033[0;34m\]╭─────\[\033[0;31m\]\[\033[0;30m\]\[\033[41m\] $OS_ICON \u \[\033[0m\]\[\033[0;31m\]\[\033[0;34m\]─────\[\033[0;32m\]\[\033[0;30m\]\[\033[42m\] \w \[\033[0m\]\[\033[0;32m\] \n \[\033[0;34m\]╰ \[\033[1;36m\]\$ \[\033[0m\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        if [ "$color_prompt" = yes ]; then
            PS1="\n \[\033[0;34m\]╭─────\[\033[0;31m\]\[\033[0;30m\]\[\033[41m\] $OS_ICON \u \[\033[0m\]\[\033[0;31m\]\[\033[0;34m\]─────\[\033[0;32m\]\[\033[0;30m\]\[\033[42m\] \w \[\033[0m\]\[\033[0;32m\] \n \[\033[0;34m\]╰ \[\033[1;36m\]\$ \[\033[0m\]"
        else
            PS1='\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1'
        fi
        ;;
    *)
        ;;
esac
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

export DISPLAY=:0

export PATH="/home/jareth/.local/bin":"/usr/local/sbin":"/usr/local/bin":"/usr/sbin":"/usr/bin":"/sbin":"/bin":"/usr/games":"/usr/local/games":"/snap/bin":"/home/jareth/bin"

# Extra WSL paths if this config is being run on WSL
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    export PATH="/mnt/c/Program Files (x86)/VMware/VMware Player/bin/":"/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath":"/Program Files (x86)/Common Files/Intel/Shared Libraries/redist/intel64/compiler":"/mnt/c/WINDOWS/system32":"/mnt/c/WINDOWS":"/mnt/c/WINDOWS/System32/Wbem":"/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/":"/mnt/c/WINDOWS/System32/OpenSSH/":"/mnt/c/Program Files/dotnet/":"/mnt/c/Program Files/Calibre2/":"/mnt/c/MinGW/bin":"/mnt/c/Windows/Microsoft.NET/Framework/v4.0.30319":"/mnt/c/Program Files/PuTTY/":"/mnt/c/platform-tools":"/mnt/c/Program Files (x86)/Intel/Intel(R) Management Engine Components/DAL":"/mnt/c/Program Files/Intel/Intel(R) Management Engine Components/DAL":"/mnt/c/HashiCorp/Vagrant/bin":"/mnt/c/Users/Jareth/AppData/Local/Microsoft/WindowsApps":"/mnt/c/Users/Jareth/AppData/Local/Programs/Microsoft VS Code/bin":"/mnt/c/Users/Jareth/AppData/Local/atom/bin":"/mnt/c/Users/Jareth/AppData/Local/Microsoft/WindowsApps":"/mnt/c/Users/Jareth/AppData/Local/atom/bin":"/mnt/c/Users/Jareth/WebDrivers/chromedriver.exe":"/mnt/c/Users/Jareth/Tools/":$PATH
fi
export GPG_TTY=$(tty)

# nvim
export PATH=$HOME/neovim/bin:$PATH

# Go stuff
export GOPATH=$HOME/go
export PATH="/usr/local/go/bin":$GOROOT/bin:$GOPATH/bin:$PATH

# EMSDK/Emscripten stuff
source "/home/jareth/emsdk/emsdk_env.sh" &> /dev/null && echo "Emscripten loaded successfully"

# Rust stuff
. "$HOME/.cargo/env"

# Node/NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Platformio stuff
export PATH=/home/jareth/.platformio/penv/bin:$PATH

# Python/pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Java stuff
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# WARNING: change this to your JDK folder if you did not follow the above
#steps to install JDK 8
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export PATH=$JAVA_HOME/bin:$PATH
# Android sdk related
export ANDROID_SDK_ROOT="$HOME/android-sdk-linux"
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$PATH

# Qt Stuff
export Qt_DIR=~/Qt/
