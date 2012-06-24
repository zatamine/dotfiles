" File : _vimrc
" Version : 1.0
" Author : Amine Haddad (zatamine@gmail.com)
" Created : 22 Jun 2012 14:42

set nocompatible 	" Désactive la compatibilité avec vi

set nu			" Affiche les numéros de lignes 

syntax on 		" Active la coloration syntaxique

set cursorline 		"mettre en évidence la ligne sur laquelle se trouve mon curseur
highlight CursorLine guibg=#001000

set history=100   	" lines of command history

set tabstop=4     	" number of spaces in a tab

set autoindent

set hls

set t_Co=256

let g:zenburn_high_Contrast = 1

colorscheme zenburn 
