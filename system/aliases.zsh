# GLS comes from `brew install coreutils`
if $(gls &>/dev/null); then
  LS_COM="gls"
else
  LS_COM="ls"
fi

alias ls="$LS_COM -F --color"
alias l="$LS_COM -lAh --color"
alias ll="$LS_COM -l --color"
alias la='$LS_COM -A --color'

# grep colouring
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'


# Set the current tab's title
title () {
    echo -ne "\033]0;$@\007"
}

# Alias cat to use pygments
alias c='pygmentize -O style=monokai -f console256 -g'
