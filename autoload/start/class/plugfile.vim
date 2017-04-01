" Class: start#class#plugfile
" Author: lymslive
" Description: a plugin doc file
" Create: 2017-03-28
" Modify: 2017-04-01

"LOAD:
if exists('s:load') && !exists('g:DEBUG')
    finish
endif

" the line pattern to mark finish
let s:finpat_mktitle = `^\s*#\+\s*finish\s*$`
let s:finpat_vimcommet = `^\s*"\+\s*finish\s*$`
let s:finpat_htmcommet = `^\s*<--\s*finish\s*-->\s*$`

" CLASS:
let s:class = class#old('class#textfile')
let s:class._name_ = 'start#class#plugfile'
let s:class._version_ = 1

function! start#class#plugfile#class() abort "{{{
    return s:class
endfunction "}}}

" NEW:
function! start#class#plugfile#new(...) abort "{{{
    let l:obj = copy(s:class)
    call l:obj._new_(a:000, 1)
    return l:obj
endfunction "}}}
" CTOR:
function! start#class#plugfile#ctor(this, ...) abort "{{{
    if a:0 < 1 || empty(a:1)
        :ELOG 'class#plugfile expect a path'
        return -1
    else
        let l:Suctor = s:class._suctor_()
        call l:Suctor(a:this, a:1)
    endif
endfunction "}}}

" ISOBJECT:
function! start#class#plugfile#isobject(that) abort "{{{
    return s:class._isobject_(a:that)
endfunction "}}}

" Extract: return a list of plugentry object
function! s:class.Extract() dict abort "{{{
    let l:list = self.list()
    let l:line = 0
    let l:ljEntry = []
    for l:entry in l:list
        let l:line += 1
        if l:entry =~? s:finpat_mktitle || l:entry =~? s:finpat_vimcommet || l:entry =~? s:finpat_htmcommet
            break
        endif
        let l:jEntry = start#class#plugentry#new(l:entry)
        if !empty(l:jEntry)
            call l:jEntry.SetLineNo(l:line)
            call add(l:ljEntry, l:jEntry)
        endif
    endfor
    return l:ljEntry
endfunction "}}}

" LOAD:
let s:load = 1
:DLOG '-1 start#class#plugfile is loading ...'
function! start#class#plugfile#load(...) abort "{{{
    if a:0 > 0 && !empty(a:1) && exists('s:load')
        unlet s:load
        return 0
    endif
    return s:load
endfunction "}}}

" TEST:
function! start#class#plugfile#test(...) abort "{{{
    return 0
endfunction "}}}
