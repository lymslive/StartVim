" File: complete
" Author: lymslive
" Description: custome complete for command
" Create: 2017-03-23
" Modify: 2017-03-24

" completion for start/*.vim
function! start#complete#vimrc(A, L, P) abort "{{{
    let l:rpt = module#less#rtp#import()

    let l:lpVimrc = l:rtp.GlobFile($STARTHOME, a:A . '*.vim')
    if empty(l:lpVimrc)
        return []
    endif

    call map(l:lpVimrc, 'substitute(v:val, "\.vim$", "", "")')
    call filter(l:lpVimrc, 'v:val !~# "^-"')
    return l:lpVimrc
endfunction "}}}

" completion for start/stop/*.vim
function! start#complete#stoprc(A, L, P) abort "{{{
    let l:rpt = module#less#rtp#import()

    let l:pDirectory = l:rtp.AddPath($STARTHOME, 'stop')
    let l:lpVimrc = l:rtp.GlobFile(l:pDirectory, a:A . '*.vim')
    if empty(l:lpVimrc)
        return []
    endif

    call map(l:lpVimrc, 'substitute(v:val, "\.vim$", "", "")')
    call filter(l:lpVimrc, 'v:val !~# "^-"')
    return l:lpVimrc
endfunction "}}}

" pack: 
function! start#complete#pack(A, L, P) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:A . '*')
    call map(l:lpDirectory, 'fnamemodify(v:val, ":t")')
    return l:lpDirectory
endfunction "}}}

" packfull: 
function! start#complete#packfull(plugin) abort "{{{
    let l:rpt = module#less#rtp#import()
    let l:pDirectory = l:rpt.MakePath($PACKHOME, '*', 'opt', a:plugin)
    let l:lpDirectory = glob(l:pDirectory, '', 1)
    if empty(l:lpDirectory)
        return []
    endif

    call filter(l:lpDirectory, 'isdirectory(v:val)')
    return l:lpDirectory
endfunction "}}}
