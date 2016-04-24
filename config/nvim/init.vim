
" /$$    /$$ /$$$$$$ /$$      /$$        /$$$$$$                       /$$$$$$  /$$
"| $$   | $$|_  $$_/| $$$    /$$$       /$$__  $$                     /$$__  $$|__/
"| $$   | $$  | $$  | $$$$  /$$$$      | $$  \__/  /$$$$$$  /$$$$$$$ | $$  \__/ /$$  /$$$$$$
"|  $$ / $$/  | $$  | $$ $$/$$ $$      | $$       /$$__  $$| $$__  $$| $$$$    | $$ /$$__  $$
" \  $$ $$/   | $$  | $$  $$$| $$      | $$      | $$  \ $$| $$  \ $$| $$_/    | $$| $$  \ $$
"  \  $$$/    | $$  | $$\  $ | $$      | $$    $$| $$  | $$| $$  | $$| $$      | $$| $$  | $$
"   \  $/    /$$$$$$| $$ \/  | $$      |  $$$$$$/|  $$$$$$/| $$  | $$| $$      | $$|  $$$$$$$
"    \_/    |______/|__/     |__/       \______/  \______/ |__/  |__/|__/      |__/ \____  $$
"                                                                                   /$$  \ $$
"                                                                                  |  $$$$$$/
"                                                                                   \______/

" improved
filetype off

" automatic installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.nvimrc
endif

" plugins
call plug#begin('~/.config/nvim/plugged')

" file browser
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-surround'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'

" eyecandy
Plug 'itchyny/lightline.vim'

" code
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe'
Plug 'DoxygenToolkit.vim'
Plug 'Raimondi/delimitMate'
Plug 'Chiel92/vim-autoformat'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'

" snippets
Plug 'SirVer/ultisnips'

" startify
Plug 'mhinz/vim-startify'

" color syntax
Plug 'morhetz/gruvbox'

call plug#end()

"================================
"   VIM/MISCELLANEOUS SETTINGS
"================================

" syntax and filetype
syntax on
filetype plugin indent on
set modeline

" disable preview
set completeopt-=preview

" split settings
set splitright
set splitbelow

" remove menubar and toolbar
set guioptions-=m
set guioptions-=T
set guioptions-=e

" Increasive search
set incsearch
set ignorecase
set smartcase

" enable c syntax for *.h files
let g:c_syntax_for_h=1

" enable plaintex syntax for *.tex files
autocmd BufRead,BufNewFile *.tex set filetype=plaintex

" autoresize splits
autocmd VimResized * exe "normal \<c-w>="

" keep cursor centered
"set scrolloff=100

" set backspace
set backspace=indent,eol,start

" activate mouse
set mouse=a

" keep status line
set laststatus=2

"===============
"    MAPPING
"===============

" mapping timeout
set timeoutlen=500

" map leader
let mapleader=","

" white spaces
noremap <silent> <F5> :%s/\s\+$//<CR>

" write and quit
nmap <silent> <leader>q          :q<CR>
nmap <silent> <leader>w          :w<CR>
nmap <silent> <leader>s          :so ~/.config/nvim/init.vim<CR>

nmap <silent> <leader>x          :x<CR>
nmap <silent> <leader>xa         :xa<CR>
nmap <silent> <leader>wa         :wa<CR>

" tab and split
nmap <silent> <leader>p          :tabprevious<CR>
nmap <silent> <leader>n          :tabnext<CR>
nmap <silent> <leader><right>    <C-w><C-w><right>            t
nmap <silent> <C-n>              :tabnew<CR>
nmap <silent> <C-d>              :tabclose<CR>
nmap <silent> <leader>tv         :tabnew ~/.vimrc<CR>

" updating
nmap <silent> <leader>u          :PlugUpdate
nmap <silent> <leader>c          :PlugClean

" Surrounding
nmap <silent> <leader>b          ysiwb                        " wrap current word with brackets

" auto indent with F7
noremap <F7> :Autoformat<CR>

" auto format on save
au BufWrite * :Autoformat

" nerdtree
nmap <silent> <leader>ft         :NERDTreeToggle<CR>

"=====================
"    LOOK AND FEEL
"=====================

" set colorscheme
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark = "hard"
set background=dark
colorscheme gruvbox

" Set lines
set nu                                      " show line numbers

" Disable cursorline for tex files
autocmd FileType tex :NoMatchParen
au FileType tex setlocal nocursorline
let g:tex_flavor = "plain"

" set indent space
set autoindent      " always set autoindenting on
set expandtab       " use spaces, not tabs
set shiftwidth=4    " indent level of 4 spaces
set tabstop=4       " tab of 4 spaces
set softtabstop=4   " backspace of 4 spaces

