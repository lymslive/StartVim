# Guide to personal vimrc with multy start name

## Requirement

+ unix/linux system that support symbol link
+ vim8 version that supports `:packadd`

## Feature Summary

* Collect a set of vimrc files, source the right vimrc corresponding to start
  symbol link name of vim. Can add more vimrc dynamically after starting by a
  specific vimrc when need, Using command `:StartVim`.
* Using the builtin `:packadd` of vim8 to manage plugin loading, and extend
  command `:PackAdd` to source custome config of the adding plugin if needed.
* Separate the plugin search and install from load. Using a plain text file
  with a list of plugin url (in github) to "manage" plugin installation.
* Use wrapper bash shell script `vex` and `svex` to make the `ex` mode of vim
  much as normal script language, and then make VimL script execuable.
* Preserve personal vimrc, use `vim` still start with users's original vimrc.
* Keep the config of vimrc simple and direct. Only `main.vim` is required
  except for plugin managemant.

## Install

### Manually Install

It is known what happens when installed manually.

1. clone down to appropriate location:
```
$ mdkir -p ~/.vim/pack/lymslive/opt
$ cd ~/.vim/pack/lymslive/opt
$ git clone https://github.com/lymslive/StartVim
```

2. copy the vimrc files in start/ to ~/.vim
```
$ cd StartVim
$ cp -r start/ ~/.vim
$ cp -r script/ ~/.vim
```
it is optional to copy script/ to ~/.vim

3. install `vex` and `svex` to ~/bin(where should be in $PATH)
```
$ copy bin/* ~/bin
```
If you never care about ex mode, and prefer to other way to manage plugin,
this step is optional.

Check whether ex is install with vim, and symbol linked to vim:
```
$ which ex
$ ls -l `which ex`
```
If it is not the case, make `ex` link to (the appropriate path to) `vim`.

4. backup you own vimrc as self.vim, and use main.vim instead
If you original vimr is ~/.vimrc
```
$ cd ~
$ mv .vimrc ~/.vim/start/self.vim
$ ln -s ~/.vim/start/main.vim .vimrc
```

If you original vimr is ~/.vim/vimrc
```
$ cd ~/.vim
$ mv vimrc ~/.vim/start/self.vim
$ ln -s start/main.vim vimrc
```

5. intall the plugin list (only) for first time use
1) Edit the plugin list:
```
$ cd ~/.vim/start
$ vim gplugins.md
<edit this file freely>
:wq
```
Add more plugin you like. 
To disable some plugin to install, mark the plugin url with leading `-` marker.

2) Run the pulgin install script (purl VimL in ex mode)
```
$ cd ../script
$ ./install-plugins.vim
```
This reqires `vex` installed in step 3.

Or this script can also be sourced from running vim:
```
:enew
:source ~/.vim/script/install-plugins.vim
```
It is better to open a new buffer first, as some output message may append to
the current buffer.

The speed of plugin instllation, especially a list of plugins, is mainly
determined by the net speed. So it is suggested to intall mutly plugins in a
separate vim instance, batch ex mode is better.

### One-key Install ?

Copy the shell commands in the last section, save to a bash shell script, and
run it.

### Clone as `.vim/` ?

For new vimer, if you haven't make much use of `.vim/`, you can directlly
clone this repository as `.vim/`:
```
$ git clone https://github.com/lymslive/StartVim ~/.vim
```
Or clone StartVim to any place, and symbol link `~/.vim` to it.

Then, in the vimrc files under `~/.vim/start`, there is no need to add the
commnad `packadd StartVim`, since it is always loaded.

It is *NOT* recommanded to do so, you should edit your `~/.vim` from time to
time, and keep plugins including this StartVim stay in separate place, that is
`~/.vim/pack` in vim8.

### Uninstall ?

Once you decide to install StartVim, naormally it's not nessarry to uninstall
it. After all, you can still run `vim` to start your own original vimrc.

But if you really want to uninstall, just to roll back the files copied to
`~/.vim` direcotry, such as:
```
$ cd ~/.vim
$ mv start/self.vim vimrc
$ rm -rf start/
$ rm -rf script/
```

## Usage

* Learn and refer to any others vimrc, copy and paste lines you like to your
  `~/.vim/start/self.vim` file. It is used as the most common vimrc start from
  native `vim`.
* When you want to use vim in a different work case, frist creat a symbol link
  name in `~/bin`, and create a `.vim` file with the "same" or "like" name.
* When work on vim, use `:StartVim` to source more vimrc, use `:packadd` or
  `:PackAdd` to load more plugin. Command completion is available.
* Make use of each sub-directory of `~/.vim`, manage the `*.vim` files
  yourself.
* Try the funny executable VimL script, with headline `#! /usr/bin/env vex`.

