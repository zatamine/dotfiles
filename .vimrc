" Vim file configuration ~/.vimrc
" Amine HADDAD <zatamine@gmail.com>
" htttp://zatamine.com
" inspired form
" http://vimdoc.sourceforge.net/htmldoc/usr_toc.html

" Set compatibility to Vim only.
set nocompatible
set mouse=a

" Helps force plug-ins to load correctly when it is turned back on below.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" For plug-ins to load correctly.
"filetype plugin indent on

" Turn on syntax highlighting.
syntax on

" Treat all numerals as decimal
set nrformats=


" Turn off modelines
set modelines=0

" Don't wrap text
set nowrap

" Vim's auto indentation feature does not work properly with text copied from outside of Vim. Press the <F2> key to toggle paste mode on/off.
"nnoremap <F2> :set invpaste paste?<CR>
"imap <F2> <C-O>:set invpaste paste?<CR>
"set pastetoggle=<F2>

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Value corresponding to the width of your screen.
"set textwidth=119
set colorcolumn=119
""set formatoptions=tcqrn1j
set formatoptions=tcqj
set tabstop=2
set shiftwidth=2
"set softtabstop=2
"set noshiftround

" use spaces instead of tabs
set expandtab
set smarttab
"set autoindent

"Avoid wrapping a line in the middle of a word.
set linebreak

" Display command line’s tab complete options as a menu.
set wildmenu

set title

" Show a visual lien under the cursor's current line
set cursorline

" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Status bar
set laststatus=2

" Show the mode you are on the last line.
set showmode

" Show partial command you type in the last line of the screen.
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show matching brackets
"set showmatch

" Show line numbers
set number
"set relativenumber

" Set status line display
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch

" Enable incremental search
set incsearch

" Include matching uppercase words with lowercase search term
set ignorecase

" Include only uppercase words with uppercase search term
set smartcase

" Don't continue to highlight searched phrases.
"set nohlsearch

" Spelling check
setlocal spell spelllang=en_us
"set complete+=kspell

" Undo file
set undofile
set undodir=~/.cache/vim/
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" Using a dark background within the editing area and syntax highlighting
set background=dark

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" set 'desert' colorscheme by default if 'solarized' are not installed
if filereadable(expand("~/.vim/colors/solarized.vim"))
  colorscheme solarized
"  set t_Co=256
else
  colorscheme desert
endif

" Store info from no more than 50 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='50,<9999,s100

" Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Mute search hightlighting
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>


" Configure paired characters
"inoremap '' ''<ESC>ha
"inoremap " ""<ESC>ha
"inoremap ` ``<ESC>ha
"inoremap ( ()<ESC>ha
"inoremap [ []<ESC>ha
"inoremap { {}<ESC>ha
"inoremap /* /** */<ESC>2ha

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Temporary disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
