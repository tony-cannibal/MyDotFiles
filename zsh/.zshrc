#!/bin/sh


autoload -U colors && colors	# Load colors

setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

source $ZDOTDIR/zsh_functions.sh
unsetopt PROMPT_SP


zsh_add_file vim-mode.sh
zsh_add_file aliases.sh

# Keyamps
bindkey -s '^o' 'lfcd\n'


# source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

zsh_add_plugin zsh-autosuggestions
eval "$(starship init zsh)"

zsh_add_plugin zsh-syntax-highlighting