### start vim name and start vimrc

For example, you are working on an environment relative to "foo", you want to
use the name of "foo" to start vim in a specail case. 

First create a symbol link to vim, put in `$PATH` such as `~/bin`
```
$ ln -s `which vim` ~/bin/foo
or
$ ln -s `which vim` ~/bin/vim-foo
```

Then create a vimrc named "foo.vim" in `~/.vim/start`. You can source other `.vim`
files when edit new vimrc. The files named begins with underscore `_*.vim` is
encouraged sourced by other vimrc, and are ignored when complete `:StartVim`.

The vimrc name is not nessary excatly "foo.vim", search by "main.vim" in the
following order:

1. `self-foo.vim`
2. `foo.vim`
3. `vim-foo.vim`
4. `self-foo*.vim`
5. `foo*.vim`
6. `vim-foo*.vim`
7. `self.vim`
8. `default.vim`

Only the first vimrc found is sourced.

However, when start with native "vim" name, the fuzzy search step(4-6) is
skiped. So the search order is "self-vim.vim", "vim.vim", "vim-vim.vim", then
"self.vim" and "default.vim". The first three vimrc candidate names seems ugly,
and suggest to use "self.vim" as the common personal vimrc.

### Shipped start vimrc

This repository provides several vimrc files, mainly for example, as no vimrc
fit everyone.

* `vi.vim`: not means vi compatible, but with few seetings and no plugins
  loading, to start vim quickly.
* `minied.vim`: as few as `vi.vim` but add little imaps for editing.
* `fulled.vim`: with many(if not full) setting and remaps config, load
  standard plugins and some of my personal plugins including this one, and so
  `:StartVim` command is available.

In `vi.vim` and `minied.vim`, even this "StartVim" plugin is not loaded, so
you must use `:packadd StartVim` before use `:StartVim`. However, there is a
quick remap to load `minied.vim` in `vi.vim`, and alos a quick way to load
`fulled.vim` from `minied.vim`, refer to the last few lines in each vimrc.

Your personal common vimrc "self.vim" may base on or some like "fulled.vim".

* `vcide.vim`: use vim as a IDE, "c" means "C language" or "Common Coding" or
  "Complex". It add many more plugins from github, and config for some complex
  plugins. You may edit you own `self-vcide.vim`, as mine may not fit yours.
* `vim-note.vim`: a special case using vim to edit note and dairy, mainly make
  use of my vnote plugin: https://github.com/lymslive/vnote

* `ex.vim`: server for batch or ex mode of vim, `vex` and `svex` will source
  it. It is even fewer than `vi.vim`, because almost nothing is needed in
  batch script. If any plugin needed when write a VimL script, explict use
  `packadd plugin` at the top of that VimL script.
* `default.vim`: I just link it to `vi.vim` now, it is meaningless, only for
  the last search try by `main.vim`. Vim8 also provides a `default.vim`, you
  may like to symbol link to it.

Since the `start/` directory is copied to `~/.vim`, you can edit these files
freely, or prefix a `self_` if you like.

You *must* create each symbol link to vim if you want to use any of these
vimrc. Because the location of vim may differ to each other, you should make
the link yourself. For example:
```
$ cd ~/bin
$ ln -s `which vim` vc
$ ln -s `which vim` vim-note
```

Notice: the link name of "vcide" can be short as "vc". But make "note" as a
link name to vim sound bad, so use "vim-note" better.

In some linux system, "vi" is default an alias to "vim", then it cannot start
with `vi.vim` vimrc, but with `vim.vim` or `self.vim` instead. Then you can
unalias vi in `.bashrc` and create vi link to vim.

In many installation of vim, "ex" link is automatically created, if it is not
so, create the link yourself:
```
$ cd ~/bin
$ ln -s `which vim` vi
$ ln -s `which vim` ex
```

Notice: it is better to put `~/bin` at the head part of $PATH

Todo: vimdiff is also interesting and wonderfull, but I have not reseach must
by now.

### How to use plugin

#### Principle

* Vim is great because of itself, not any other plugins. If there is a solution
  in vim itself, there is no much need to seek for plugins.
* Learn some VimL script to solute more problem, if it is really hard for you,
  seek for others' plugin. Replace the plugin when you have your own solution.
* Only install plugin when needed, only update plugin when new problem come out.
* Plugin is endless, while vim is limited, master vim is more easy.

When vim8 come out, the builtin pack mechanism is good enough for most cases.
It is really different stuff to search plugin, install plugin and use plugin.
The `:packadd` command in vim8 is focusing on using plugin, while how to
search and install plugin is matters of personal users.

#### Install one plugin

In this StartVim, plugin management is high based on package of vim8. With a
few command addtion:

