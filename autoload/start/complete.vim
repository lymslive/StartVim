" File: complete
" Author: lymslive
" Description: custome complete for command
" Create: 2017-03-23
" Modify: 2017-03-27

" completion for start/*.vim
function! start#complete#vimrc(A, L, P) abort "{{{
    let l:rtp = module#less#rtp#import()

    let l:lpVimrc = l:rtp.GlobFile($STARTHOME, a:A . '*.vim')
    if empty(l:lpVimrc)
        return []
    endif

    call filter(l:lpVimrc, 'v:val !~# "^_" && v:val !~? "^Session*.vim"')
    call map(l:lpVimrc, 'substitute(v:val, "\.vim$", "", "")')
    call map(l:lpVimrc, 'substitute(v:val, "^self-", "", "")')
    call map(l:lpVimrc, 'substitute(v:val, "^vim-", "", "")')
    call uniq(sort(l:lpVimrc))

    return l:lpVimrc
endfunction "}}}

" completion for start/stop/*.vim
function! start#complete#stoprc(A, L, P) abort "{{{
    let l:rtp = module#less#rtp#import()

    let l:pDirectory = l:rtp.AddPath($STARTHOME, 'stop')
    let l:lpVimrc = l:rtp.GlobFile(l:pDirectory, a:A . '*.vim')
    if empty(l:lpVimrc)
        return []
    endif

    call map(l:lpVimrc, 'substitute(v:val, "\.vim$", "", "")')
    call filter(l:lpVimrc, 'v:val !~# "^_"')
    return l:lpVimrc
endfunction "}}}

" pack: 
function! start#complete#pack(A, L, P) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:A . '*')
    call map(l:lpDirectory, 'fnamemodify(v:val, ":t")')
    return l:lpDirectory
endfunction "}}}

function! start#complete#packall(A, L, P) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:A . '*', 1)
    call map(l:lpDirectory, 'fnamemodify(v:val, ":t")')
    return l:lpDirectory
endfunction "}}}

" packfull: 
" > a:1, include star/ as well as opt/ , default only opt/
function! start#complete#packfull(plugin, ...) abort "{{{
    let l:bStarted = get(a:000, 0, 0)

    let l:rtp = module#less#rtp#import()
    let l:pDirectory = l:rtp.MakePath($PACKHOME, '*', 'opt', a:plugin)
    let l:lpDirectory = glob(l:pDirectory, '', 1)
    if empty(l:lpDirectory) && !l:bStarted
        return []
    endif

    if l:bStarted
        let l:pDirStart = l:rtp.MakePath($PACKHOME, '*', 'start', a:plugin)
        let l:lpDirStart = glob(l:pDirStart, '', 1)
        if !empty(l:lpDirStart)
            call extend(l:lpDirectory, l:lpDirStart)
        endif
    endif

    call filter(l:lpDirectory, 'isdirectory(v:val)')
    return l:lpDirectory
endfunction "}}}
