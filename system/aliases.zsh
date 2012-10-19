# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Set the current tab's title
title () {
    echo -ne "\033]0;$@\007"
}

# Alias cat to use pygments
alias c='pygmentize -O style=monokai -f console256 -g'