* `:StartInstall {url}` install one plugin, the argument is the full url
  (only support github now), you can copy it from the browser.
* `:StartUpdate {name}` update a installed plugin, argemnt is the plugin name,
  which has completion support.
* `:StartInstall! {url}` update if already installed, otherwise install.

#### Install list of plugins

It may be time consuming to install "all" or many plugins once. So I provide a
VimL script that used in separate vim instance, or better in batch ex mode.

The default plugin list file is `~/.vim/start/gplugins.md`. It is simple, each
plugin url occupis a line, any leading words are allowed, separated by space,
but the url must be the last "word".

Save the url because it is easy to retrive the plugin homepage, and save the
file in markdown because it is further easy to click the url link when has a
way to preview the markdown. Actually, you can edit the plugin list file as
normal markdown document, add some remark or description for each or some of
plugin.

The script `install-plugins.vim` parses the plugin list file, extracting the
plugin url, and then intall the plugin in the `pack/` sub-directory: 
`~/.vim/pack/{author-name}/opt/{plugin-name}`.

The plugin list file can also use other filename you like, just pass the file
name as argument to `install-plugins.vim`:
```
$ cd ~/.vim/script
$ ./install-plugins.vim path/to/plugin-list-file
```

When omit the argument, use the variable `g:PLUGIN_LIST`, witch is default set
to `~/.vim/start/gplugins.md` in `main.vim` vimrc.

#### Manually install plugin

When you want to install plugin not from github, manually download and extract
to the `pack/` sub-directory: `~/.vim/pack/{pack-name}/opt/{plugin-name}`. It
is your item to select a pack-name, may group plugin by author, or by
functionality. 

If you place the plugin in `~/.vim/pack/{pack-name}/start/{plugin-name}`, then
that plugin is alwaays loaded when vim start, and there is no need to use
`:packadd` in any start vimrc. Do *not* place too much plugin in this way.

#### Autoload plugin with filetype

Plugins concerned a specific filetype(usually a language type), is better not 
`:packadd` in the vimrc, but delay in the `~/.vim/ftplugin/{ft}.vim`. Pay
attenion to avoid reload such plugin.

For example, the following code can be add to `~/.vim/ftplugin/vim.vim`:
```
if !exists('s:once')
    let s:once = 1
    packadd necovim.vim
endif
```
Then the plugin "necovim.vim" is loaded only in the first time open a vim file.

#### Manually load plugin with packadd/PackAdd

It is to dynamically load plugin with `packadd`, refer to help `:h packadd`.
This StartVim also provides a command `:PackAdd`, try to do some more work
addtion to `:packadd`.

* before run `:packadd`, source `~/.vim/start/plugon/{plugin}.vim` if existed.
* after run `:packadd`, source `~/.vim/start/plugin/{plugin}.vim` if existed.

That is used for config for the newly loading plugin.

You can also use `:PackAdd` in some vimrc files, but that will be slower than
use ':packadd', and must `:packadd StartVim` before `:PackAdd` is available.
In the most used vimrc and for the most used plugin, you can copy the sepcial
config for that plugin (or `:read`) into vimrc directly, avoiding source many
small vim file at staring.

There is also a command `:PackSub {plugin}`, it will remove the plugin path
from `&rtp`, and try to source `~/.vim/start/plugoff/{plugin}.vim`. It maybe
useless, or helpful in some case.

#### Lower version of vim ?

It is recommanded to update vim8. It is easy to build from source:
https://github.com/vim/vim

However, the lower vim version, say vim7, can also use this StartVim, with
attention to following:

* `:packadd` cannot use, while `:PackAdd` can still use.
* explictly add plugin path to `&rtp` vimrc. 
  For example: `set rtp+=$PACKHOME/lymslive/opt/StartVim`

### Make full use of personal ~/.vim

Make sub-directory under `~/.vim` to save different vim files, and manange
them in a neaty way.

* Install plugin in `pack/`
* Write vimrc in `start/`
* Write filetype config in `ftplugin/`
* If you are learning VimL, can put small vim file in `plugin/`, they are
  sourced when vim start. But *donot* keep large vim file in it for a long
  time.
* If you need to create some complex remap, write a function for that map, and
  place it in `autoload/`
* If you use 'ultisnips' plugin, wirte your own snips in `UltiSnips/`
* Collect dictionay file in dict/, for `<C-x><C-k>` completion.
* If you are interesting in ex script, place them in `script/`

Overall, `~/.vim` is for personal vim data files, donnot install any external
plugin directly under it. The file in `plugin/` `fptplugin/` and `autoload/`
should keep simple, and if become complex, make a separate plugin, and move to
`pack/`.

## More Reference of StartVim

### Custom Commands

### Insight to main.vim

### Details on vex and svex

## Various

## Contact and Bug Report
