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

# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}


# Set the current tab's title
title () {
    echo -ne "\033]0;$@\007"
}

# Alias cat to use pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# Global ps, awesome
alias gps="ps -c -r -ax -o command,pid,pcpu,time | sed 's/\(PID *\)%/\1 %/' | head -n 11 && echo && ps -c -m -ax -o command,pid,pmem,rss=RSIZE | sed 's/\(.\{23\}\)/\1 /' | head -n 9"

# Smart cd function, allows switching to /etc when running 'cd /etc/fstab'
function cd() {
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${1} to ${1:h}"
        builtin cd ${1:h}
    else
        builtin cd "$@"
    fi
}

# Smart defaults
alias mkdir='mkdir -p'
alias pyserve='python -m SimpleHTTPServer'

if [ $IS_OSX -eq 0 ]; then
    # Open on linux
    alias open='xdg-open &> /dev/null';
fi

function calc {
bc << EOF
$@
EOF
}
