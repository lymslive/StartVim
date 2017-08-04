" Class: start#class#plugentry
" Author: lymslive
" Description: a plugin record in plugin file
" Create: 2017-03-28
" Modify: 2017-08-04

"LOAD:
if exists('s:load') && !exists('g:DEBUG')
    finish
endif

let s:line_pattern = '\<https\?://github\.com/\([^/ ]\+\)/\([^/ ]\+\)\s*$'

let s:mark_install = '+'
let s:mark_uninstall = '-'
let s:mark_update = '*'

" CLASS:
let s:class = class#old()
let s:class._name_ = 'start#class#plugentry'
let s:class._version_ = 1

let s:class.line = 0
let s:class.url = ''
let s:class.words = []

function! start#class#plugentry#class() abort "{{{
    return s:class
endfunction "}}}

" NEW: new(line_string), return newly object, or empty {} if not entry line
function! start#class#plugentry#new(...) abort "{{{
    let l:line = get(a:000, 0, '')
    if l:line !~? s:line_pattern
        return {}
    endif
    let l:obj = class#new(s:class, a:000)
    return l:obj
endfunction "}}}
" CTOR:
function! start#class#plugentry#ctor(this, ...) abort "{{{
    if a:0 < 1 || empty(a:1)
        :ELOG 'class#plugentry#ctor fails as empty line'
        return -1
    endif
    let l:words = split(a:1, '\s\+')
    if empty(l:words)
        :ELOG 'class#plugentry#ctor() fails as empty words'
        return -1
    endif
    let a:this.url = remove(l:words, -1)
    let a:this.words = l:words
endfunction "}}}

" SetLineNo: 
function! s:class.SetLineNo(line) dict abort "{{{
    if a:line > 0
        let self.line = 0 + a:line
    endif
endfunction "}}}

" ISOBJECT:
function! start#class#plugentry#isobject(that) abort "{{{
    return class#isobject(s:class, a:that)
endfunction "}}}

" NeedInstall: 
function! s:class.NeedInstall() dict abort "{{{
    if index(self.words, s:mark_uninstall) != -1
        return v:false
    else
        return v:true
    endif
endfunction "}}}

" NeedUpate: 
function! s:class.NeedUpate() dict abort "{{{
    if index(self.words, s:mark_update) != -1
        return v:true
    else
        return v:false
    endif
endfunction "}}}

" LOAD:
let s:load = 1
:DLOG '-1 start#class#plugentry is loading ...'
function! start#class#plugentry#load(...) abort "{{{
    if a:0 > 0 && !empty(a:1) && exists('s:load')
        unlet s:load
        return 0
    endif
    return s:load
endfunction "}}}

" TEST:
function! start#class#plugentry#test(...) abort "{{{
    return 0
endfunction "}}}
