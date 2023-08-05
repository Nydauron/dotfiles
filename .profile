# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
    fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# checks to see if we are in a windows or linux dir
function isWinDir {
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        case $PWD/ in
            /mnt/*) return $(true);;
            *) return $(false);;
        esac
    fi
}
# wrap the git command to either run windows git or linux
# function git {
#   if isWinDir
#   then
#     git.exe "$@"
#   else
#     /usr/bin/git "$@"
#   fi
# }

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

. ~/.ssh-agent.sh
