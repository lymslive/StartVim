#! /usr/bin/env vex

packadd vimloo
packadd StartVim

let s:plugins = ''
if exists('g:PLUGIN_LIST')
    let s:plugins = g:PLUGIN_LIST
else
    if argc() > 0
        let s:plugins = argv(0)
    else
        echo 'g:PLUGIN_LIST not exists'
    endif
endif

let s:jPlugMan = start#class#plugman#new(s:plugins)
if empty(s:jPlugMan)
    finish
endif
call s:jPugMan.Install()
