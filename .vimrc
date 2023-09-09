" Vim file configuration ~/.vimrc
" Amine HADDAD <zatamine@gmail.com>
" htttp://zatamine.com
" inspired form
" http://vimdoc.sourceforge.net/htmldoc/usr_toc.html

" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax enable

" For plug-ins to load correctly.
filetype indent on

" add yaml settings
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>

" Turn off modelines
set modelines=0

" Don't wrap text
set nowrap

" Vim's auto indentation feature does not work properly with text copied from outside of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Value corresponding to the width of your screen.
set textwidth=79
set colorcolumn=80
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noshiftround

" use spaces instead of tabs
"set expandtab
"set smarttab


" Show a visual lien under the cursor's current line
set cursorline

" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show matching brackets
set showmatch

" Show line numbers
set number
set relativenumber

" Set status line display
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
" set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Don't continue to highlight searched phrases.
set nohlsearch

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

" set 'desert' colorscheme by default if 'solarized' are not installed
if filereadable(expand("~/.vim/colors/solarized.vim"))
  colorscheme solarized
  set t_Co=256
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
