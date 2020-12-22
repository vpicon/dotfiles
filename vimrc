"--------------------- SET OPTIONS ----------------------"
"" Functionality and internals
set nocompatible " disable vi and work only vim
set lazyredraw  " better redrawing after macros


"" Indenting style and coding stuff
set tabstop=4      " set visual width of tabs
set softtabstop=4  " insert 4 spaces instead of tab while editing
set shiftwidth=4  
set expandtab      " set tab as spaces while visualizing
set smartindent    " do smart autoindenting when starting a new line
set autoindent     " copy indent from current line when starting a new line
filetype indent on " check filetype to help on indenting rules

set showmatch      " show bracket match

set foldenable 
set foldmethod=indent
augroup remember_folds " Remember folds of previous sessions
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

 
function! TrimWhiteSpace() " trim end whitespaces on c files at save
    %s/\s\+$//e
endfunction
autocmd BufWritePre     *.c :call TrimWhiteSpace()




"" Line numbering
set number         " show current file line number
set relativenumber " show relative line number


"" Searching
set ignorecase " case insensitive search 
set incsearch  " show results while searching


"" Graphical
syntax on      " syntax highlighting from syntax files
set showcmd    " shows command line bar (no matter what other uncompatibilities)
set cursorline " highlight current cursor line

augroup CursorLine " Highlight cursor line only on current window
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END


"" Miscelanea
set nowrap       " no line wrapping 
set noerrorbells " no sound when error
set wildmenu     " <TAB> autocompletion menu while enterign vim command


"--------------------- MAPPINGS ----------------------"

"" Command Maps  

" The following remaps only work if the character is alone
" that is, :Q will remap to :q, but :Qf will not remap to :qf
" misspell quit
cnoreabbrev <expr> Q (getcmdtype() is# ':' && getcmdline() is# 'Q') ? 'q' : 'Q'
" misspell save
cnoreabbrev <expr> W (getcmdtype() is# ':' && getcmdline() is# 'W') ? 'w' : 'W'
" misspell save and quit
cnoreabbrev <expr> X (getcmdtype() is# ':' && getcmdline() is# 'X') ? 'x' : 'X'

"" Insert Mode Maps
" Bracket Auto Completion
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O

"----------------------- PLUGINS ------------------------"
let mapleader = ","
filetype plugin on

call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'ctrlpvim/ctrlp.vim'
"    Plug 'vim-syntastic/syntastic'
    Plug 'preservim/nerdcommenter' 
    Plug 'morhetz/gruvbox' 
call plug#end() 


"" CtrlP: Fuzzy file finder.
""        https://github.com/ctrlpvim/ctrlp.vim

" Define a root directory to start finding (additional than .git)
let g:ctrlp_root_markers = ['Makefile', 'src']

" If no starting directory specified, start with nearest antecessor
" of current file containing a root directory
let g:ctrlp_working_path_mode = 'ra'

" Some mappings to open the pluggin
map <leader>z :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>



"" NERDTree: Filesystem navigator inside vim.
""           https://github.com/preservim/nerdtree

map <leader>t :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '~'
let g:NERDTreeDirArrowCollapsible = '~'


"" NERDCommenter: manage and comment blocs of code, 
""                allows formatting and more.
""                https://github.com/preservim/nerdcommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1



"" Syntastic: Syntax checker for many languages.

" Some beginners options. TODO: read manual and set them right
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


" " Set error window size automatically to fit number of errors
" " see :h syntastic-loclist-callback
" function! SyntasticCheckHook(errors)
    " if !empty(a:errors)
        " let g:syntastic_loc_list_height = min([len(a:errors), 10])
    " endif
" endfunction

 "-------------------- COLOR SCHEMES --------------------"


" Gruvbox Color Scheme: Pastel colors.
"                       https://github.com/morhetz/gruvbox

"let g:gruvbox_italic = '1'
"let g:gruvbox_italicize_comments = '1'
"
set background=dark    " Setting dark mode
" autocmd vimenter * colorscheme gruvbox
colorscheme gruvbox
