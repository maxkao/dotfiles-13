#!/usr/bin/env bash

[[ $- != *i* ]] && return

# PROMPT
. ~/.config/git/git-prompt.sh
NO_COLOR="\[\e[m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
njobs() { n=$(jobs | wc -l) && [ "$n" -gt 0 ] && echo " $n"; }
PS1="${GREEN}[\W\$(__git_ps1 ' %s')${RED}\$(njobs)${GREEN}] ${NO_COLOR}"

# SETTINGS
set -o vi
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend

# SOURCE
completion=/usr/share/bash-completion/bash_completion
[ -r $completion ] && . $completion

# DEFAULTS
alias cp='cp -ir'
alias df="df -h"
alias du="du -h"
alias grep="grep --color"
alias ls="ls --color --group-directories-first -Ah -I __pycache__"
alias lsblk="lsblk -o name,label,mountpoint,fstype,size"
alias mkdir="mkdir -p"
alias mount="sudo mount"
alias mv="mv -i"
alias pacman="sudo pacman"
alias rm="rm -fr"
alias tmux="tmux -f \$TMUXRC"
alias tree="tree -aCI '__pycache__|.git|*.aux|*.fdb_latexmk|*.fls|*.log|*.nav|*.snm|*.gz|*.toc' --dirsfirst --noreport"
alias umount="sudo umount"

# CPM
alias x="cpm"
alias xc="cpm -c"
alias xd="cpm -d"
alias xm="cpm -m"
alias xp="cpm -p"

# DOTFILES
alias ba="\$EDITOR ~/projects/dotfiles/dotfiles/.bashrc && . ~/projects/dotfiles/dotfiles/.bashrc"
alias fd="cd ~/projects/dotfiles"
alias fdf="cd ~/projects/dotfiles && f"
alias fx="\$EDITOR ~/projects/dotfiles/dotfiles/sx/sxrc"
alias iv="\$EDITOR ~/projects/dotfiles/dotfiles/nvim/init.vim"
alias tm="\$EDITOR ~/projects/dotfiles/dotfiles/tmux.conf"

# DROPBOX
alias db="cd ~/Dropbox"
alias g="cd ~/Dropbox/uni/rdm/report"
alias n="\$EDITOR ~/Dropbox/misc/notes"
alias nn="cd ~/Dropbox/misc"
alias vm="cd ~/Dropbox/uni/vml/summary"