"==================
"   Plug OPTIONS
"==================

let g:plug_window = 'vertical topleft new'

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
let g:syntastic_c_no_include_search = 0
let g:syntastic_c_auto_refresh_includes = 1
let b:syntastic_c_includes = 1

" c++ syntastic options
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let b:syntastic_cpp_includes = 1
let g:syntastic_cpp_config_file = '.config_cpp'

"============================
"   YCM/COMPLETION OPTIONS
"============================

" ycm options
let g:ycm_show_diagnostics_ui = 0
let g:ycm_auto_trigger = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_filetype_specific_completion_to_disable = {
            \ 'gitcommit': 1,
            \ 'swap': 1
            \ }

" disable for tex files
let g:ycm_filetype_blacklist = {
            \ 'tex' : 1,
            \ 'plaintex' : 1
            \}
let g:ycm_python_binary_path = '/usr/bin/python2'

" prevents flickering from too long completion menu
set pumheight=10

"=======================
"   LIGHTLINE OPTIONS
"=======================

" layout and options
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [ [ 'mode'],
            \             [ 'filename']],
            \   'right':[ ['filetype'], ['syntastic', 'percent']]
            \ },
            \ 'separator': {
            \    'left': "",
            \    'right': ""
            \ },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ 'tab':{
            \   'active':[
            \       'filename'
            \   ],
            \   'inactive':[
            \       'filename'
            \    ]
            \ },
            \ 'component_expand':{
            \   'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type':{
            \   'syntastic': 'error'
            \ },
            \ 'component_visible_condition':{
            \   'syntastic': 'showSynt'
            \ }
            \}

function! s:showSynt()
    if strlen(SyntasticCheck) > 0
        return 1
    else return 0
    endif
endfunction

" file {{{

" is modified
function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

" is read only
function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

" file name
function! LightLineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" file formate
function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

" file type
function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

" file encoding
function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

" file mode
function! LightLineMode()
    let fname = expand('%:t')
    return fname == 'ControlP' ? 'CtrlP' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" }}}

" ctrlp {{{
function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

" }}}

"=====================
"   GRUVBOX OPTIONS
"=====================

let g:gruvbox_bold = 0
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = 'soft'
set background=dark
hi LineNr ctermbg=25 ctermfg=26

"==================================
"   DOXYGEN HIGHLIGHTING/OPTIONS
"==================================

" Doxygen highlighting
let g:load_doxygen_syntax = 1

"===================
"   CTRLP OPTIONS
"===================

let g:ctrlp_map = '<c-p>'
let g:ctrlp_switch_buffer = 'ETVH'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_working_path = 'wr'
let g:ctrlp_match_window = 'min:1,max:18,results:30'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.o/*,*/.cmake/*,*/.txt/*,*/.so/*,*/.c.o/*,*/build/*

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

"=========================
"   DELIMITMATE OPTIONS
"=========================

let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_balance_matchpairs=1

"========================
"   AUTOFORMAT OPTIONS
"========================

let g:formatdef_java = '"astyle --mode=java -A2 --indent=spaces=4 --attach-classes -K -S"'
let g:formatters_java = ['java']

let g:formatdef_c = '"astyle --mode=c -A3 -s4 -S -xw -Y -p -k1 -c"'
let g:formatters_c = ['c']

let g:formatdef_cpp = '"astyle --mode=cpp -A3 -s4 -S -xw -Y -p -k1 -c"'
let g:formatters_cpp = ['cpp']

"======================
"   NERDTREE OPTIONS
"======================

let g:nerdtree_tabs_open_on_console_startup = 0
let NERDTreeDirArrows=0
hi Directory guifg=#B33804 ctermfg=red
hi Title guifg=#E15610 ctermfg=red

"=======================
"   ULTISNIPS OPTIONS
"=======================

set runtimepath+=~/.config/
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snips"]

" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

"======================
"   STARTIFY OPTIONS
"======================

let g:startify_list_order = ['sessions', 'bookmarks']
let g:startify_list_order = [
            \ ['Projets'],
            \ 'bookmarks',
            \ ['Sessions'],
            \ 'sessions'
            \]
let g:startify_bookmarks = ['~/Documents/MNote', '~/Documents/AmLib']
let g:startify_session_persistence = 0
let g:startify_session_delete_buffers = 1
let g:startify_custom_header = [
            \'███████╗████████╗ █████╗ ██████╗ ████████╗',
            \'██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝',
            \'███████╗   ██║   ███████║██████╔╝   ██║  ',
            \'╚════██║   ██║   ██╔══██║██╔══██╗   ██║ ',
            \'███████║   ██║   ██║  ██║██║  ██║   ██║',
            \'╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝'
            \]
