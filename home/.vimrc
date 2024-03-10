set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-smooth-scroll'

call vundle#end()
filetype plugin indent on

set scrolloff=7
syntax on
set mouse=a
set autoindent

" sane tab behaviour
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" enable line numbers
set number

" disable bells
set noerrorbells
set novisualbell

" don't continue comment in new line
set formatoptions-=ro

" wrap arrowskeys
set whichwrap+=<,>,h,l,[,]

" keybindings
" move selected line
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-UP> <Esc>:m .-2<CR>==gi

nnoremap <CR> o<Esc>
nnoremap <BS> X

" unbind q
noremap q :q

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>

