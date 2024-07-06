# .bashrc -- this is the shell configuration for the Docker environment
# This is mainly derived from Ubuntu's defaults, but with some extras to make
# life easier
#
# Author: Maddy Guthridge

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# Header message for new terminals
echo " --- COMP2521 Docker environment --- "


_load_cse_env() {
    # Load their zID
    export ZID=$(cat "$HOME/.zid")

    # This is the URL for logging into CSE over SSH
    export CSE="${ZID}@login.cse.unsw.edu.au"
}
_load_cse_env


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
force_color_prompt=yes

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
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and various grep commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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

# Aliases and helpful functions
###############################################################################

# ls aliases, for listing all contents of directory
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Quick command to quit the terminal
alias q="exit 0"
# And to clear the console
alias c="clear"
alias cls="clear"

# Mkdir and cd into it
mkcdir ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# cd then ls
cdl ()
{
    cd -P -- "$1" &&
    ls
}

# Echo to stderr
echoerr() { echo "$@" 1>&2; }

# Connecting to CSE systems
###############################################################################

# Set up ssh-agent
eval $(ssh-agent) 2> /dev/null

# SSH into CSE systems
cse() {
    ssh $CSE
}

# Grab starter code from CSE. This will unzip it into a directory named
# 'starter_code'
cse-fetch () {
    # Check if we're within the $HOME directory. Changes outside of that dir
    # will be lost
    if test "${PWD##/home/me}" = "${PWD}"; then
        echoerr "You are not in your home directory, meaning your data may"
        echoerr "be lost when you shut down the environment."
        echoerr "Please cd to a directory within '$HOME' to avoid losing data."
        return 1
    fi


    if [ -d "./starter_code" ]; then
        echoerr "A directory named 'starter_code' already exists!"
        echoerr "Please rename it to avoid losing work."
        echoerr "Try: 'mv starter_code [new folder name]'"
        return 1
    fi

    # Download from CSE
    rsync "$CSE":"$1" ".temp.zip" &&
    # Unzip
    unzip ".temp.zip" -d "starter_code" &&
    # Remove the zip file
    rm ".temp.zip"
}

# Upload the current directory to a directory within `2521-push` in the
# student's CSE account
cse-push () {
    cwd=$(pwd)

    # We should only push directories within the user's $HOME
    # https://stackoverflow.com/a/68919129/6335363
    if ! find "$HOME" -samefile "$cwd" -printf 'Y\n' -quit | grep -qF Y; then
        echoerr "The directory '$cwd' is not part of your home "
        echoerr "directory, so it cannot be uploaded to CSE."
        echoerr "Make sure you've cd'd into the right location."
        return 1
    fi

    # File relatively to $HOME/work directory
    # https://stackoverflow.com/a/62684116/6335363
    out_dir="/home/${ZID}/2521-push${cwd#"$HOME"}"

    # Check files don't already exist on CSE end
    # https://stackoverflow.com/a/29639982/6335363
    if ssh $CSE "test -e ${out_dir}"; then
        # your file exists
        echoerr "The directory '${out_dir}' already exists on CSE."
        echoerr -n "Replace it? [y/N] "
        if [[ "$(read -e; echo $REPLY)" == [Yy]* ]]; then
            echoerr "Continuing..."
        else
            return 1
        fi
    fi

    echo "Uploading...: 'LOCAL:$cwd' -> 'CSE:$out_dir'"

    # mkdir to the required location
    ssh $CSE "mkdir -p $out_dir"

    # rsync it across
    rsync -arP $cwd/ "$CSE:$out_dir"
}
