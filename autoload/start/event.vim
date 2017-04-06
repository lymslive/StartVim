" File: event
" Author: lymslive
" Description: auto event handle
" Create: 2017-04-05
" Modify: 2017-04-06

" FuncUndefined: 
" autoload sharp function even not in rpt now but in some pack
" add the plugin root to rtp, then let vim builtin lookup it further
function! start#event#FuncUndefined(name) abort "{{{
    if a:name =~# '^start#' || a:name =~# '^module#' || has('vim_starting')
        return 0
    endif

    let l:lsPath = split(a:name, '#')
    if len(l:lsPath) < 2
        return -1
    endif

    call remove(l:lsPath, -1)
    let l:rtp = module#less#rtp#import()
    let l:pFile = join(l:lsPath, l:rtp.separator) . '.vim'

    let l:lpDirectory = start#complete#packfull('*', 1)
    for l:pDirectory in l:lpDirectory
        let l:pPath = l:rtp.MakePath(l:pDirectory, 'autoload', l:pFile)
        if filereadable(l:pPath)
            " directly source this file will cause error massege
            " execute 'source ' . l:pPath
            return start#rtpadd(l:pDirectory, 1)
        endif
    endfor

    return -1
endfunction "}}}
