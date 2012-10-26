# Make fn-backspace work on OSX
bindkey "^[[3~" delete-char

# ZSH Syntax Highlighting?
source $ZSH/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
