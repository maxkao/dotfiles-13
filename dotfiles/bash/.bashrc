#!/usr/bin/env bash

[[ $- != *i* ]] && return

# Prompt
. ~/.config/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
num_jobs() {
	NUM_JOBS=$(jobs | wc -l)
	[[ "$NUM_JOBS" -gt 0 ]] && echo " $NUM_JOBS"
}
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')${RED}\$(num_jobs)${GREEN}] ${NO_COLOR}"

# Settings
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=",:-:a:aa:ac:ad:adb:ado:adm:adw:al:ai:ap:asc:ast:aw:aab:aad:ab:abp:an:av:ax:bd:d:cal:f:i:ii:l:ll:lb:ma:mai:ml:sd:x:xc:xm:xp:y:gaa:gd:gs:gca:g:gg:gl:gps:gpsf:gpl:gcn:grh:grr"
set -o noclobber vi
shopt -s autocd cdspell checkwinsize histappend

# Defaults
alias cal='cal -m'
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -Ah"
alias lsblk="lsblk -o name,fstype,label,size,mountpoint"
alias mkdir="mkdir -p"
alias mv="mv -i"
alias mount="sudo mount"
alias umount="sudo umount"
alias pacman="sudo pacman"
alias rm="rm -fr"
alias top="top -1 -u \$USER"
alias zip="zip -r"

# Shortcuts
alias bd="b -d"
alias f="fg"
alias i="iwctl"
alias ii="networkctl"
alias l="ls"
alias ll="ls -l"
alias lb="lsblk"
alias m="mv"
alias ma="make; make clean"
alias mai="sudo make install clean"
alias md="mkdir"
alias ml="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist; cat /etc/pacman.d/mirrorlist"
alias p="cp"
alias py="python"
alias sa="source activate"
alias sd="conda deactivate"
alias t="touch"
alias xc="x -c"
alias xm="x -m"
alias xp="x -p"
alias y='yay'
d() { if [ "$#" == 0 ]; then clear; else rm "$@"; fi }

a() {
	if [ "$#" == 0 ]; then
		cd && clear
	elif [ -d "$1" ]; then
		cd "$@" && ls
	elif [ "$#" == 1 ] && [ -f "$1" ]; then
		xdg-open "$@"
	else
		nvim "$@"
	fi
}

# Directories
alias -- ,="a .."
alias -- -="a -"
alias aa="a ~/Projects/arch/"
alias aas="a ~/Dropbox/ISY/S4/ASE/"
alias adb="a ~/Dropbox/"
alias ado="a ~/Downloads/"
alias ac="a ~/.config/"
alias ad="a \$DOTFILES"
alias adm="a ~/Projects/dmenu/"
alias adw="a ~/Projects/dwm/"
alias al="a ~/.local/"
alias ai="a ~/Dropbox/ISY/"
alias am="a ~/Dropbox/ISY/S3/MYO/"
alias ap="a ~/Projects/"
alias asc="a ~/Projects/scripts/scripts/"
alias ast="a ~/Projects/st/"
alias aw="a ~/Dropbox/Pictures/Wallpapers/"

# Files
alias aab="\$EDITOR ~/Projects/arch/arch_base.sh"
alias aad="\$EDITOR ~/Projects/arch/arch_desktop.sh"
alias ab="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias abp="\$EDITOR \$DOTFILES/bash/.bash_profile"
alias an="\$EDITOR ~/Dropbox/Notes/notes"
alias av="\$EDITOR \$DOTFILES/nvim/init.vim"
alias ax="\$EDITOR \$DOTFILES/xorg/.xinitrc"

# Git
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbd="git branch -D"

alias gcl="git clone"
alias gd="git diff"
alias gs="git status -s"

alias gca="git commit -a"
alias gcam="git commit -am"
alias gcm="git commit -m"
gc() { git add --all; git commit -m "$1" && git push; }

alias g="git log --all --graph --decorate --oneline -n16"
alias gg="git log --all --graph --decorate --oneline"
alias gl="git log --date=auto:human"

alias go-="git checkout --"
alias go="git checkout"
alias gob="git checkout -b"

alias gps="git push"
alias gpsf="git push -f"
alias gpl="git pull"

alias gcn="git clean -f"
alias grh="git reset --hard"
alias grs="git reset --soft"
alias grr="git reset --hard; git clean -f"

##### AMiRo ENVIRONMENT CONFIGURATION #####
# DO NOT EDIT THESE LINES MANUALLY!
export PATH=$PATH:/home/aleks/Dropbox/ISY/S4/ASE/gcc-arm-embedded
##### AMiRo ENVIRONMENT CONFIGURATION #####

