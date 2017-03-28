" File: vcide
" Author: lymslive
" Description: vimrc for coder
" Create: 2017-03-20
" Modify: 2017-03-26

" Common Vimrc:
source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

set shiftwidth=4
set softtabstop=4
set tabstop=4
set noignorecase
set tagcase=match
set nowrap
set formatoptions-=t

" Load Plugin:
source $VIMRUNTIME/macros/matchit.vim

source $STARTHOME/plug_cide.vim
filetype plugin indent on

" read .vim in current dir
set exrc
set secure
