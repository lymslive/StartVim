" File: start
" Author: lymslive
" Description: start vim
" Create: 2017-03-23
" Modify: 2017-03-23

" run: add a more vimrc
function! start#run(vimrc) abort "{{{
    if match(g:RUN_NAME, a:vimrc) != -1
        echomsg 'the vimrc already sourced: ' . a:vimrc
        return -1
    endif

    let l:pVimrc = $STARTHOME . '/' . a:vimrc . '.vim'
    if filereadable(l:pVimrc)
        execute 'source ' . l:pVimrc
        call add(g:RUN_NAME, a:vimrc)
        echomsg 'now g:RUN_NAME = ' . string(g:RUN_NAME)
        return 0
    else
        echoerr 'cannot source vimrc: ' . l:pVimrc
        return -1
    endif
endfunction "}}}

" runas: replace vimrc
function! start#runas(vimrc) abort "{{{
    let l:pVimrc = $STARTHOME . '/' . a:vimrc . '.vim'
    if !filereadable(l:pVimrc)
        echoerr 'cannot source vimrc: ' . l:pVimrc
        return -1
    endif

    for l:vimrc in g:RUN_NAME
        let l:pStoprc = $STARTHOME . '/stop/' . l:vimrc . '.vim'
        if filereadable(l:pStoprc)
            execute 'source ' . l:pStoprc
            echomsg 'source stop vimrc: ' . l:pStoprc
        endif
    endfor

    execute 'source ' . l:pVimrc
    call add(g:RUN_NAME, a:vimrc)
    return 0
endfunction "}}}

" packadd: 
function! start#packadd(plugin) abort "{{{
    let l:pPlugPrev = $STARTHOME . '/plugin_prev/' . a:plugin . '.vim'
    if filereadable(l:pPlugPrev)
        execute 'source ' . l:pPlugPrev
    endif

    if exists(':packadd')
        execute 'packadd ' . a:plugin
    else
        call s:_packadd()
    endif

    let l:pPlugPost = $STARTHOME . '/plugin_post/' . a:plugin . '.vim'
    if filereadable(l:pPlugPost)
        execute 'source ' . l:pPlugPost
    endif

    return 0
endfunction "}}}

" _packadd: simulate packadd below v8.0
function! s:_packadd(plugin) abort "{{{
    let l:lpDirectory = glob($PACKHOME . '/*/opt/' . a:plugin, '', 1)
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

    let l:iErr = 0
    try
        execute 'cd ' . l:pDirOpt
        execute '!git clone' . a:url
        echomsg 'success install plugin: ' . a:url
    catch 
        echomsg 'fails install plugin: ' . a:url
        let l:iErr = -1
    endtry

    return l:iErr
endfunction "}}}
