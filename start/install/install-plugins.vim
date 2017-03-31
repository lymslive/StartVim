#! /usr/bin/env svex
" ./install-plugins.vim plugin-list-file [update]
" ./install-plugins.vim
" install plugins from a list file, default g:PLUGIN_LIST
" the log information is add to current buffer, 
" and print to stdout if run as svex script (ex -s)

packadd vimloo
packadd StartVim

" the plugin list file
let s:plugins = 'plugins.md'
" whether update if already installed
let s:flag = 0

if v:progname ==? 'ex'
    :LOGON -buffer
    if argc() > 0
        let s:plugins = argv(0)
    endif
    if argc() > 1
        let s:flag = argv(1)
    endif

else
    if exists('g:PLUGIN_LIST')
        let s:plugins = g:PLUGIN_LIST
    else
        :ELOG 'g:PLUGIN_LIST not exists'
        finish
    endif
endif

if !filereadable(s:plugins)
    :ELOG 'plugin list file not exists'
    finish
endif

let s:jPlugMan = start#class#plugman#new(s:plugins)
if empty(s:jPlugMan)
    :ELOG 'Create plugman object fails'
    finish
endif
call s:jPlugMan.Install(s:flag)
