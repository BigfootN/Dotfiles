" *******************************************
"
"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"      ░░   ▒ ░░      ░     ░░   ░ ░
"
" *******************************************

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

" -- change projet root automatically
Plug 'airblade/vim-rooter'

" -- complete brackets, parentheses, ...
Plug 'jiangmiao/auto-pairs'

" -- nerdtree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" -- latex
Plug 'lervag/vimtex'

" -- tagbar
Plug 'majutsushi/tagbar'

" -- comment
Plug 'scrooloose/nerdcommenter'

" -- icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" -- surround
Plug 'tpope/vim-surround'

" -- fold
Plug 'konfekt/fastfold'

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

set termguicolors

au BufNewFile,BufRead *.h setlocal ft=c

" python indent
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4

" disable ansible, sshconfig indent
autocmd FileType conf,tex,yaml,vim,sshconfig,dockerfile,make let b:autoformat_autoindent=0
autocmd FileType conf,tex,yaml,vim,sshconfig,dockerfile,make let b:autoformat_retab=0
autocmd FileType conf,tex,yaml,vim,sshconfig,dockerfile,make let b:autoformat_remove_trailing_spaces=0
autocmd FileType conf,tex,vim,yaml,sshconfig,dockerfile,make let b:did_indent=0

" popup height
set pumheight=10

" ************* eye-candy configuration *************

" show line numbers
set nu
highlight LineNr ctermfg=26
highlight LineNr ctermbg=25

" colorscheme
set background=dark
colorscheme gruvbox

" veritcal split character
set fillchars+=vert:\┃

" ************* Keymaps *************

let mapleader = ","

nnoremap <leader>cv :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <leader>f :NERDTreeFocus<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>p :tabprevious<CR>
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>ct :wa<CR> <bar> :tabclose<CR>

" YouCompleteMe maps
nnoremap <leader>d :YcmCompleter GoToDefinition<CR>

" line numbers relative/absolute
set number relativenumber

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

" ************* VimTex configuration *************

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
  endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" ************* VimTex configuration *************

let g:tex_fold_enabled = 1
let g:fastfold_fold_command_suffixes = ['x']

" ************* YouCompleteMe configuration *************

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_max_num_candidates = 10
let g:ycm_max_num_identifier_candidates = 10

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

" checker ---- Cpp
let g:syntastic_cpp_checkers = ["clang_tidy"]

" clang_check ---- config file
let g:syntastic_c_clang_tidy_post_args = ""
let g:syntastic_cpp_clang_tidy_post_args = ""

" ************* NERDTree configuration *************

autocmd VimEnter *
			\   if !argc()
			\ |   Startify
			\ |   execute 'NERDTreeTabsOpen'
			\ |   wincmd w
			\ | endif


" -- nerdtree tabs config
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_startup_cd = 1

" -- ignore files
let NERDTreeIgnore = ['^build$']

" ************* Autoformat configuration *************

" Cpp language
let g:formatdef_uncrustify_cpp = '"uncrustify -q -c ~/.config/uncrustify/uncrustify.cfg -l CPP"'
let g:formatters_cpp = ['uncrustify_cpp']

" C language
let g:formatdef_uncrustify_c = '"uncrustify -q -c ~/.config/uncrustify/uncrustify.cfg -l C"'
let g:formatters_c = ['uncrustify_c']

" ************* Gruvbox configuration *************

let g:gruvbox_number_column = 'bg1'

" ************* Vim Devicons configuration ************* 

"augroup nerdtreedisablecursorline
	"autocmd!
	"autocmd FileType nerdtree setlocal nocursorline
"augroup end

let g:NERDTreeLimitedSyntax = 1

set guifont=Iosevka\ Nerd\ Font\ Mono\ 11