# FUNCTIONS
cd() { if [ $# = 0 ]; then builtin cd && ls; else builtin cd "$@" && ls; fi }
d() { if [ $# = 0 ]; then exit; else rm "$@"; fi }
dirs() { find . -type d ! -path '*/\.git/*' ! -iname '.git' ! -path '*/__pycache__' ! -iname '.' | sed 's/^.\///'; }
f() { if [ -d "$1" ]; then cd "$1" || return; else open "$@"; fi; }
flash() { sudo dd bs=4M if="$1" of="$2" status=progress oflag=sync; }
l() { if [ $# = 0 ]; then ls; elif [ -d "$1" ]; then ls "$1"; elif [ -r "$1" ]; then cat "$1"; fi; }
mc() { mkdir "$1" && cd "$1" || return; }
y() { youtube-dl "$@" "$(xsel -b | head -n1)"; }

# GIT
k() { n=16; [ "$1" ] && n=$1; git log --all --graph --decorate --oneline -n"$n"; }
kcl() { git clone "$@" "$(xsel -b | head -n1)"; }
kg() { git log --color --oneline --grep "$1" | fzf --ansi --no-sort | cut -d\  -f1 | xsel -b; }
krb() { n=8; [ "$1" ] && n=$1; git rebase -i HEAD~"$n"; }
krh() { n=1; [ "$1" ] && n=$1; git reset --hard HEAD~"$n"; }

alias ka="git add"
alias kaa="git add --all"
alias kam="git commit --amend"
alias kb="git branch"
alias kbd="git branch -D"
alias kbr="git remote -v | grep -P \(push\) | cut -d ' ' -f 1 | cut -f 2 | xargs -r \$BROWSER"
alias kfp="git format-patch --stdout HEAD^ >"
alias ki="git init"
alias kii="git add --all && git commit -m 'Create repository'"
alias kr="cd \$(git rev-parse --show-toplevel)"

alias kc="git commit"
alias kca="git add --all && git commit"
alias kcp="git add --all && git commit && git push"
alias kcr="git commit -am tmp && git rebase -i HEAD~2"

alias kd="clear; git diff"
alias kk="git log --all --graph --decorate --oneline"
alias kl="git log --date=auto:human"
alias klg="git log --grep"
alias ks="git status -bs"
alias kso="clear; git show"

alias ko="git checkout"
alias kob="git checkout -b"
alias kom="git checkout master"

alias kf="git fetch"
alias km="git merge"
alias kp="git push"
alias kpf="git push -f"
alias kpl="git pull"

alias krm="git rebase master"
alias krr="git reset --hard; git clean -f"
alias krs="git reset --soft"
alias krv="git revert"

alias ksd="git stash drop"
alias ksl="git stash list"
alias ksp="git stash pop"
alias kst="git stash"

# HOME
alias -- ,="cd .."
alias b="cd - >/dev/null && ls"
alias ca="cd ~/.cache"
alias co="cd ~/.config"
alias dl="cd ~/Downloads"
alias fl="cd ~/.local/share"
alias h="cd && clear"

# MEDIA
alias am="cd ~/media/asmr"
alias me="cd ~/media"
alias ms="cd ~/media/music"
alias vi="cd ~/media/videos"

# MISC
alias a="execute"
alias as="echo Remapped to do nothing."
alias c="clear"
alias cl="sudo pacman -Rns \$(pacman -Qttdq); sudo pacman -Sc; rm ~/.cache/*; sudo rm -fr /var/log/journal/*"
alias ff="builtin cd \$(dirs | fzf) && ls || echo Can not open directory."
alias i="pkg -i"
alias ig="iwctl station wlan0 get-networks"
alias is="iwctl station wlan0 scan"
alias j="fg"
alias lb="lsblk"
alias ll="ls -l"
alias m="mv"
alias md="mkdir -p"
alias o="autopen"
alias p="cp"
alias pa="patch -p1 <"
alias pw="pwd | sed 's/\/home\/aleks/~/'"
alias r="pkg -r"
alias re="sudo \$(fc -ln -1)"
alias s="bstatus"
alias sf="\$EDITOR /tmp/scratch"
alias to="touch"
alias u="sudo sh -c \"curl -s 'https://www.archlinux.org/mirrorlist/?country=DE&protocol=https&use_mirror_status=on' | sed -e s/^#Server/Server/ -e /^#/d > /etc/pacman.d/mirrorlist\" && yay"
alias vol="alsamixer"

# TREE
alias td="tree -d"
alias tdf="tree -d \$(dirs | fzf)"
alias tf="tree"
alias tff="tree \$(dirs | fzf)"

# PROJECTS
alias aa="cd ~/projects/arch"
alias ad="cd ~/projects/arch && \$EDITOR desktop.sh"
alias fj="cd ~/projects"
alias sc="cd ~/projects/scripts"
alias scf="cd ~/projects/scripts && f"

# TMUX
alias ta="tmux a -t"
alias tk="tmux kill-session -t"
alias tl="tmux ls"
t() { s=0; if [ $# -gt 0 ]; then s="$1"; fi; tmux new -As "$s"; }

# HISTORY
aliases() { alias | cut -d' ' -f2 | cut -d= -f1 | awk 'length<3' | tr '\n' :; }
functions() { declare -F | cut -d' ' -f3 | awk 'length<3' | tr '\n' :; }
HISTIGNORE=$(aliases)$(functions)
HISTCONTROL=ignoreboth:erasedups
HISTFILE=~/.local/share/bash_history
