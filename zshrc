#―――――――――――――――――――――――――――――――――――――――――――――――――――
#                      /$$
#                     | $$
#  /$$$$$$$$  /$$$$$$$| $$$$$$$   /$$$$$$   /$$$$$$$
# |____ /$$/ /$$_____/| $$__  $$ /$$__  $$ /$$_____/
#    /$$$$/ |  $$$$$$ | $$  \ $$| $$  \__/| $$
#   /$$__/   \____  $$| $$  | $$| $$      | $$
#  /$$$$$$$$ /$$$$$$$/| $$  | $$| $$      |  $$$$$$$
# |________/|_______/ |__/  |__/|__/       \_______/
#―――――――――――――――――――――――――――――――――――――――――――――――――――

source /home/bigfoot/.env_vars

#———————————————
#—— OH MY ZSH ——
#———————————————

# theme
ZSH_THEME="spaceship"

# plugins
plugins=(
	git
	zsh-autosuggestions
)

# source base directory
export ZSH="/home/bigfoot/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

#——————————————————————
#—— SPACESHIP PROMPT ——
#——————————————————————

# prompt order
export SPACESHIP_PROMPT_ORDER=(
time          # Time stamps section
user          # Username section
host          # Hostname section
dir           # Current directory section
git           # Git section (git_branch + git_status)
exec_time     # Execution time
line_sep      # Line break
exit_code     # Exit code section
char          # Prompt character
)

# user
export SPACESHIP_USER_SUFFIX=""

# char
export SPACESHIP_CHAR_SYMBOL=">"
export SPACESHIP_CHAR_SUFFIX=" "

# host
export SPACESHIP_HOST_PREFIX="$(printf '\u0040')"

#———————————
#—— ALIAS ——
#———————————

# vpn
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"
