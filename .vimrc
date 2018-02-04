" Vim file configuration ~/.vimrc
" Amine HADDAD <zatamine@gmail.com>
" htttp://zatamine.com
" http://vimdoc.sourceforge.net/htmldoc/usr_toc.html
 
" Set the compatibility to Vim only 
set nocompatible

" Enable syntax highlighting by default.
syntax on

" Using a dark background within the editing area and syntax highlighting
set background=dark

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Vim load indentation rules and plugins according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" Highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
"set hlsearch		" highlight all search matches.
set number		" Show each line with its line number.
"set ruler		" Show the line and column number of the cursor position
set colorcolumn=81	" Highlight column after textwidth

" set 'desert' colorscheme by default if 'solarized' are not installed
if filereadable(expand("~/.vim/colors/solarized.vim"))
  colorscheme solarized
  set t_Co=256
else
  colorscheme desert
endif

set encoding=utf-8	" Fix the encoding to utf-8

" Source Vim-plug configuration from '.vim-plug' file if available
" More about Vim-plug at https://github.com/junegunn/vim-plug
if filereadable(expand("~/.vim-plug"))
  source ~/.vim-plug
endif

