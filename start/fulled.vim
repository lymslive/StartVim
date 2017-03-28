" Full custom vimrc
" lymslive 2016-01-22

source $STARTHOME/_setting.vim
source $STARTHOME/_remap.vim
source $STARTHOME/_event.vim

" Load Plugin:
set rtp+=$PACKHOME/lymslive/opt/StartVim
set rtp+=$VIMHOME/pack/lymslive/opt/vimloo
set rtp+=$VIMHOME/pack/lymslive/opt/EDvsplit
set rtp+=$VIMHOME/pack/lymslive/opt/UseTabpge
set rtp+=$VIMHOME/pack/lymslive/opt/MicroCommand
set rtp+=$VIMHOME/pack/lymslive/opt/Wrap
set rtp+=$VIMHOME/pack/lymslive/opt/vnote
filetype plugin indent on

source $VIMRUNTIME/macros/matchit.vim

" Ultisnips:
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsEnableSnipMate = 1

