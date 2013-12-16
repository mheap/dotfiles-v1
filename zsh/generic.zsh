# Make fn-backspace work on OSX
bindkey "^[[3~" delete-char
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

# Key timeout for vim mode
export KEYTIMEOUT=20

# Slowkeys no more!
command -v xkbset >/dev/null 2>&1 && { xkbset -sl; xkbset -a; }

# ZSH Syntax Highlighting?
source $ZSH/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# History searching
source $ZSH/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

if [ -e $HOME/.ssh/known_hosts ] ; then
    hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
    zstyle ':completion:*:hosts' hosts $hosts
fi
