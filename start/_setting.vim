" common settings

set nocompatible
syntax on
set t_Co=256
set background=dark
colorscheme peaksea
" colorscheme darkblue

set ruler
"set number
set showcmd	
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu

"Set 3 lines to the curors - when moving vertical..
set scrolloff=3
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
"set virtualedit=all
" Want to be able to use <Tab> within our mappings
set wildcharm=<Tab>
" Recognise key sequences that start with <Esc> in Insert Mode
" set esckeys

set autoindent
set smartindent

set display=lastline
set textwidth=78
set formatoptions+=mB

set autowriteall
" auto cd to current files (or use: au-event-bufEnter "lcd %:p:h")
set autochdir
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1
set fileformats=unix,dos

set cmdheight=2
set laststatus=2
" set statusline=%t%m%r%h%w\ %{&ff}\-%Y\ 0x\%B\|\%b\ (%l,%v)\ %p%%%LL
set statusline=%t%m%r%h%w:%l\|%v\ %{&ff}\-%Y\ %p%%%LL%=%{&fenc}\ 0x\%B\|\%b\ 
set cursorline
"set cursorcolumn
set foldmethod=marker

" set clipboard+=unnamed
" set mouse=a
set selection=inclusive

set nobackup
" set backupdir=~/tmp/vimbak,.
set history=50
set sessionoptions=tabpages,curdir,slash
set switchbuf=usetab

" let default value ok, wait 1 second
" set timeout
" set nottimeout
