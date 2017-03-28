#! /usr/bin/env vex

packadd vimloo
packadd StartVim

let l:jPlugMan = start#class#plugman#instance()
if empty(l:jPlugMan)
    finish
endif
call l:jPugMan.Install()
