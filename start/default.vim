" File: vim-note
" Author: lymslive
" Description: server as vimrc for `vim` only
" Create: 2017-03-25
" Modify: 2017-03-25

" Common Vimrc:
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

" Load Plugin:
set rtp+=$PACKHOME/lymslive/opt/StartVim
set rtp+=$PACKHOME/lymslive/opt/vimloo
filetype plugin indent on
