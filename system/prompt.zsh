autoload -U colors && colors

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

function git_branch {
	BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
	if ! test -z $BRANCH; then
		COL="%{$fg[green]%}" # Everything's fine
		[[ $(git log origin/master..HEAD 2> /dev/null ) != "" ]] && COL="%{$fg[blue]%}" # We have changes to push
		[[ $(git status --porcelain 2> /dev/null) != "" ]] && COL="%{$fg[red]%}" # We have uncommited changes
		echo "$COL$BRANCH"
	fi
}

function get_git_dirty { 
   [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "%{$fg[blue]%}"
}


function precmd() {

	NAME=""
	if [[ $(whoami) != "michael" ]]; then; NAME="%n%{$reset_color%}@"; fi;

	PROMPT="%{$fg[red]%}$NAME%{$fg_bold[green]%}%m %{$fg[yellow]%}%~ %{$reset_color%}% 
$(prompt_char) "
	RPROMPT="$(git_branch)%{$reset_color%}%"

	title $(pwd | sed -e "s,^$HOME,~,")
}