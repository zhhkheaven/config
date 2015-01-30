set nocompatible              " be iMproved, required
filetype off                  " required
syntax enable
"airline
set laststatus=2
let g:airline_left_sep='>'
let g:airline_right_sep='<'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_iminsert=0
let g:airline_inactive_collapse=1
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'
let g:airline#extensions#tabline#enabled = 1
set t_Co=256
set encoding=utf-8
"shorcut
:map <C-j> <Esc>
:imap <C-j> <Esc>
:map <F5> <Esc>:tabprevious<CR>
:map <F6> <Esc>:tabnext<CR>
map ^T :tabnew .<CR>
:imap <F5> <ESC>:tabprevious<CR>i
:imap <F6> <ESC>:tabnext<CR>i
:imap ^T <ESC>:tabnew .<CR>i
":map <C-s>   <Esc>:w<CR>
":imap <C-s> <Esc>:w<CR>i
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'bling/vim-airline'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/syntastic'
call vundle#end()            " required
filetype plugin indent on    " required
