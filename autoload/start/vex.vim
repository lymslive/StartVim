" File: vex
" Author: lymslive
" Description: functions for vex and svex script
" Create: 2017-03-28
" Modify: 2017-03-29

" echo: add msg string to end of buffer and print it
" can used in 'ex -s' script to output something to stdout
function! start#vex#echo(msg) abort "{{{
    call append('$', a:msg)
    $print
endfunction "}}}
