# ——————————————————————————————————————————————
#
# ▒███████▒  ██████  ██░ ██  ██▀███   ▄████▄
# ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒▓██ ▒ ██▒▒██▀ ▀█
# ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░▓██ ░▄█ ▒▒▓█    ▄
#   ▄▀▒   ░  ▒   ██▒░▓█ ░██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
# ▒███████▒▒██████▒▒░▓█▒░██▓░██▓ ▒██▒▒ ▓███▀ ░
# ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░ ▒▓ ░▒▓░░ ░▒ ▒  ░
# ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░  ░▒ ░ ▒░  ░  ▒
# ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░  ░░   ░ ░
#
# ——————————————————————————————————————————————


if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# ————
# INIT
# ————

# cursor speed
xset r rate 150 170

# ————————
# SETTINGS
# ————————

# antigen plugin path
ADOTDIR="$HOME/.antigen"

# keyboard speed
xset r rate 180 100

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR=/usr/bin/nvim

# config path
export XDG_CONFIG_HOME=$HOME/.config

# npm
PATH="$HOME/.node_modules/bin/:$PATH"
export npm_config_prefix=~/.node/modules

# ———————
# ANTIGEN
# ———————

# source antigen
source ~/.antigen/antigen.zsh

# oh-my-zsh
antigen use oh-my-zsh

# plugins
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle extract

# themes
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# done
antigen apply

# ————————————————
# HELPER FUNCTIONS
# ————————————————

# cmake build init
cmake_build_prepare() {
	mkdir -p build/{debug,release}
	cmake -G "Unix Makefiles" -DBUILD_TYPE=Debug build/debug .
	cmake -G "Unix Makefiles" -DBUILD_TYPE=Release build/release .
}

# —————————————
# ZSH VARIABLES
# —————————————

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

# ——————————————————
# SPACESHIP SETTINGS
# ——————————————————

# prompt order
export SPACESHIP_PROMPT_ORDER=(
time          # Time stamps section
user          # Username section
host          # Hostname section
dir           # Current directory section
git           # Git section (git_branch + git_status)
hg            # Mercurial section (hg_branch  + hg_status)
package       # Package version
node          # Node.js section
ruby          # Ruby section
elixir        # Elixir section
xcode         # Xcode section
swift         # Swift section
golang        # Go section
php           # PHP section
rust          # Rust section
haskell       # Haskell Stack section
julia         # Julia section
docker        # Docker section
aws           # Amazon Web Services section
venv          # virtualenv section
conda         # conda virtualenv section
pyenv         # Pyenv section
dotnet        # .NET section
ember         # Ember.js section
kubecontext   # Kubectl context section
terraform     # Terraform workspace section
exec_time     # Execution time
line_sep      # Line break
battery       # Battery level and status
vi_mode       # Vi-mode indicator
jobs          # Background jobs indicator
exit_code     # Exit code section
char          # Prompt character
)

# user
export SPACESHIP_USER_SUFFIX=""
export SPACESHIP_USER_SHOW=always

# char
export SPACESHIP_CHAR_SYMBOL="➜ "

# host
export SPACESHIP_HOST_PREFIX="$(printf '\u0040')"
export SPACESHIP_HOST_SHOW="always"

# —————
# ALIAS
# —————

# named directories
export dev=~/Documents/Dev

# utils
alias astyle="astyle --options=~/.config/astyle/astylerc"
alias mirrupg="sudo reflector --country France --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"

# vpn
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"

# package mgmt
alias sysupg="mirrupg && yay -Syu --noconfirm"
alias sysinstall="yay -Sy --noconfirm"
alias sysrm="yay -Rcsn --noconfirm"
alias syspkgsrc="yay -Qs"
alias sysclean="yay -Scc && sysrm $(yay -Qtdq)"

# cmake/prog
alias cmakeinit="cmake_build_prepare"
