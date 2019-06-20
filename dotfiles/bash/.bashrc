#!/usr/bin/env bash

[[ $- != *i* ]] && return

# PROMPT
. ~/.config/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
num_jobs() { NUM_JOBS=$(jobs | wc -l) && [[ "$NUM_JOBS" -gt 0 ]] && echo " $NUM_JOBS"; }
PS1="${GREEN}[\W\$(__git_ps1 ' (%s)')${RED}\$(num_jobs)${GREEN}] ${NO_COLOR}"

# SETTINGS
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="df:poweroff:reboot"
HISTIGNORE+=":c:d:dl:e:f:i:l:lb:ll:ma:ml:py:sd:sl:sp:sr:t:ta:tl:x:xc:xm:xp:y"
HISTIGNORE+=":,:-:a:aa:ac:ad:ao:ai:al:am:ap:asc:ase:ax"
HISTIGNORE+=":gaa:gs:gc:gca:g:gg:gl:go-:gcn"
set -o vi
shopt -s autocd cdspell checkwinsize histappend

# FZF
export FZF_DEFAULT_COMMAND="find . -type f ! -path '*/\.git/*' ! -path '*/tex/*' ! -iname 'tags' ! -iname '*\.jpg' ! -iname '*\.jpeg' ! -iname '*\.png' ! -iname '*\.pdf' ! -iname '*\.gif' ! -iname '*\.css' ! -iname '*\.html' ! -iname '*\.js' ! -iname '*\.htm' ! -iname '*\.docx' ! -iname '*\.doc' ! -iname '*\.odt' ! -iname '*\.zip' ! -iname '*\.tar.gz' | sed 's/^.\///'"
export FZF_DEFAULT_OPTS="--ansi --border --cycle -m --reverse --tabstop=4 --color=gutter:#2F343F,bg+:#2F343F"

# TMUX
# Use one nvim-adress per tmux-window and export EDITOR as nvr.
# This enables to open files in the same nvim-instance from any
# tmux-pane in the same tmux-window.
# if [ -n "$TMUX" ]; then
# 	NVIM_LISTEN_ADDRESS=/tmp/nvim_$USER_$(tmux display -p "#{window_id}")
# 	export NVIM_LISTEN_ADDRESS
# 	export EDITOR="nvr -s"
# fi

# MISC-EXPORTS
export PATH=$PATH:~/Projects/ase/gcc-arm-embedded
export PATH=~/.yarn/bin:~/.config/yarn/global/node_modules/.bin:$PATH
[ -f /opt/ros/melodic/setup.bash ] && . /opt/ros/melodic/setup.bash

# DEFAULTS
alias cal="cal -m"
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -Ah"
alias lsblk="lsblk -o name,label,mountpoint,fstype,size"
alias mkdir="mkdir -p"
alias mv="mv -i"
alias pacman="sudo pacman"
alias shfmt="shfmt -ci -sr -p -s"
alias rm="rm -fr"
alias top="top -1 -u \$USER"

# SHORTCUTS
d() { if [ "$#" == 0 ]; then clear; else rm "$@"; fi; }
di() { $BROWSER https://www.dict.cc/?s="$1"; }
alias c="cat"
alias da="cd; clear"
alias dl="clear; ls"
alias e="exit"
alias f="fg"
alias ff="fzf-tmux | xargs -r \$EDITOR"
alias i="tstatus"
alias l="ls"
alias lb="lsblk"
alias ll="ls -l"
alias m="mv"
alias ma="make; make clean"
alias maf="make && make flash && (gtkterm -c AMiRo &)"
alias mai="sudo make install clean"
alias md="mkdir"
alias p="cp"
alias pa="patch -p1 <"
alias pd="yay -Qetq | fzf -m --preview 'yay -Qi {1}' > /tmp/pd; xargs -ra /tmp/pd yay -Rns"
alias pi="yay -Slq | fzf -m --preview 'yay -Si {1}' > /tmp/pi; xargs -ra /tmp/pi yay -S"
alias py="python"
alias r="sudo \$(fc -ln -1)"
alias s="sudo"
alias to="touch"
alias u="yay"
alias uu="sudo reflector -p https -l32 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && yay"

# TMUX
alias t="tmux a -t 0 || tmux new -c ~ -s 0"
alias ta="tmux a -t"
alias tl="tmux ls"
alias tn="tmux new -s"

# X
alias xc="x -c; x"
alias xm="x -m"
alias xp="x -p"

# POWER-MANAGEMENT
alias sd="systemctl suspend"
alias sl="slock"
alias sp="poweroff"
alias sr="reboot"

cd() { if [ "$#" == 0 ]; then builtin cd || return; else builtin cd "$@" && ls; fi; }

# APERIRE. Similar to xdg-open but does what I actually want and is faster.
a() {
	[ "$#" == 0 ] && cd && ls && return
	[ -d "$1" ] && cd "$@" && return
	[ ! -f "$1" ] && [ ! -d "$1" ] && echo "$* doesn't exist." && return
	mimetype=$(file -bL --mime-type "$1")
	mime=$(echo "$mimetype" | cut -d/ -f1)
	case $mime in
		"text") $EDITOR "$@" && return ;;
		"image") $BROWSER "$@" && return ;;
		"video") $BROWSER "$@" && return ;;
		"audio") $BROWSER "$@" && return ;;
	esac
	case $mimetype in
		"application/json") $EDITOR "$@" ;;
		"inode/x-empty") $EDITOR "$@" ;;
		"application/pdf") $BROWSER "$@" ;;
		"application/x-gzip") tar -zxf "$@" ;;
		*) echo Mimetype "$mimetype" is not associated with any program. >&2 ;;
	esac
}

