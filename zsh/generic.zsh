# Make fn-backspace work on OSX
bindkey "^[[3~" delete-char
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# Slowkeys no more!
command -v xkbset >/dev/null 2>&1 && { xkbset -sl; xkbset -a; }

# ZSH Syntax Highlighting?
source $ZSH/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# History searching
source $ZSH/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
