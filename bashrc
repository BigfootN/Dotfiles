#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -cf sudo

alias ls='ls --color=auto'

# function updater
function _update_ps1() {
PS1="$(python2 ~/.powerline-shell/powerline-shell.py --cwd-max-depth 3 --mode patched $? 2> /dev/null) \n$blue$right_arr$reset "
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

function extract {
if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
            *.tar.bz2) tar xvjf ./"$1" ;;
            *.tar.gz) tar xvzf ./"$1" ;;
            *.tar.xz) tar xvJf ./"$1" ;;
            *.lzma) unlzma ./"$1" ;;
            *.bz2) bunzip2 ./"$1" ;;
            *.rar) unrar x -ad ./"$1" ;;
            *.gz) gunzip ./"$1" ;;
            *.tar) tar xvf ./"$1" ;;
            *.tbz2) tar xvjf ./"$1" ;;
            *.tgz) tar xvzf ./"$1" ;;
            *.zip) unzip ./"$1" ;;
            *.Z) uncompress ./"$1" ;;
            *.7z) 7z x ./"$1" ;;
            *.xz) unxz ./"$1" ;;
            *.exe) cabextract ./"$1" ;;
            *) echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"
    fi
fi
}

alias smile="scrot -d3 -c -q100"
alias supp="yaourt -Rcsndd --noconfirm"
alias inst="yaourt  -Sy --noconfirm"
alias src="yaourt --noconfirm"
alias maj="yaourt -Syua --noconfirm"
alias nett="yaourt --noconfirm -Scc && yaourt -Rcsndd \$(yaourt -Qqtd)"
alias grooveshark="firefox http://grooveshark.com"
alias src_local="yaourt -Qs"
#alias tmux="tmux -2"

alias cp="cp -r"
export TERM=xterm-256color-italic
