autoload -U colors && colors

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

function git_branch {
	BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
	if ! test -z $BRANCH; then
		echo "$BRANCH"
	fi
}

function get_git_dirty { 
   [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "%{$fg[red]%}*%{$reset_color%}"
}


function precmd() {
	PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ $(get_git_dirty)%{$reset_color%}% 
$(prompt_char) "
	RPROMPT="%{$fg[red]%}% $(git_branch)%{$reset_color%}%"

	title $(pwd | sed -e "s,^$HOME,~,")
}