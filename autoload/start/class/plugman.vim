" Class: start#class#plugman
" Author: lymslive
" Description: VimL class frame
" Create: 2017-03-27
" Modify: 2017-03-27

"LOAD:
if exists('s:load') && !exists('g:DEBUG')
    finish
endif

" CLASS:
let s:class = class#old()
let s:class._name_ = 'start#class#plugman'
let s:class._version_ = 1

" the doc file that list all all plugins
let s:class.plugin_doc = ''

function! start#class#plugman#class() abort "{{{
    return s:class
endfunction "}}}

" NEW:
function! start#class#plugman#new(...) abort "{{{
    let l:obj = copy(s:class)
    call l:obj._new_(a:000, 1)
    return l:obj
endfunction "}}}
" CTOR:
function! start#class#plugman#ctor(this, ...) abort "{{{
    if a:0 > 0 && !empty(a:1)
        let a:this.plugin_doc = expand(a:1)
        if !filereadable(a:this.plugin_doc)
            :ELOG 'plugin file is invalid: ' . a:1
            return -1
        endif
    else
        :ELOG 'class#plugman#new() expect a file path'
        return -1
    endif
endfunction "}}}

" ISOBJECT:
function! start#class#plugman#isobject(that) abort "{{{
    return s:class._isobject_(a:that)
endfunction "}}}

" INSTANCE:
let s:instance = {}
function! start#class#plugman#instance() abort "{{{
    if !exists('g:PLUGIN_LIST')
        :ELOG 'g:PLUGIN_LIST not exists'
        return {}
    endif

    if empty(s:instance)
        let s:instance = class#new('start#class#plugman', g:PLUGIN_LIST)
    endif
    return s:instance
endfunction "}}}

" Install: install all plugins
function! s:class.Install(bUpdate) dict abort "{{{
    " code
endfunction "}}}

" Update: 
function! s:class.Update() dict abort "{{{
    call self.Install(v:true)
endfunction "}}}

" LOAD:
let s:load = 1
:DLOG '-1 start#class#plugman is loading ...'
function! start#class#plugman#load(...) abort "{{{
    if a:0 > 0 && !empty(a:1) && exists('s:load')
        unlet s:load
        return 0
    endif
    return s:load
endfunction "}}}

" TEST:
function! start#class#plugman#test(...) abort "{{{
    return 0
endfunction "}}}
