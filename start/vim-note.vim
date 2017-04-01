" File: vim-note
" Author: lymslive
" Description: use vim as note
" Create: 2017-03-25
" Modify: 2017-04-01

" Common Vimrc:
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

" Load Plugin:
packadd StartVim
packadd vimloo
packadd vnote
filetype plugin indent on

nnoremap N :<C-u>NoteNew 
nnoremap T :<C-u>NoteList -T<CR>
