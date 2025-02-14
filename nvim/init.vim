" Enable syntax highlighting
syntax enable

"Plugin 'neomake/neomake'

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
let g:airline_theme='distinguished'

" Colorscheme
" colorscheme catppuccin-macchiato

" NERDTree Config
let NERDTreeShowHidden=1

" Neomake Config
" call neomake#configure#automake('rw')

" Strip trailing whitespace on save
fun! <SID>StripTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

" 2 Space Indentation by default unless already set
autocmd FileType * setlocal shiftwidth=2 softtabstop=2 expandtab


" Keybindings

" Leader
noremap <Space> <Nop>
let mapleader = " "

"nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wq<CR>
nnoremap <leader>Q :qall!<CR>

lua require ('init')
