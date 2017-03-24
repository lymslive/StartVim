" File: start
" Author: lymslive
" Description: Primary Command for StartVim
" Create: 2017-03-24
" Modify: 2017-03-24

command! -nargs=1 -complete=customlist,start#complete#vimrc
            \ StartVim call start#run(<f-args>)

command! -nargs=1 -complete=customlist,start#complete#stoprc
            \ StopVim call start#stop(<f-args>)

command! -nargs=1 -complete=dir
            \ RtpAdd call start#rtpadd(<f-args>)

command! -nargs=1 -complete=customlist,start#complete#pack
            \ PackAdd call start#packadd(<f-args>)

command! -nargs=1 -complete=customlist,start#complete#pack
            \ PackSub call start#packsub(<f-args>)