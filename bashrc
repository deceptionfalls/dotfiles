export TERM="st-256color"
export EDITOR="nvim"
export HISTCONTROL=ignoredups:erasedups

[[ $- != *i* ]] && return

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ;
  then PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

# Prompt that abbreviates directory names like in the fish shell.
PROMPT_COMMAND='PS1X=$(perl -p -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD})'
PS1='\[\e[91;1m\]${PS1X}\n\[\e[91;1m\]♥ \[\e[0m\]'

set -o vi

shopt -s cmdhist
shopt -s dotglob
shopt -s histappend
shopt -s expand_aliases

bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind "set completion-ignore-case on"

# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

alias rel="xrdb merge ~/.Xresources && kill -USR1 $(pidof st)"

alias cd='z'
alias ..='z ..'

alias vim='nvim'

alias s='yay -S'
alias r='sudo pacman -R'
alias pacsyu='sudo pacman -Syu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

alias ls='exa -l --color=always --group-directories-first'
alias la='exa -la --color=always --group-directories-first'

alias add='git add '
alias addup='git add -u'
alias addall='git add .'
alias clone='git clone'
alias commit='git commit -m'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'

alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias df='df -h'
alias font='fc-cache -fv'

alias awm='aawmtt -s 1200x600 -c ~/.config/awesome/rc.lua'

eval "$(zoxide init bash)"
