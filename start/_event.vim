" auto event command
augroup vimrcEx
    au!
    " Restore the last positon when close
    autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif

    " When write files to noexists path, make the necessary directory.
    " Seems not work
    autocmd! BufWritePre *
                \if !isdirectory(expand("%:p:h") |
                \  call mkdir(expand("%:p:h"), "p") |
                \endif
augroup END

" When Entering the Command window, redefine the <Enter> keyboard locally
augroup CmdWindow
    au!
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

