#
# ~/.bashrc
#

complete -cf sudo

alias ls='ls --color=auto'



# If not running interactively, do not do anything
[[ $- != *i* ]] && return

# colors
col1='\[\e[38;5;142m\]'
col2='\[\e[38;5;214m\]'
col3='\[\e[38;5;167m\]'
sep_col='\[\e[38;5;241m\]'
reset='\[\e[0m\]'

#symbols
vert_bar="$(echo -e "\u23BC")"
dot="$(echo -e "\u22c5")"

# set envirornment variables
export PATH=$HOME/.local/bin:${PATH}
export SHELL=/usr/bin/bash
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim

# PS1 customize
PS1="${col1}(\u) ${sep_col}${vert_bar}${vert_bar} ${col2}(\w) \n ${col3}\$ ${dot}${reset} "

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
alias supp="pacaur -Rcsndd --noconfirm"
alias inst="pacaur -Sy --noconfirm --noedit"
alias src="pacaur -Ss --noconfirm"
alias maj="pacaur -Syyuu --noconfirm --noedit"
alias nett="pacaur --noconfirm -Scc && sudo pacaur -Rcsndd \$(pacaur -Qqtd)"
alias src_local="pacaur -Qs"
