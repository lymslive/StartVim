cabbrev f. cs find f
cabbrev u. Unite
cabbrev n. normal!
cnoremap <C-Ins> <C-R>*
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-f> <Right>
cnoremap <C-o> <Up>
cnoremap <C-j> <Down>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>
cnoremap <C-x><C-a>      <C-a>
cnoremap <C-x><C-d>      <C-d>
cnoremap <C-x><C-k>      <C-k>
cnoremap <C-x><C-l>      <C-l>
cnoremap <C-x>w <C-R>=expand('<cword>')<CR>
cnoremap <C-x>W <C-R>=expand('<cWORD>')<CR>
cnoremap <C-x>l <C-R>=getline('.')<CR>
cnoremap <C-x>p <C-R>=expand('%:p')<CR>
cnoremap <C-x>t <C-R>=expand('%:p:t')<CR>
cnoremap <C-t> <C-F>
cnoremap <C-y> <C-R>"
cnoremap <S-Ins> <C-R>+
cnoremap <Esc>b <C-Left>
cnoremap <Esc>f <C-Right>

iabbrev Date= <C-R>=strftime("20%y-%m-%d %H:%M:%S")<CR>
iabbrev cwd= <C-R>=getcwd()<CR>
iabbrev date= <C-R>=strftime("20%y-%m-%d")<CR>
inoremap <C-/> <C-o>u
inoremap <C-BS> <C-w>
inoremap <C-Ins> <C-R>+
inoremap <C-^> <C-y>
inoremap <C-_> <C-o>u
inoremap <C-a> <C-o>I
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <C-o>A
inoremap <C-f> <Right>
inoremap <C-k> <C-o>d$
inoremap <C-l> <C-X><C-L>
inoremap <C-;> <C-X><C-P>
inoremap <C-'> <C-X><C-N>
inoremap <C-n> <Down>
inoremap <C-p> <C-X><C-P>
inoremap <C-t> <C-X><C-]>
inoremap <C-,> <C-X><C-K>
inoremap <C-.> <C-X><C-O>
inoremap <C-u> <C-o>@=(col('.')==col('$')-1)? "d0x" : "d0"<CR>
inoremap <C-y> <C-R>"
inoremap <S-Ins> <C-R>*

nnoremap ' `
nnoremap ` '
nnoremap + "+
nnoremap 0 "0
nnoremap - :move +1<CR>
nnoremap _ :move -2<CR>
nnoremap ,O :call append(line(".")-1, "")<CR>
nnoremap ,o :call append(line("."), "")<CR>
nnoremap ;' :marks<CR>
nnoremap ;, ,
nnoremap ;; ;
nnoremap ;B :buffers<CR>:buffer 
nnoremap ;D :bdelete<CR>
nnoremap ;E :e ~/.vim/buffer<CR>:set buftype=nowrite<CR>
nnoremap ;G gwap 
nnoremap ;M :move 0<CR>
nnoremap ;O m':copy -1<CR>`'k
nnoremap ;P :copy 0<CR>
nnoremap ;Q :wall<CR>:qall!<CR>
nnoremap ;R :source Session.vim
nnoremap ;S :execute 'mksession! ' . v:this_session <CR>
nnoremap ;W :wall<CR>
nnoremap ;a ggVG
nnoremap ;b :e #<CR>
nnoremap ;d :bdelete<Space>
nnoremap ;e :e $MYVIMRC<CR>
nnoremap ;g gqap 
nnoremap ;j mz:m+<CR>`z
nnoremap ;k mz:m-2<CR>`z
nnoremap ;m :move $<CR>
nnoremap ;n :enew<CR>
nnoremap ;o m':copy .<CR>`'j
nnoremap ;p :copy $<CR>
nnoremap ;q :quit<CR>
nnoremap ;r :reg<CR>
nnoremap ;s :saveas <C-R>=expand("%<")<CR>
nnoremap ;t :tags<CR>
nnoremap ;w :update<CR>
nnoremap ;z zA
nnoremap <C-g> :botright cwindow<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>
nnoremap <C-S-j> 12<C-e>
nnoremap <C-S-k> 12<C-y>
" nnoremap <CR> :
nnoremap <CR> : <C-R>=expand("<cword>")<CR><Home>
nnoremap <S-CR> :<UP>
nnoremap <S-Ins> "*p
nnoremap <Space>   @=(foldlevel(line('.'))>0) ? "za" : "}"<CR>
nnoremap P P=`]`]
nnoremap p p=`]`]
nnoremap Y y$
noremap H ^
noremap L $
nnoremap g<C-j> L
nnoremap g<C-k> H
nnoremap j gj
nnoremap k gk
nnoremap \<BS> :set columns=80<Bar>set lines=25<CR>
nnoremap \D :echo(expand('%:p'))<CR>
nnoremap \d :lcd %:p:h<CR>
nnoremap \q :cclose<CR>
nnoremap \Q :botright copen<CR>
noremap <BS> ^
noremap <S-BS> $
onoremap <S-Space> {
onoremap <Space>   }

vnoremap + "+
vnoremap - "*
vnoremap / y/<C-\>e (visualmode() != 'v')? "" : getreg()<CR>
vnoremap ;H y^P
vnoremap ;L y$p
vnoremap ;M :move 0<CR>
vnoremap ;O :copy -1<CR>
vnoremap ;P :copy 0<CR>
vnoremap ;h d^P
vnoremap ;l d$p
vnoremap ;m :move $<CR>
vnoremap ;o :copy '><CR>
vnoremap ;p :copy $<CR>
vnoremap ;j :m'>+<CR>`<my`>mzgv`yo`z
vnoremap ;k :m'<-2<CR>`>my`<mzgv`yo`z
vnoremap <C-CR> ygv:@"<CR>
vnoremap <C-Del> "+d
vnoremap <C-Ins> "+y
vnoremap <C-Tab> gq
vnoremap <CR> ygv:<C-\>e (visualmode() !=# 'v')? "'<,'>" : getreg()<CR>
vnoremap <S-CR> :<UP>
vnoremap <S-Del> "*d
vnoremap <S-Ins> "*y
vnoremap ? y?<C-\>e (visualmode() != 'v')? "" : getreg()<CR>
vnoremap Q gw
