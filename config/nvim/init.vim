"
"   /$$    /$$ /$$                      /$$$$$$                       /$$$$$$  /$$
"  | $$   | $$|__/                     /$$__  $$                     /$$__  $$|__/
"  | $$   | $$ /$$ /$$$$$$/$$$$       | $$  \__/  /$$$$$$  /$$$$$$$ | $$  \__/ /$$  /$$$$$$
"  |  $$ / $$/| $$| $$_  $$_  $$      | $$       /$$__  $$| $$__  $$| $$$$    | $$ /$$__  $$
"   \  $$ $$/ | $$| $$ \ $$ \ $$      | $$      | $$  \ $$| $$  \ $$| $$_/    | $$| $$  \ $$
"    \  $$$/  | $$| $$ | $$ | $$      | $$    $$| $$  | $$| $$  | $$| $$      | $$| $$  | $$
"     \  $/   | $$| $$ | $$ | $$      |  $$$$$$/|  $$$$$$/| $$  | $$| $$      | $$|  $$$$$$$
"      \_/    |__/|__/ |__/ |__/       \______/  \______/ |__/  |__/|__/      |__/ \____  $$
"                                                                                  /$$  \ $$
"                                                                                 |  $$$$$$/
"                                                                                  \______/


" ************* plugins *************

call plug#begin('~/.local/share/nvim/plugged')

" -- syntax theme
Plug 'morhetz/gruvbox'

" -- vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" -- improve syntax color
Plug 'sheerun/vim-polyglot'

" -- snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" -- start page
Plug 'mhinz/vim-startify'

" -- code check
Plug 'scrooloose/syntastic'

" -- format
Plug 'Chiel92/vim-autoformat'

" -- code completion
Plug 'Valloric/YouCompleteMe'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}

" -- change projet root automatically
Plug 'airblade/vim-rooter'

" -- complete brackets, parentheses, ...
Plug 'jiangmiao/auto-pairs'

" -- nerdtree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

call plug#end()

" ************* editor configuration *************

filetype plugin on
filetype indent on
syntax on
set tabstop=4
set shiftwidth=4
set smarttab
set splitright
set nohlsearch
set autoread
set t_Co=16
set scrolloff=8

au BufNewFile,BufRead *.h setlocal ft=c
" ************* eye-candy configuration *************

" show line numbers
set nu
highlight LineNr ctermfg=26
highlight LineNr ctermbg=25

" colorscheme
set background=dark
colorscheme gruvbox

" ************* Keymaps *************

let mapleader = ","

nnoremap <leader>cv :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <leader>f :NERDTreeFocus<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>


" line numbers relative/absolute
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" ************* JavaComplete configuration *************

autocmd FileType java setlocal omnifunc=javacomplete#Complete

" ************* Autoformat configuration *************

let blacklist = ['xml']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :Autoformat

" ************* Airline configuration *************

let g:airline_powerline_fonts = 1
let g:airline_theme = "gruvbox"

" symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" extensions
let g:airline_extensions = ['tabline']
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" left sections
let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = airline#section#create(['%t'])
let g:airline_section_c = airline#section#create([])

" center
let g:airline_section_getter = ''

" right sections
let g:airline_section_x = ''
let g:airline_section_y = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create(['%3.3l'])
let g:airline_section_error = airline#section#create(['syntastic'])
let g:airline_section_warning = airline#section#create([''])

" tabline options
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1

" ************* YouCompleteMe configuration *************

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

" ************* Ultisnips configuration *************

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" ************* Startify configuration *************

let g:startify_custom_header = [
			\"   _   _                   _            ",
			\"  | \\ | |                 (_)           ",
			\"  |  \\| | ___  _____   ___ _ __ ___   ",
			\"  | . ` |/ _ \\/ _ \\ \\ / / | '_ ` _ \\ ",
			\"  | |\\  |  __/ (_) \\ V /| | | | | | | ",
			\"  \\_| \\_/\\___|\\___/ \\_/ |_|_| |_| |_| ",
			\]

let g:startify_list_order = [
			\ ['  ---------  FICHIERS  ---------'],
			\ 'files',
			\ ['  ---------  SESSIONS  ---------'],
			\ 'sessions',
			\ ['  ---------  PROJETS  ---------'],
			\ 'bookmarks',
			\ ]

let g:startify_enable_special = 0
let g:startify_files_number = 5

" projets
let g:startify_bookmarks = [
			\ '~/Documents/Prog/mdata/'
			\ ]

" ************* Syntastic configuration *************

" basic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" disabled checkers
let g:syntastic_enable_latex_checker = 0
let g:syntastic_enable_tex_checker = 0
let g:syntastic_tex_checkers = []
let g:syntastic_enable_xml_checker = 0

" checker ---- C
let g:syntastic_c_checkers = ["clang_tidy"]

let g:syntastic_cpp_checkers = ["clang_check"]

" ************* NERDTree configuration *************

autocmd VimEnter *
			\   if !argc()
			\ |   Startify
			\ |   execute 'NERDTreeTabsOpen'
			\ |   wincmd w
			\ | endif

let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_synchronize_view = 0
