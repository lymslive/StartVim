" File: util
" Author: lymslive
" Description: 
" Create: 2017-03-25
" Modify: 2017-03-25

" ValidVimrc: 
function! s:ValidVimrc(pVimrc) abort "{{{
    return !empty(a:pVimrc) && filereadable(a:pVimrc)
endfunction "}}}

" ExactVimrc: self-name.vim > name.vim > vim-name.vim
function! s:ExactVimrc(name) abort "{{{
    let l:self = $STARTHOME . '/self-' . a:name . '.vim'
    let l:name = $STARTHOME . '/' . a:name . '.vim'
    let l:vim = $STARTHOME . '/vim-' . a:name . '.vim'
    if s:ValidVimrc(l:self)
        return l:self
    elseif s:ValidVimrc(l:name)
        return l:name
    elseif s:ValidVimrc(l:vim)
        return l:vim
    else
        return ''
    endif
endfunction "}}}

" FuzzyVimrc: self-name*.vim > name*.vim > vim-name*.vim
function! s:FuzzyVimrc(name) abort "{{{
    let l:lpVimrc = glob($STARTHOME . '/self-' . a:name . '*.vim', '', 1)
    if !empty(l:lpVimrc) && s:ValidVimrc(l:lpVimrc[0])
        return l:lpVimrc[0]
    endif

    let l:lpVimrc = glob($STARTHOME . '/' . a:name . '*.vim', '', 1)
    if !empty(l:lpVimrc) && s:ValidVimrc(l:lpVimrc[0])
        return l:lpVimrc[0]
    endif

    let l:lpVimrc = glob($STARTHOME . '/vim-' . a:name . '*.vim', '', 1)
    if !empty(l:lpVimrc) && s:ValidVimrc(l:lpVimrc[0])
        return l:lpVimrc[0]
    endif

    return ''
endfunction "}}}

" FindVimrc: return the found vimrc full path, or ''
function! start#util#FindVimrc(name) abort "{{{
    let l:pVimrc = s:ExactVimrc(a:name)
    if !empty(l:pVimrc)
        return l:pVimrc
    endif
    let l:pVimrc = s:FuzzyVimrc(a:name)
    if !empty(l:pVimrc)
        return l:pVimrc
    endif
    return ''
endfunction "}}}

" LoadVimrc: return error code for loading vimrc
function! start#util#LoadVimrc(pVimrc) abort "{{{
    if !empty(a:pVimrc) && filereadable(a:pVimrc)
        execute 'source ' . a:pVimrc
        echomsg 'start vimrc: ' . a:pVimrc
        call add(g:RUN_NAME, fnamemodify(a:pVimrc, ':p:t:r'))
        return 0
    else
        return -1
    endif
endfunction "}}}
