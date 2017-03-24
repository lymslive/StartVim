" File: start
" Author: lymslive
" Description: start vim
" Create: 2017-03-23
" Modify: 2017-03-24

" run: add a more vimrc
" > a:1, stop old run
function! start#run(vimrc, ...) abort "{{{
    if match(g:RUN_NAME, a:vimrc) != -1
        echomsg 'the vimrc already sourced: ' . a:vimrc
        return -1
    endif

    let l:rtp = module#less#rtp#import()
    let l:pVimrc = l:rtp.MakeFull($STARTHOME, a:vimrc, '.vim')
    if !filereadable(l:pVimrc)
        echoerr 'cannot source vimrc: ' . l:pVimrc
        return -1
    endif

    " may stop old vimrc run
    if a:0 > 0 && !empty(a:1)
        for l:vimrc in g:RUN_NAME
            call start#stop(l:vimrc)
        endfor
    endif

    " source this vimrc run
    execute 'source ' . l:pVimrc
    call add(g:RUN_NAME, a:vimrc)
    echomsg 'start vimrc: ' . l:pStoprc
    echo 'now g:RUN_NAME = ' . string(g:RUN_NAME)
    return 0
endfunction "}}}

" stop: stop a runname {a:vimrc}
function! start#stop(vimrc) abort "{{{
    let l:pStoprc = $STARTHOME . '/stop/' . a:vimrc . '.vim'
    if filereadable(l:pStoprc)
        execute 'source ' . l:pStoprc
        echomsg ' stop vimrc: ' . l:pStoprc
    endif
endfunction "}}}

" rtpadd: add a path(default pwd) to rtp, fix upto autoload/
function! start#rtpadd(...) abort "{{{
    if a:0 == 0 || empty(a:1)
        let l:pDirectory = expand('%:p:h')
    else
        let l:pDirectory = a:1
    endif

    if l:pDirectory =~# '/autoload'
        let l:rtp = substitute(l:pDirectory, '/autoload/\?.*$', '', '')
        execute 'set rtp+=' . l:rtp
        return 0
    else
        echoerr 'refuse to add rpt as no autoload subdirectory'
        return -1
    endif
endfunction "}}}

" rtp: 
function! start#rtp() abort "{{{
    let l:lpDirectory = split(&rtp, ',')
    echo 'runtime path list: ' . len(l:lpDirectory)
    let l:iCount = 0
    for l:pDirectory in l:lpDirectory
        let l:iCount += 1
        echo l:iCount . "\t" . l:pDirectory
    endfor
endfunction "}}}

" packadd: 
" 1. source $STARTHOME/plugon/{plugin}.vim
" 2. packadd {plugin}
" 3. source $STARTHOME/plugin/{plugin}.vim
" in 1&3 step, strip '.vim' and '-vim' suffix in plugin name
function! start#packadd(plugin) abort "{{{
    if a:plugin =~? '[-.]vim$'
        let l:plugin = strpart(a:plugin, len(a:plugin) - 4)
    else
        let l:plugin = a:plugin
    endif

    let l:pPlugPrev = $STARTHOME . '/plugon/' . l:plugin . '.vim'
    if filereadable(l:pPlugPrev)
        execute 'source ' . l:pPlugPrev
    endif

    try
        if exists(':packadd')
            execute 'packadd ' . a:plugin
        else
            call s:_packadd(a:plugin)
        endif
    catch 
        echoerr '[startvim] fail to ackadd ' . a:plugin
        return -1
    endtry

    let l:pPlugPost = $STARTHOME . '/plugin/' . l:plugin . '.vim'
    if filereadable(l:pPlugPost)
        execute 'source ' . l:pPlugPost
    endif

    return 0
endfunction "}}}

" packsub: 
function! start#packsub(plugin) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:plugin)
    for l:pDirectory in l:lpDirectory
        execute 'set rtp -=' . l:pDirectory
    endfor

    if a:plugin =~? '[-.]vim$'
        let l:plugin = strpart(a:plugin, len(a:plugin) - 4)
    else
        let l:plugin = a:plugin
    endif

    let l:pPlugOff = $STARTHOME . '/plugoff/' . l:plugin . '.vim'
    if filereadable(l:pPlugOff)
        execute 'source ' . l:pPlugOff
    endif
endfunction "}}}

" _packadd: simulate packadd below v8.0
function! s:_packadd(plugin) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:plugin)
    if len(l:lpDirectory) > 0
        let l:pDirectory = l:lpDirectory[0]
        if stridx(&rtp, l:pDirectory) != -1
            echomsg 'plugin already in rtp: ' . a:plugin
        else
            execute 'set rtp+=' . l:pDirectory
            execute 'runtime! ' . l:pDirectory . '/plugin/**/*.vim'
        endif
        return 0
    else
        echoerr 'plugin not in pack/*/opt/' . a:plugin
        return -1
    endif
endfunction "}}}

" install: install plugin from github url
" full url suach as: https://github.com/tpope/vim-scriptease
function! start#install(url) abort "{{{
    let l:sPattern = 'https\?://github\.com/\(\w\+\)/\(\w\+\)'
    let l:lsMatch = matchlist(a:url, l:sPattern)
    if empty(l:lsMatch)
        echoerr 'expect a valid full github url'
        return -1
    endif

    let l:author = l:lsMatch[1]
    let l:repos  = l:lsMatch[2]

    let l:pPackStart = $PACKHOME . '/' . l:author . '/start/' . l:repos
    let l:pPackOpt = $PACKHOME . '/' . l:author . '/opt/' . l:repos
    if isdirectory(l:pPackStart)
        echomsg 'plugin already install in: ' . l:pPackStart
        return 0
    endif
    if isdirectory(l:pPackOpt)
        echomsg 'plugin already install in: ' . l:pPackOpt
        return 0
    endif

    let l:pDirOpt = $PACKHOME . '/' . l:author . '/opt'
    if !isdirectory(l:pDirOpt)
        call mkdir(l:pDirOpt, 'p')
    endif

    let l:cwd = getcwd()
    let l:iErr = 0
    try
        execute 'cd ' . l:pDirOpt
        execute '!git clone ' . a:url
        execute 'helptags ' . l:repos . '/doc'
        execute 'cd ' . l:cwd
        echomsg 'success install plugin: ' . a:url
    catch 
        echomsg 'fails install plugin: ' . a:url
        let l:iErr = -1
    endtry

    return l:iErr
endfunction "}}}

" test: 
function! start#test() abort "{{{
    " code
endfunction "}}}
