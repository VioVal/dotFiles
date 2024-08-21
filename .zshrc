HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '/home/ccs/.zshrc'

setopt autocd
unsetopt BEEP

PS1='%F{cyan}%~%f '

autoload -Uz compinit
compinit
