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

" Status line settings 
set laststatus=2        " Always show status line 
source ~/.vim/statusline.vim " Source the statusline settings 

" Highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set hlsearch		" highlight all search matches.
set number		" Show each line with its line number.
"set ruler		" Show the line and column number of the cursor position
set colorcolumn=80	" Highlight column after textwidth
set pastetoggle=<F2>    " turn on off auto indentation on paste
set novisualbell        " Disable beeping
set noerrorbells        " Disbale beeping 
" Tweaks
"set nopaste
"imap jj <ESC>

" Indent
"set smartindent
"set tabstop=4
"set shiftwidth=4
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

" Ident when moving to the next line while writing code 
set autoindent

" Expand tabs into space 
set expandtab

" Show a visual lien under the cursor's current line 
set cursorline


" Undo file
set undofile
set undodir=~/.cache/vim/
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

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

" Open NerdTree automatically when vim start up
"autocmd vimenter * NERDTree

" Toggle NerdTree 
nmap <F6> :NERDTreeToggle<CR>

" enable all python syntax highlithing features 
let python_highlight_all = 1

" YouCompletMe settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" UltiSnips settings 
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file


" syntastic settings 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

