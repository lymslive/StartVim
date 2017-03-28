set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
set noloadplugins
set nocompatible
set incsearch
set hlsearch
set showcmd
set ruler
colorschem desert
syntax on

" resemble fast viewer, further vimrc will override them.
nnoremap w :update<cr>w
nnoremap q :quit<cr>
nnoremap z <C-Z>
nnoremap <CR> :

" transfer to minied rc
autocmd! InsertEnter * mapclear | source $STARTHOME/minied.vim | autocmd! InsertEnter
" transfer to fulled rc
nnoremap <Tab> :mapclear<CR>:source $STARTHOME/fulled.vim<CR>

"EOF vim:tw=78:sts=4:ft=vim:fdm=marker:
