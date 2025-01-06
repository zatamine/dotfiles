set encoding=utf-8

" Leaders
let mapleader=" "
let maplocalleader=","

filetype plugin indent on       " Enabling filetype support indenting
syntax enable                   " Turn on syntax highlighting
set nostartofline               " keep cursor in the same column when moving
set backspace=indent,eol,start  " Backspacing over everything in insert mode
set nomodeline                  " As a security precaution
set autowrite                   " Automatically :write before running commands
set smartindent
set autoindent
set smartcase                   " Only uppercase words with uppercase search term
set incsearch                   " Do incremental searching
set hlsearch                    " Continue to highlight searched phrases
set history=200                 " keep lines of command line history
set ruler                       " Show the cursor position all the time
set showcmd                     " Display incomplete commands
set undofile                    " Automatically saves undo history to an undo file
set undodir=~/.cache/vim/
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
" Enable spell check
set spell
set spelllang=en,fr
set spellsuggest=10
"set complete+=kspell
"set expandtab
"set tabstop=2                 " Maximum columns of whitespace a TAB can take up
"set shiftwidth=2              " Levels of indentation
"set softtabstop=2
"set smarttab
"set clipboard^=unnamed
"set shiftround
set nojoinspaces              " Use one space, not two, after punctuation
set scrolloff=10              " Show a few lines of context around the cursor
set mouse=                  " Mouse disabled, set 'a' to enable in all modes
set ttymouse=                  " Mouse disabled, set 'a' to enable in all modes
set matchpairs+=<:>           " Highlight matching pairs of brackets using '%'
" Store info from no more than 50 files at a time, 9999 lines of text,
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='50,<9999,s100

"" Display options
colorscheme habamax
if filereadable(expand("~/.vim/colors/solarized.vim"))
  set background=light
  colorscheme solarized
endif
set laststatus=2    " Always display the status line
set cursorline      " Show a visual lien under the cursor's current line
set showmatch       " Show matching brackets
set number
set relativenumber
set numberwidth=5
set textwidth=80    " Make it obvious where 80 characters is
set colorcolumn=+1
set list listchars=tab:»·,trail:·,nbsp:· " Display extra white space
"set termguicolors
" Open new split panes to right and bottom
set splitbelow
set splitright
"" Don't wrap text
"set nowrap

"set formatoptions=ronjp
"set formatoptions=tcqrn1

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
"let g:is_posix = 1

""  Keybinding
nnoremap <leader>r :source ~/.vimrc<CR>
" Open explorer
nnoremap <leader>f :Lex<CR>
nnoremap <leader>s :find
nnoremap <leader>w :w<CR>
nnoremap <leader>n :call SwitchBg()<CR>
nnoremap <leader>l :call CycleLineNumbers()<CR>
" Display/hide different types of white spaces
noremap <Leader><Tab><Tab> :set invlist<CR>
" Switch between the last two files
"nnoremap <Leader><Leader> <C-^>
" Opening a terminal window
nnoremap <c-t> :ter<CR>
" Closing the terminal window
tnoremap <c-t> exit<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <silent><ESC><ESC> :nohlsearch<CR>
" Use Q for formatting. Except for Select mode. Revert with ':unmap Q'
map Q gq
sunmap Q

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

:nmap <Up> <Nop>
:nmap <Down> <Nop>
" Map the <Space> key to toggle a selected fold opened/closed.
"nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"vnoremap <Space> zf

"" File Browsing settings
set path+=**
set wildmenu                    " display completion matches in a status line
set wildmode=list:longest,full  " How to complete matched strings
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set completeopt=menu,menuone,noinsert,preview

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_showhide=1
let g:netrw_winsize=20

" add yaml settings
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>

"" Set status line display
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\ 
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function SwitchBg()
  if (&background == "light")
    set background=dark
  else
    set background=light
  endif
endfun

" Toggle/cycle line number modes
function! CycleLineNumbers()
  if (&number == 1 && &relativenumber == 0)
    set relativenumber
  else
    if (&relativenumber == 1 && &number == 1)
      set norelativenumber
      set nonumber
    else
      set number
      set norelativenumber
    endif
  endif
endfunc

" Vim jump to the last position when reopening a file
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" See the difference between the current buffer and the
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