# BOOKMARKS (ar and as are already existing commands)
alias -- ,="cd -"
alias ac="cd ~/.config"
alias aca="cd ~/.cache"
alias af="\$EDITOR"
alias ao="cd ~/Downloads"
alias al="cd ~/.local/share"
alias asn="cd ~/.local/share/nvim/plugins/vim-snippets/UltiSnips"
alias at="\$EDITOR /tmp/scratch"
alias ros="cd ~/Projects/ase/catkin_ws && . devel/setup.sh"

alias add="cd ~/Dropbox"
alias au="cd ~/Dropbox/Uni"
alias am="cd ~/Dropbox/Uni/s3/MYO"
alias an="cd ~/Dropbox/Notes"
alias ani="\$EDITOR ~/Dropbox/Notes/ideas"
alias ann="\$EDITOR ~/Dropbox/Notes/notes"
alias anp="\$EDITOR ~/Dropbox/Notes/pms.md"
alias ase="cd ~/Dropbox/uni/s4/ASE"
alias aw="cd ~/Dropbox/Pictures/Wallpapers"

alias ap="cd ~/Projects"
alias aa="cd ~/Projects/arch"
alias asc="cd ~/Projects/scripts/scripts"
alias ast="cd ~/Projects/st"

alias asu="cd ~/Projects/suckless"
alias adm="cd ~/Projects/suckless/dmenu"
alias adw="cd ~/Projects/suckless/dwm"
alias asi="cd ~/Projects/suckless/sites"
alias ast="cd ~/Projects/suckless/st"

alias ad="cd \$DOTFILES"
alias ab="\$EDITOR \$DOTFILES/bash/.bashrc && . ~/.bashrc"
alias av="\$EDITOR \$DOTFILES/nvim/init.vim"
alias ax="\$EDITOR \$DOTFILES/.xinitrc"

# GIT
alias ga="git add"
alias gaa="git add --all"
alias gam="git commit --amend"
alias gb="git branch"
alias gbd="git branch -D"
alias gbr="git remote -v | grep -P \(push\) | cut -d ' ' -f 1 | cut -f 2 | xargs -r \$BROWSER"
alias gcl="git clone"
alias gfp="git format-patch --stdout HEAD^ >"
alias gs="git status -s"
alias gd="git diff"

alias gc="git commit"
alias gca="git add --all && git commit"
alias gcr="git commit -am tmp && git rebase -i HEAD~2"
alias gcp="git add --all && git commit && git push"

g() { n=8; [ "$#" != 0 ] && n=$1; git log --all --graph --decorate --oneline -n"$n"; }
alias gg="git log --all --graph --decorate --oneline"
alias ggg="git log --oneline --grep"
alias gl="git log --date=auto:human"
alias glg="git log --grep"
alias gso="git show"

alias go="git checkout"
alias gob="git checkout -b"
alias gom="git checkout master"

alias gf="git fetch"
alias gm="git merge"
alias gpl="git pull"
alias gps="git push"
alias gpsf="git push -f"

grh() { n=0; [ "$#" != 0 ] && n=$1; git reset --hard HEAD~"$n"; }
alias gcn="git clean -f"
alias grb="git rebase -i"
alias grr="git reset --hard; git clean -f"
alias grq="git rebase -i HEAD~2"
alias grs="git reset --soft"
alias grv="git revert"
