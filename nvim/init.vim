syntax enable

let mapleader = ","

" Vundle Config

set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle/')

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'neomake/neomake'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'github/copilot.vim'

call vundle#end()

filetype plugin indent on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" General Config
set number
set ruler
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4


" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" NERDTree Config
let NERDTreeShowHidden=1

" Neomake Config
call neomake#configure#automake('rw')

" Strip trailing whitespace on save
fun! <SID>StripTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()


