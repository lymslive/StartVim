" File: start
" Author: lymslive
" Description: start vim
" Create: 2017-03-23
" Modify: 2017-03-27

" run: start a more run, find vimrc by this name
" > a:1, stop old vimrc
" > a:name, if empty, query started run names
function! start#run(name, ...) abort "{{{
    if empty(a:name)
        echo 'Now started run name g:RUN_NAME=' . string(g:RUN_NAME)
        return 0
    endif

    let l:pVimrc = start#util#FindVimrc(a:name)
    if empty(l:pVimrc)
        echoerr 'cannot find this run name: ' . a:name
        return -1
    endif

    let l:name = fnamemodify(l:pVimrc, ':p:t:r')
    if index(g:RUN_NAME, l:name) != -1
        echomsg 'have already start this run name: ' . a:name
        return 0
    endif

    if a:0 > 0 && !empty(a:1)
        for l:vimrc in g:RUN_NAME
            call start#stop(l:vimrc)
        endfor
    endif

    return start#util#LoadVimrc(l:pVimrc)
endfunction "}}}

" stop: stop a run, call possible code in stop/*.vim
" > a:vimrc the vimrc filename saved in g:RUN_NAME list
function! start#stop(vimrc) abort "{{{
    let l:rtp = module#less#rtp#import()
    let l:pStoprc = l:rtp.MakeFull(l:rtp.MakePath($STARTHOME, 'stop'), l:name, '.vim')
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

    let l:rtp = module#less#rtp#import()
    let l:pDirectory = l:rtp.FixrtpDir(l:pDirectory)
    if !empty(l:pDirectory)
        execute 'set rtp+=' . l:pDirectory
        return 0
    else
        echoerr 'refuse to add rpt as no autoload subdirectory'
        return -1
    endif
endfunction "}}}

" rtp: display rtp list
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

    let l:rtp = module#less#rtp#import()
    let l:pPlugPrev = l:rtp.MakeFull(l:rtp.MakePath($STARTHOME, 'plugon'), l:plugin, '.vim')
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

    let l:pPlugPost = l:rtp.MakeFull(l:rtp.MakePath($STARTHOME, 'plugin'), l:plugin, '.vim')
    if filereadable(l:pPlugPost)
        execute 'source ' . l:pPlugPost
    endif

    return 0
endfunction "}}}

" packsub: remove a rtp and possible source start/plugoff/*.vim
function! start#packsub(plugin) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:plugin, 1)
    for l:pDirectory in l:lpDirectory
        execute 'set rtp -=' . l:pDirectory
    endfor

    if a:plugin =~? '[-.]vim$'
        let l:plugin = strpart(a:plugin, len(a:plugin) - 4)
    else
        let l:plugin = a:plugin
    endif

    let l:rtp = module#less#rtp#import()
    let l:pPlugOff = l:rtp.MakeFull(l:rtp.MakePath($STARTHOME, 'plugoff'), l:plugin, '.vim')
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

" install: install plugin from url
" or update it if existed adn bUpdate is ture
function! start#install(url, bUpdate) abort "{{{
    let l:jPlugin = start#class#plugin#new(a:url)
    return l:jPlugin.Install(a:bUpdate)
endfunction "}}}

" update: update a existed plugin
function! start#update(plugin) abort "{{{
    let l:lpDirectory = start#complete#packfull(a:plugin, 1)
    if empty(l:lpDirectory)
        :ELOG a:plugin . ' not installed, please install from url fist'
        return -1
    elseif len(l:lpDirectory) > 1
        :ELOG a:plugin . ': ambiguous plugins found?'
        return -2
    endif

    let l:pDirectory = l:lpDirectory[0]
    let l:jPlugin = start#class#plugin#new(l:pDirectory)
    return l:jPlugin.Update()
endfunction "}}}

" test: 
function! start#test() abort "{{{
    " code
endfunction "}}}
