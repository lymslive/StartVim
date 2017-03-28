" Class: start#class#plugman
" Author: lymslive
" Description: VimL class frame
" Create: 2017-03-27
" Modify: 2017-03-28

"LOAD:
if exists('s:load') && !exists('g:DEBUG')
    finish
endif

" CLASS:
let s:class = class#old()
let s:class._name_ = 'start#class#plugman'
let s:class._version_ = 1

" the doc file that list all all plugins
let s:class.filepath = ''
let s:class.fileobj = {}

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
        let a:this.filepath = expand(a:1)
        if !filereadable(a:this.filepath)
            :ELOG 'plugin file is invalid: ' . a:1
            return -1
        endif
        let a:this.fileobj = start#class#plugfile#new(a:this.filepath)
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
    let l:ljEntry = self.fileobj.Extract()
    if empty(l:ljEntry)
        :WLOG 'no plugin list in: ' . self.filepath
        return 0
    endif

    let l:iCount = len(l:ljEntry)
    let l:idx = 0
    for l:jEntry in l:ljEntry
        let l:idx += 1
        if !l:jEntry.NeedInstall()
            continue
        endif
        let l:url =  l:jEntry.url
        let l:jPlugin = start#class#plugin#new(l:url)
        :LOG printf('%d/%d: %s', l:idx, l:iCount, l:url)
        let l:bUpdate = l:jEntry.NeedUpate()
        call l:jPlugin.Install(a:bUpdate || l:bUpdate)
    endfor
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
    let l:jObj = start#class#plugman#instance()
    let l:ljEntry = l:jObj.fileobj.Extract()
    let l:iCount = len(l:ljEntry)
    let l:idx = 0
    for l:jEntry in l:ljEntry
        let l:idx += 1
        if !l:jEntry.NeedInstall()
            continue
        endif
        let l:url =  l:jEntry.url
        :LOG printf('%d/%d: %s', l:idx, l:iCount, l:url)
    endfor
    return 0
endfunction "}}}
