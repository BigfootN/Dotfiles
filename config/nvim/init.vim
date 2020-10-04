"―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
"  /$$           /$$   /$$                /$$
" |__/          |__/  | $$               |__/
"  /$$ /$$$$$$$  /$$ /$$$$$$   /$$    /$$ /$$ /$$$$$$/$$$$
" | $$| $$__  $$| $$|_  $$_/  |  $$  /$$/| $$| $$_  $$_  $$
" | $$| $$  \ $$| $$  | $$     \  $$/$$/ | $$| $$ \ $$ \ $$
" | $$| $$  | $$| $$  | $$ /$$  \  $$$/  | $$| $$ | $$ | $$
" | $$| $$  | $$| $$  |  $$$$//$$\  $/   | $$| $$ | $$ | $$
" |__/|__/  |__/|__/   \___/ |__/ \_/    |__/|__/ |__/ |__/
"―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

"―――――――――――――
"―― plugins ――
"―――――――――――――

call plug#begin('~/.local/share/nvim/plugged')

" -- syntax theme
Plug 'gruvbox-community/gruvbox'

" -- vim airline
Plug 'vim-airline/vim-airline'

" -- improve syntax color
Plug 'sheerun/vim-polyglot'

" -- start page
Plug 'mhinz/vim-startify'

" -- neoformat
Plug 'sbdchd/neoformat'

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

" -- github
Plug 'tpope/vim-fugitive'

" -- fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

"―――――――――――――――
"―― Functions ――
"―――――――――――――――

" change working directory and nerd tree root
function! s:ChangeWorkingDirectory(wd)
	execute "cd " . a:wd
	execute "NERDTreeCWD"
	execute "wincmd l"
endfunction

" remove useless tabs/spaces
function! s:RemoveWhiteSpacesTabs()
	let l:save = winsaveview()
	keeppatterns silent! %s/\s\+$//e
	call winrestview(l:save)
endfunction

"" join consecutive blank lines
function! s:JoinBlankEmptyLines()
	let l:save = winsaveview()
	keeppatterns silent! v/\S/,/\S/-j
	call winrestview(l:save)
endfunction

" remove useless lines
function! s:RemoveUselessLines()
	call s:RemoveWhiteSpacesTabs()
	call s:JoinBlankEmptyLines()
endfunction

"――――――――――――――――――――――――――
"―― Editor configuration ――
"――――――――――――――――――――――――――

" general global settings
filetype plugin on
filetype indent on
syntax enable
" set smarttab
set splitright
set nohlsearch
set autoread
set scrolloff=8
set completeopt=menuone
set tabstop=4
set shiftwidth=4
set softtabstop=4

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

" yaml tab size
autocmd FileType yaml setlocal expandtab shiftwidth=4 tabstop=4

" popup height
set pumheight=10

"―――――――――――――――
"―― Eye candy ――
"―――――――――――――――

" show line numbers
set nu
highlight LineNr ctermfg=26
highlight LineNr ctermbg=25

" colorscheme
" set background=dark
colorscheme gruvbox

" veritcal split character
set list
set lcs=tab:\|\·,precedes:\·,space:\·

"――――――――――――――
"―― Commands ――
"――――――――――――――

" change wroking directory
com! -nargs=1 -complete=file CWD call s:ChangeWorkingDirectory(<f-args>)

" close buffer and jump to next one
com! DeleteBuffer :bp | :bd #

"――――――――――――
"―― Kymaps ――
"――――――――――――

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

" fzf mappings
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sc :Rg<CR>

" NerdTree mappings
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFocus<CR>

" change wd
nnoremap <leader>cd :CWD

" jump to definition
nmap <leader>d <Plug>(coc-defintion)
nmap <leader>r <Plug>(coc-rename)
nmap <leader>c <Plug>(coc-decleration)
nmap <leader>o <Plug>(coc-openlink)

"―――――――――――――
"―― Airline ――
"―――――――――――――

" don't use powerline fonts
let g:airline_powerline_fonts = 0

" symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" extensions
let g:airline_extensions = ['coc']
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#coc#enabled = 1

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

"――――――――――――
"―― VimTex ――
"――――――――――――

if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
  endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:tex_fold_enabled = 1
let g:fastfold_fold_command_suffixes = ['x']

"――――――――――――――
"―― Startify ――
"――――――――――――――

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

"――――――――――――――
"―― Coc.nvim ――
"――――――――――――――

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

"――――――――――――――
"―― Nerdtree ――
"――――――――――――――

autocmd VimEnter *
			\   if !argc()
			\ |   Startify
			\ |   NERDTree
			\ |   wincmd w
			\ | endif

" -- ignore files
let NERDTreeIgnore = ['^build$']

"――――――――――――――――
"―― Neoformat ――
"――――――――――――――――

augroup fmt
	autocmd!
	au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup end

" Cpp language
let g:neoformat_cpp_clang_format = {
			\ 'exe': 'clang-format',
			\ 'args': ['-style=file', '-i'],
			\ 'replace': 1,
			\ 'env': [],
			\ 'valid_exit_codes': [0],
			\ 'no_append': 1,
			\}

let g:neoformat_enabled_cpp = ['clang-format']

" C language
let g:neoformat_c_clangformat = {
			\ 'exe': 'clang-format',
			\ 'args': ['-style=file'],
			\ 'stdin': 1
			\}

let g:neoformat_enabled_c = ['clangformat']

" python
let g:formatter_yapf_style = 'google'

"―――――――――
"―― Fzf ――
"―――――――――

let $FZF_DEFAULT_COMMAND="fd -E build -E Build -E .svn -E .git"

"―――――――――――――
"―― Gruvbox ――
"―――――――――――――

"let g:gruvbox_number_column = 'bg1'
"let g:gruvbox_contrast_dark = 'hard'

"――――――――――――――
"―― Devicons ――
"――――――――――――――

let g:NERDTreeLimitedSyntax = 1

set guifont=Iosevka\ Nerd\ Font\ Mono\ 11
