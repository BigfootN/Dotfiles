" *******************************************
"
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

" ―――――――――――――
" ―― plugins ――
" ―――――――――――――

call plug#begin('~/.local/share/nvim/plugged')

" -- syntax theme
Plug 'morhetz/gruvbox'

" -- vim airline
Plug 'vim-airline/vim-airline'

" -- improve syntax color
Plug 'sheerun/vim-polyglot'

" -- start page
Plug 'mhinz/vim-startify'

" -- code check
Plug 'w0rp/ale'

" -- format
Plug 'Chiel92/vim-autoformat'

" -- code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" -- snippets
Plug 'honza/vim-snippets'

" -- complete brackets, parentheses, ...
Plug 'jiangmiao/auto-pairs'

" -- nerdtree
Plug 'scrooloose/nerdtree'

" -- latex
Plug 'lervag/vimtex'

" -- comment
Plug 'scrooloose/nerdcommenter'

" -- icons
Plug 'ryanoasis/vim-devicons'

" -- surround
Plug 'tpope/vim-surround'

" -- fold
Plug 'konfekt/fastfold'

" -- ctrlp
Plug 'ctrlpvim/ctrlp.vim'

" -- github
Plug 'tpope/vim-fugitive'

call plug#end()

" ―――――――――――――――
" ―― Functions ――
" ―――――――――――――――

" change working directory and nerd tree root
function! s:ChangeWorkingDirectory(wd)
	execute "cd " . a:wd
	execute "NERDTreeCWD"
endfunction

" remove useless tabs/spaces
function! s:RemoveWhiteSpacesTabs()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

" join consecutive blank lines
function! s:JoinBlankEmptyLines()
	let l:save = winsaveview()
	keeppatterns v/\S/,/\S/-j
	call winrestview(l:save)
endfunction

" remove useless lines
function! s:RemoveUselessLines()
	call s:RemoveWhiteSpacesTabs()
	call s:JoinBlankEmptyLines()
endfunction

" ――――――――――――――――――――――――――
" ―― Editor configuration ――
" ――――――――――――――――――――――――――

" general global settings
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
set completeopt=menuone

" support true colors
set termguicolors

" leave buffer with modifications
set hidden

" set headers (*.h) to c file type not cpp
au BufNewFile,BufRead *.h setlocal ft=c

" trim whitespaces
au BufWrite *.* call s:RemoveUselessLines()

" python indent
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4

" lua indent
autocmd FileType lua setlocal noexpandtab tabstop=4|%retab!

" disable ansible, sshconfig indent
autocmd FileType conf,lua,tex,yaml,vim,sshconfig,dockerfile,make let b:autoformat_autoindent=0
autocmd FileType conf,lua,tex,yaml,vim,sshconfig,dockerfile,make let b:autoformat_retab=0
autocmd FileType conf,lua,tex,yaml,vim,sshconfig,dockerfile,make let b:autoformat_remove_trailing_spaces=0
autocmd FileType conf,lua,tex,vim,yaml,sshconfig,dockerfile,make let b:did_indent=0

" yaml tab size
autocmd FileType yaml setlocal expandtab shiftwidth=4 tabstop=4

" popup height
set pumheight=10

" ―――――――――――――――
" ―― Eye candy ――
" ―――――――――――――――

" show line numbers
set nu
highlight LineNr ctermfg=26
highlight LineNr ctermbg=25

" colorscheme
set background=dark
colorscheme gruvbox

" veritcal split character
set list
set lcs=tab:\|\·,precedes:\·,space:\·

" ――――――――――――――
" ―― Commands ――
" ――――――――――――――

" change wroking directory
com! -nargs=1 -complete=file CWD call s:ChangeWorkingDirectory(<f-args>)

" close buffer and jump to next one
com! DeleteBuffer :bp | :bd #

" ――――――――――――
" ―― Kymaps ――
" ――――――――――――

let mapleader = ","

nnoremap <leader>vc :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>

" delete buffer and jump to next one
nnoremap <leader>bd :DeleteBuffer<CR>

" line numbers relative/absolute
set number relativenumber

" plugin managing map
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

" CtrlP mappings
nnoremap <leader>cpb :CtrlPBuffer<CR>
nnoremap <leader>cpd :CtrlPCurWD<CR>
nnoremap <leader>cpf :CtrlPCurFile<CR>

" NerdTree mappings
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>

" change wd
nnoremap <leader>cd :CWD

" jump to definition
nnoremap <leader>d <Plug>(coc-defintion)

" ―――――――――――
" ―― CtrlP ――
" ―――――――――――

" ignore spaces when searching
let g:ctrlp_abbrev = {
			\ 'abbrevs': [
			\ {
			\ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
			\ 'expanded': '',
			\ 'mode': 'fprz',
			\ },
			\ ]
			\ }

" root markers / root directory
let g:ctrlp_root_markers = ['compile_commands.json', '.ycm_extra_config.py', 'src/', 'lib/']

" ignore build or debug
let g:ctrlp_custom_ignore = {
	\ 'dir' : '\v.(build|debug).$',
	\ 'file' : '\v.(build|debug).|.\.o$',
	\ }

" ―――――――――――――
" ―― Airline ――
" ―――――――――――――

" don't use powerline fonts
let g:airline_powerline_fonts = 1

" seperators
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''

" symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" extensions
let g:airline_extensions = ['tabline', 'ctrlp', 'ale']
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#ale#enabled = 1
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
let g:airline_section_error = airline#section#create(['ale'])
let g:airline_section_warning = airline#section#create([''])

" tabline options
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1

" ――――――――――――
" ―― VimTex ――
" ――――――――――――

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
  endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:tex_fold_enabled = 1
let g:fastfold_fold_command_suffixes = ['x']

" ――――――――――――――
" ―― Startify ――
" ――――――――――――――

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

" ―――――――――
" ―― Ale ――
" ―――――――――

" global settings
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_linters = {
	\ 'c': ['clangd'],
	\ 'cpp': ['clangd'],
	\ 'lua': []
	\}

" loclist/window settings
let g:ale_open_list = 1
let g:ale_list_window_size = 8
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" c linter settings
let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = ['build', 'build/debug', 'build/release']

" cpp linter settings

" ――――――――――――――
" ―― Coc.nvim ――
" ――――――――――――――

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" ――――――――――――――
" ―― Nerdtree ――
" ――――――――――――――

autocmd VimEnter *
			\   if !argc()
			\ |   Startify
			\ |   NERDTree
			\ |   wincmd w
			\ | endif

" -- ignore files
let NERDTreeIgnore = ['^build$']

" ――――――――――――――――
" ―― Autoformat ――
" ――――――――――――――――

" Cpp language
let g:formatdef_uncrustify_cpp = '"uncrustify -q -c ~/.config/uncrustify/uncrustify.cfg -l CPP"'
let g:formatters_cpp = ['uncrustify_cpp']

" C language
let g:formatdef_uncrustify_c = '"uncrustify -q -c ~/.config/uncrustify/uncrustify.cfg -l C"'
let g:formatters_c = ['uncrustify_c']

let blacklist = ['xml']
autocmd BufWritePre * if index(blacklist, &ft) < 0 | :Autoformat

" python
let g:formatter_yapf_style = 'google'

" ―――――――――――――
" ―― Gruvbox ――
" ―――――――――――――

let g:gruvbox_number_column = 'bg1'
let g:gruvbox_contrast_dark = 'hard'

" ――――――――――――――
" ―― Devicons ――
" ――――――――――――――

let g:NERDTreeLimitedSyntax = 1

set guifont=Iosevka\ Nerd\ Font\ Mono\ 11
