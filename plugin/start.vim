" File: start
" Author: lymslive
" Description: Primary Command for StartVim
" Create: 2017-03-24
" Modify: 2017-03-25

command! -nargs=1 -bang -complete=customlist,start#complete#vimrc
            \ StartVim call start#run(<f-args>, '<bang>')

command! -nargs=1 -complete=customlist,start#complete#stoprc
            \ StopVim call start#stop(<f-args>)

command! RtpShow call start#rtp()
command! -nargs=1 -complete=dir
            \ RtpAdd call start#rtpadd(<f-args>)

command! -nargs=1 -complete=customlist,start#complete#pack
            \ PackAdd call start#packadd(<f-args>)

command! -nargs=1 -complete=customlist,start#complete#pack
            \ PackSub call start#packsub(<f-args>)
