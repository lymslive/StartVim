" Class: start#class#plugin
" Author: lymslive
" Description: object to describe a plugin
" Create: 2017-03-27
" Modify: 2017-03-28

"LOAD:
if exists('s:load') && !exists('g:DEBUG')
    finish
endif

if !exists('$PACKHOME')
    let $PACKHOME = expand('~/.vim/pack')
endif
if !exists('$UNPACKHOME')
    let $UNPACKHOME = expand('~/.vim/unpack')
endif

let s:url_pattern = 'https\?://github\.com/\([^/ ]\+\)/\([^/ ]\+\)'

" CLASS:
let s:class = class#old()
let s:class._name_ = 'start#class#plugin'
let s:class._version_ = 1

" the url in github
let s:class.url = ''
" author and name can extract from url
let s:class.author = ''
let s:class.name = ''
" the local path where installed
let s:class.path = ''

function! start#class#plugin#class() abort "{{{
    return s:class
endfunction "}}}

" NEW: new(url); new(author, name); new(path)
function! start#class#plugin#new(...) abort "{{{
    let l:obj = copy(s:class)
    call l:obj._new_(a:000, 1)
    return l:obj
endfunction "}}}
" CTOR:
function! start#class#plugin#ctor(this, ...) abort "{{{
    if a:0 < 1 || empty(a:1)
        :ELOG 'start#class#plugin#new() expect argument'
        return -1
    endif

    if a:0 == 1
        let l:lsMatch = matchlist(a:1, s:url_pattern)
        if empty(l:lsMatch)
            let a:this.path = a:1
        else
            let a:this.url = a:1
            let a:this.author = l:lsMatch[1]
            let a:this.name = l:lsMatch[2]
        endif
    elseif a:0 >= 2
        let a:this.author = a:1
        let a:this.name = a:2
    endif
endfunction "}}}

" ISOBJECT:
function! start#class#plugin#isobject(that) abort "{{{
    return s:class._isobject_(a:that)
endfunction "}}}

" LongName: 
function! s:class.LongName() dict abort "{{{
    return self.author . '/' . self.name
endfunction "}}}

" RelativePath: 
function! s:class.RelativePath() dict abort "{{{
    let l:pInstall = self.FindInstalled()
    if empty(l:pInstall)
        return ''
    endif
    let l:iHead = len($PACKHOME)
    return strpart(l:pInstall, l:iHead + 1)
endfunction "}}}

" IsInstalled: 
function! s:class.IsInstalled() dict abort "{{{
    return isdirectory(self.path)
endfunction "}}}

" FindInstalled: find installed direcotry from author and name
function! s:class.FindInstalled() dict abort "{{{
    if isdirectory(self.path)
        return self.path
    endif

    let l:rtp = module#less#rtp#import()
    let l:pPackStart = l:rtp.MakePath($PACKHOME, self.author, 'start', self.name)
    let l:pPackOpt = l:rtp.MakePath($PACKHOME, self.author, 'opt', self.name)
    if isdirectory(l:pPackStart)
        let self.path = l:pPackStart
    elseif isdirectory(l:pPackOpt)
        let self.path = l:pPackOpt
    endif
    return self.path
endfunction "}}}

" Install: 
function! s:class.Install(bUpdate) dict abort "{{{
    let l:rtp = module#less#rtp#import()
    let l:pInstall = self.FindInstalled()
    if !empty(l:pInstall)
        if bUpdate
            let l:iErr = self.GitPull(l:pInstall)
        else
            :WLOG 'already installed, please use update: ' . self.LongName()
            return 0
        endif
    else
        let l:pInstall = l:rtp.MakePath($PACKHOME, self.author, 'opt', self.name)
        let l:iErr = self.GitClone(l:pInstall)
        if l:iErr == 0
            let self.path = l:pInstall
        endif
    endif
    if l:iErr == 0
        let l:pDoc = l:rtp.MakePath(l:pInstall, 'doc')
        if isdirectory(l:pDoc)
            let l:cmd = 'helptags ' . l:pDoc
            :LOG l:cmd
            execute l:cmd
        endif
    endif
    return l:iErr
endfunction "}}}

" Update: 
function! s:class.Update() dict abort "{{{
    return self.Install(v:true)
endfunction "}}}

" Uninstall: 
function! s:class.Uninstall() dict abort "{{{
    let l:pInstall = self.FindInstalled()
    let l:pRelative = self.RelativePath()
    let l:rtp = module#less#rtp#import()
    let l:pUninstall = l:rtp.PutPath(l:pRelative, $UNPACKHOME)

    let l:pDirectory = fnamemodify(l:pUninstall, ':p:h')
    if !isdirectory(l:pDirectory)
        call mkdir(l:pDirectory, 'p')
    endif

    let l:cmd = printf('mv %s %s', l:pInstall, l:pUninstall)
    call system(l:cmd)
    if v:shell_error != 0
        :ELOG 'fails to uninstall plugin: ' . self.LongName()
    else
        :WLOG 'success to uninstall plugin: ' . self.LongName()
    endif
    return v:shell_error
endfunction "}}}

" GitPull: 
function! s:class.GitPull(pInstall) dict abort "{{{
    let l:cwd = getcwd()
    try
        execute 'cd ' . a:pInstall
        let l:cmd = 'git pull'
        :LOG l:cmd
        call system(l:cmd)
    catch 
        :ELOG 'fails to update plugin: ' . self.LongName()
    finally
        execute 'cd ' . l:cwd
        let l:iErr = v:shell_error
    endtry
    return l:iErr
endfunction "}}}

" GitClone: 
function! s:class.GitClone(pInstall) dict abort "{{{
    let l:pDirectory = fnamemodify(a:pInstall, ':p:h')
    if !isdirectory(l:pDirectory)
        call mkdir(l:pDirectory, 'p')
    endif

    let l:cwd = getcwd()
    try
        execute 'cd ' . l:pDirectory
        let l:cmd = 'git clone ' . self.url
        :LOG l:cmd
        call system(l:cmd)
    catch 
        :ELOG 'fails to install plugin: ' . self.LongName()
    finally
        execute 'cd ' . l:cwd
        let l:iErr = v:shell_error
    endtry
    return l:iErr
endfunction "}}}

" Load: load this plugin
function! s:class.Load() dict abort "{{{
    " code
endfunction "}}}

" Unload: 
function! s:class.Unload() dict abort "{{{
    " code
endfunction "}}}

" LOAD: load control of this script
let s:load = 1
:DLOG '-1 start#class#plugin is loading ...'
function! start#class#plugin#load(...) abort "{{{
    if a:0 > 0 && !empty(a:1) && exists('s:load')
        unlet s:load
        return 0
    endif
    return s:load
endfunction "}}}

" TEST:
function! start#class#plugin#test(...) abort "{{{
    let l:obj = start#class#plugin#new('https://github.com/lymslive/vimloo')
    " let l:obj = start#class#plugin#new()
    echo l:obj.url
    echo l:obj.author
    echo l:obj.name
    return 0
endfunction "}}}
