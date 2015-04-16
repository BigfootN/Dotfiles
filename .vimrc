" improved
set nocompatible
filetype off

" set vundle path
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Vundle plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'DoxygenToolkit.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'itchyny/lightline.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'kien/ctrlp.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'reedes/vim-lexical'
Plugin 'Chiel92/vim-autoformat'
Plugin 'morhetz/gruvbox'

call vundle#end()

"================================
"   VIM/MISCELLANEOUS SETTINGS
"================================

" syntax and filetype
syntax on
filetype plugin indent on
set modeline

" split settings
set splitright
set splitbelow

" remove menubar and toolbar
set guioptions-=m
set guioptions-=T
set guioptions-=e

" auto indent with F7
noremap <F7> :Autoformat<CR><CR>

" Increasive search
set incsearch
set ignorecase
set smartcase

" enable c syntax for *.h files
let g:c_syntax_for_h=1

"===============
"    MAPPING
"===============

" map leader
let mapleader=","

" white spaces
nnoremap <silent> <F5> :%s/\s\+$//<CR>

" write and quit
map <leader>q          :q<CR>
map <leader>w          :w<CR>
map <leader>s          :so ~/.vimrc<CR>
map <leader>x          :x<CR>
map <leader>xa         :xa<CR>
map <leader>wa         :wa<CR>

" tab and split
map <leader>p          gT
map <leader>n          gt
map <leader><right>    <C-w><C-w><right>            t
map <C-n>              :tabnew<CR>
map <C-d>              :tabclose<CR>

" Surrounding
map <leader>b          ysiwb                        " wrap current word with brackets

" ctags
map <F8>               :TagbarToggle<CR>            " toggle tagbar

"=====================
"    LOOK AND FEEL
"=====================

" set font and colorscheme
set t_Co=256
set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 9
colorscheme gruvbox

" gruvbox configuration
let g:gruvbox_improved_warnings=1
let g:gruvbox_invert_indent_guides=1
set background=dark

" Set lines
set nu                                      " show line numbers
set cursorline                              " show line where the cursor is
autocmd WinEnter * setlocal cursorline      " set cursorline on the entering of a new window
autocmd WinLeave * setlocal nocursorline    " set off cursorline when leaving the curent window
set list!
set list listchars=eol:¬,tab:--,nbsp:-

" set indent space
set autoindent      " always set autoindenting on
set expandtab       " use spaces, not tabs
set shiftwidth=4    " indent level of 4 spaces
set tabstop=4       " tab of 4 spaces
set softtabstop=4   " backspace of 4 spaces


"=======================
"   NERDTREE SETTINGS
"=======================

" Open nerdtree in console
let g:nerdtree_tabs_open_on_console_startup = 1


"=======================
"   SYNTASTIC OPTIONS
"=======================

" syntastic options
" let g:EclimFileTypeValidate = 0 // disable syntastic checks
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" c syntastic options
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_config_file = '.config_c'
let g:syntastic_c_check_header = 1
let g:syntastic_c_auto_refresh_includes = 1
let b:syntastic_c_includes = 1


" c++ syntastic options
let g:syntastic_cpp_checkers = ['g++']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let b:syntastic_cpp_includes = 1
let g:syntastic_cpp_config_file = '.config_cpp'

"============================
"   YCM/COMPLETION OPTIONS
"============================

" java completion
set omnifunc=syntaxcomplete#Complete
let g:EclimCompletionMethod='omnifunc'

" ycm options
let g:ycm_show_diagnostics_ui = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
set completeopt+=preview

"==========================
"   DOXYGEN HIGHLIGHTING
"==========================

" Doxygen highlighting
let g:load_doxygen_syntax = 1

"=============================
"   INDENTATION GUIDE LINES
"=============================

" indent lines
let g:indentLine_color_gui = '#696060'
let g:indentLine_char = '|'

"======================
"   AIRLINE OPTIONS
"======================

" airline theme
let g:airline_theme = 'gruvbox'

" airline font
let g:airline_powerline_fonts=1

" airline extension
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

"===================
"   CTRLP OPTIONS
"===================

let g:ctrlp_root_markers = ['*.config_*', '.config_cpp', 'build.xml', 'project.properties']
let g:ctrlp_working_path_mode = 'ra'

"=========================
"   DELIMITMATE OPTIONS
"=========================

let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_balance_matchpairs=1

"=========================
"   SPELL CHECK OPTIONS
"=========================

augroup lexical
    autocmd!
    autocmd FileType markdown,mkd call lexical#init()
    autocmd FileType textile call lexical#init()
    autocmd FileType text call lexical#init({ 'spell': 0 })
    autocmd FileType c,cpp,h,pp call lexical#init()
augroup END

"========================
"   AUTOFORMAT OPTIONS
"========================

let g:formatprg_java = "astyle"
let g:formatprg_args_expr_java = '"--mode=java -A2 --indent=spaces=4 --attach-classes -K -S"'

let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--mode=c -A3 -s4 -S -xW -Y -p -k1 -c"

let g:formatprg_py = "autopep8"
let g:formatprg_args_py = "-i"

"=======================
"   LIGHTLINE OPTIONS
"=======================
let g:lightline = {
            \ 'component': {
            \   'lineinfo': ' %3l:%-2v',
            \ },
            \ 'component_function': {
            \   'readonly': 'MyReadonly',
            \   'fugitive': 'MyFugitive'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }
function! MyReadonly()
    return &readonly ? '' : ''
endfunction
function! MyFugitive()
    if exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? ''._ : ''
    endif
    return ''
endfunction

let g:lightline.enable={
            \ 'statusline': 0,
            \ 'tabline': 1
            \ }
