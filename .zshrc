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

alias ls="ls --color=auto"
alias deck="gamescope -e -- steam -steamdeck -steamos3"
alias tvdeck="gamescope -e -w 3840 -h 2160 -W 3840 -H 2160 -- steam -steamdeck -steamos3"
alias hdrdeck="gamescope -e -w 2560 -h 1440 -W 2560 -H 1440 --hdr-enabled -- steam -steamdeck -steamos3"
alias nixos="qemu-system-x86_64 -accel kvm -smp 6 -m 8G -drive format=raw,file=/hdd1/OS/nixDrive,if=virtio"
alias fedora="qemu-system-x86_64 -accel kvm -smp 6 -m 8G -drive format=raw,file=/hdd1/OS/fedora,if=virtio"
alias icat="kitten icat"
alias zen="~/zen/zen"
alias time="/usr/bin/time"
alias volume="pactl set-sink-volume alsa_output.usb-Logitech_PRO_000000000000-00.analog-stereo"
alias vlc="org.videolan.VLC"
alias niri="niri-session"

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit


