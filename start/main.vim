" File: main
" Author: lymslive
" Description: $MYVIMRC: ln -s this file to ~/.vimrc
" Create: 2017-03-21
" Modify: 2017-03-31

" Vital Variable: {{{1
let $VIMHOME = $HOME . '/.vim'
if has('win32') || has ('win64')
    let $VIMHOME = $VIM . '/vimfiles'
endif
let $STARTHOME = $VIMHOME . '/start'
let $PACKHOME  = $VIMHOME . '/pack'
let $UNPACKHOME  = $VIMHOME . '/unpack'

let g:START_NAME = v:progname
let g:RUN_NAME = []
let g:PLUGIN_LIST = $STARTHOME . '/install/plugins.md'

" Custom Config: {{{1
let s:dStartAlias = {}
let s:dStartAlias.view = 'vi'
let s:dStartAlias.evim = 'minied'

" Vimrc Tools: {{{1
" Command: source script relative current script file
command! -nargs=1 SOURCE execute 'source ' . expand('<sfile>:p:h') . '/' . <q-args>

" LoadVimrc: return true if load vimrc success
function! s:LoadVimrc(pVimrc) abort "{{{
    if !empty(a:pVimrc) && filereadable(a:pVimrc)
        execute 'source ' . a:pVimrc
        call add(g:RUN_NAME, fnamemodify(a:pVimrc, ':p:t:r'))
        return 1
    else
        return 0
    endif
endfunction "}}}

" ExactVimrc: self-name.vim > name.vim > vim-name.vim
function! s:ExactVimrc(name) abort "{{{
    let l:self = $STARTHOME . '/self-' . a:name . '.vim'
    let l:name = $STARTHOME . '/' . a:name . '.vim'
    let l:vim = $STARTHOME . '/vim-' . a:name . '.vim'
    return s:LoadVimrc(l:self) || s:LoadVimrc(l:name) || s:LoadVimrc(l:vim)
endfunction "}}}

" FuzzyVimrc: self-name*.vim > name*.vim > vim-name*.vim
function! s:FuzzyVimrc(name) abort "{{{
    let l:lpVimrc = glob($STARTHOME . '/self-' . a:name . '*.vim', '', 1)
    if !empty(l:lpVimrc) && s:LoadVimrc(l:lpVimrc[0])
        return 1
    endif

    let l:lpVimrc = glob($STARTHOME . '/' . a:name . '*.vim', '', 1)
    if !empty(l:lpVimrc) && s:LoadVimrc(l:lpVimrc[0])
        return 1
    endif

    let l:lpVimrc = glob($STARTHOME . '/vim-' . a:name . '*.vim', '', 1)
    if !empty(l:lpVimrc) && s:LoadVimrc(l:lpVimrc[0])
        return 1
    endif

    return 0
endfunction "}}}

" DefaultVimrc: self.vim > default.vim
function! s:DefaultVimrc() abort "{{{
    let l:self = $STARTHOME . '/self.vim'
    let l:default = $STARTHOME . '/default.vim'
    return s:LoadVimrc(l:self) || s:LoadVimrc(l:default)
endfunction "}}}

" StartVimrc: 
function! s:StartVimrc(name) abort "{{{
    if s:ExactVimrc(a:name)
        return 1
    endif
    if a:name ==? 'vim' && s:DefaultVimrc()
        return 1
    endif
    return s:FuzzyVimrc(a:name) || s:DefaultVimrc()
endfunction "}}}

" Search Vimrc: {{{1
if v:progname =~? '^vim-.\+'
    let g:START_NAME = substitute(v:progname, '^vim-\c', '', '')
endif

if has_key(s:dStartAlias, g:START_NAME)
    let g:START_NAME = s:dStartAlias[g:START_NAME]
endif

call s:StartVimrc(g:START_NAME)
