#! /usr/bin/env svex
" ./install-plugins.vim plugin-list-file
" ./install-plugins.vim
" install plugins from a list file, default g:PLUGIN_LIST
" the log information is add to current buffer, 
" and print to stdout if run as svex script (ex -s)

packadd vimloo
packadd StartVim

:LOGON -buffer

let s:plugins = ''
if argc() > 0 && v:progname ==? 'ex'
    let s:plugins = argv(0)
else
    if exists('g:PLUGIN_LIST')
        let s:plugins = g:PLUGIN_LIST
    else
        :LOG 'g:PLUGIN_LIST not exists'
    endif
endif

let s:jPlugMan = start#class#plugman#new(s:plugins)
if empty(s:jPlugMan)
    finish
endif
call s:jPugMan.Install()
