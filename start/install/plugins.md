# Vim Plugin List from github

Simple format: each plugin url at the end of a line.
Not neccessary markdown, but that looks like a nicer document.

Support list marker: 
plus `+` install, minus `-` not install, star `*` also update, 
and default as `+`.

Other lines or words are just ignored.

## 敝帚自珍 -- evry vimer has a vim
* https://github.com/lymslive/vimloo
* https://github.com/lymslive/StartVim
+ https://github.com/lymslive/vnote
+ https://github.com/lymslive/EDvsplit
+ https://github.com/lymslive/UseTabpage
+ https://github.com/lymslive/MicroCommand
+ https://github.com/lymslive/Wrap
+ https://github.com/lymslive/qcmotion
* https://github.com/lymslive/Spacebar

## Shougo 大神
+ https://github.com/Shougo/vimproc.vim
+ https://github.com/Shougo/unite.vim
+ https://github.com/Shougo/neocomplete.vim
+ https://github.com/Shougo/neco-vim
+ https://github.com/Shougo/vimshell.vim
+ https://github.com/Shougo/neoyank.vim
+ https://github.com/Shougo/neomru.vim
+ https://github.com/Shougo/unite-outline
+ https://github.com/Shougo/unite-help
+ https://github.com/Shougo/neoinclude.vim
+ https://github.com/Shougo/neosnippet
+ https://github.com/Shougo/neosnippet-snippets
+ https://github.com/Shougo/vimfiler.vim

## Various 五花八门
+ https://github.com/tpope/vim-surround
+ https://github.com/kshenoy/vim-signature
+ https://github.com/scrooloose/nerdtree
+ https://github.com/majutsushi/tagbar
+ https://github.com/SirVer/ultisnips
* https://github.com/honza/vim-snippets

+ https://github.com/tsukkee/unite-tag
+ https://github.com/amitab/vim-unite-cscope
+ make https://github.com/Rip-Rip/clang_complete
+ https://github.com/mileszs/ack.vim
+ https://github.com/haya14busa/incsearch.vim

+ https://github.com/jiangmiao/auto-pairs
- make 宇宙超级无敌大插件但是我不装了 https://github.com/Valloric/YouCompleteMe
- https://github.com/asins/vim-dict

+ https://github.com/iamcco/dict.vim
+ https://github.com/lvht/phpcd.vim

## Plugin Manager Plugin
- https://github.com/tpope/vim-pathogen
- https://github.com/VundleVim/Vundle.vim
- https://github.com/junegunn/vim-plug
- https://github.com/Shougo/dein.vim

## Finish

Mark the end of the plugin list. Any line like following(case insensive):
```
#\+ finish$
"\+ finish$
<!-- finish -->
```

More detail remark or ducution can be here after finishing.

## New Installed Manually

When use `:StartInstall {plugin-url}` in vim command line, the newly installed
plugin will append to the end of this file. You may edit it later time, moving
to befor "## Finish".
