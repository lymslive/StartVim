# Guide to personal vimrc with multy start name

+ Class gives you method, not data -- 授人以鱼，不如授人以渔
+ Vimer should use vim in vim way  -- 学而时习之

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
+ Edit the plugin list:
```
$ cd ~/.vim/start
$ vim gplugins.md
<edit this file freely>
:wq
```
Add more plugin you like. 
To disable some plugin to install, mark the plugin url with leading `-` marker.

+ Run the pulgin install script (purl VimL in ex mode)
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

Now this script only recognize three list marks before url: ```
* `+`: install and update this plugin
* `*`: install but not update this plugin
* `-`: donot install this plugin ```

The plugin list file can also use other filename you like, just pass the file
name as argument to `install-plugins.vim`:
```
$ cd ~/.vim/script
$ ./install-plugins.vim path/to/plugin-list-file
```

When omit the argument, use the variable `g:PLUGIN_LIST`, witch is default set
to `~/.vim/start/gplugins.md` in `main.vim` vimrc.

When the `install-plugins.vim` is sourced in vim other than ex, only
`g:PLUGIN_LIST` variable is used.

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

In the `StartVim/plugin/start.vim`, define some commands and summaries here
agian:

* `:StartVim[!] {name}` search vimr by {name} and source it, if ! suffixed,
  then firt stop all vimrc already sourced.
* `:StopVim {vimrc}` it cannot really stop a sourced vimrc before, it only try
  to source another vim file named `~/.vim/star/stop/{vimrc}.vim`

* `:RtpShow` display the `&rtp` in a neater list way.
* `:RtpAdd [path]` add the path (default current directory) to `&rtp`, the
  path should be fit as a runtimepath, that has a "autoload" sub-directory or
  it already under any "autoload" sub-directory, then it will fixed up to the
  parent path of the "autoload" directory.

* `:PackAdd {plugin}` load a plugin and it's specail config as well
* `:PackSub {plugin}` unload a plugin and it's cleaner script.

* `:StartInstall[!] {url}` install a plugin by url argument, if ! suffixed,
  update if already installed before.
* `:StartUpdate {plugin}` update a plugin by name argument.

* `:ECHO {expr}` or `:Echo {expr}` like builtin `:echo` but append to current
  buffer. It is useful in silent ex mode script, and want to print some output
  to stdout.

### Insight to main.vim

The special `start/main.vim` is served as the entrance of vimrc, and dispatch
to real vimrc by start (linked vim) name.

It defines the following environment variable, with default value as:

* $VIMHOME = ~/.vim
* $STARTHOME = ~/.vim/start
* $PACKHOME = ~/.vim/pack

And defines some global variable:

* `g:START_NAME` is the start name, usually equal to `v:progname`.
* `g:RUN_NAME` is a list of vimrc filename that have sourced.
* `g:PLUGIN_LIST` is the plugin list file path, default `$STARTHOME/gplugins.md`

When the start (linked vim) name is in form of `vim-*`, the prefix `vim-` is
stripped, then save the normalized name in variable `g:START_NAME`.

Also support start name alias in `main.vim`, now the default is:
```vim
let s:dStartAlias = {}
let s:dStartAlias.view = 'vi'
let s:dStartAlias.evim = 'minied'
```

That means when start `view` in shell, the `v:progname` is "view", but the
`g:START_NAME` is "vi", then search the vimrc as normal, that will source
`~/.vim/start/vi.vim`.

You can edit `main.vim` to config more aliased start name if needed. In this
way make more start (linked vim) name share the same vimrc, avoding copy or
link to many vimrc files in `$STARTHOME`.

### Details on vex and svex

The primary import thing is make sure `ex` is a link name to vim of the
version you expect to ues, vim8 recommanded.

#### Wrapper bash script

The `vex` is only a bash script to start vim in `ex -S` mode, use the script
file as the argument of `-S` option, some like following:
```bash
script=$1
shift
exec ex -S $script -c 'call input("vex done! press enter to quit ...")' -c 'qall!' $@
```

After execute the script, there is an extra ex command to call `input()`,
let user stay in ex screen to check the message ouput that maybe usefull,
waiting to press enter to quit ex finally.

`vex` can also except more argument except the first script filename, the
other argument is passing to `ex`, extra option to `ex` is also possible.

The `svex` is almost same as `vex`, but run `ex` in silent mode, like:
```bash
script=$1
shift
exec ex -S $script -s -c 'qall!' -- $@
```

Since you mean to run ex script silently, `svex` silently quit after finish
the script. Extra arugments is passed to `ex` as normal filename argument,
that disbale other options passed to `ex`.

#### Output of svex (ex -s)

In `svex` or silent `ex -s` mode, any `:echo` message and event error massge
is depressed. Only few command such as `:print` will print output to stdout.
To handle the output of `svex` script easier, define a `:Echo` command in
"StartVim". `:Echo` will append the message to current buffer and `:print`,
when using in `svex` script, the message will show in stdout.

Another pluign "vimloo" also provide `:LOG` comand. If execute `:LOGON -buffer`
first, the `:LOG` command will log to current buffer, and when used in `svex`
script, also print to stdout.

The `:Echo` or/and `:LOG` command in `svex` script just for output, the
current buffer is modified but discard by `qall!` command. So there is no need
to pass extra filename argument pass to 'svex', and if you have pass one,
there is no effect on that file. If you need to save the output message,
explitly execute `:write` command alike.

Normally you should only use `:Echo` to output message such as description for
the progress when use `svex` script. If you want to "edit" file with `ex`
script, cannot use `:Echo`, as it will mess the file buffer, and give out the
wrong result. Please use `vim` to edit file visually. `svex` is designed to do
something other than editing with VimL script. Of course you can use the
function "readfile()" and "writefile()" in `svex` script to deal with text
file indirectly. Or if you are expert on `ex` before, you may know how to
edit file with `ex` batch script in the right way.

After all, if you use a `ex` script to do some work that logically silent,
that there is no need to use `:echo` through out the script, then there is no
much different to use `vex` or `svex`, except that `vex` need user press a
enter to exit `ex`.

#### Make vim file executable

There are several sample vim script files in `script/sample/` sub-directory.
For example `longloop.vim` is a `vex` script: 
```vim
#! /usr/bin/env vex
for i in range(1, 100)
    echo i
    sleep 100m
endfor
```
and `silentloop.vim` is a `svex` script:
```vim
#! /usr/bin/env svex
packadd StartVim
for i in range(1, 100)
    Echo i
    sleep 100m
endfor
```

The first line "#! /usr/bin/env vex" or "#! /usr/bin/env vex" tells the shell
run `vex` or `svex` to interpret this script. After give the scritp executable
permission with `chmod +x`, the script file can execute directly from shell.
The "#!" line is ignored when the script is sourced in `vim`, completely
harmless as comment.

These tow script almost do the same (dummy) work that print 100 number lines.
The `vex` script `longloop.vim` print to the message area of `ex`, while the
`svex` script `silentloop.vim` print to stdout. `silentloop.vim` need to use
the command `:Echo` from plugin "StartVim", so must execute `:packadd` first
to load that plugin. (Isn't it some like the import sentence in pyhon?)

Another pratical example is the `install-plugins.vim` to intall a list of
plugins. It is also simple, as the dirty work is done in the plugin. The
argument to `vex` script can get from "argc()" and "argv()". If the scritp
will also be sourced directly from `vim`, it is better to check the
`v:progname`.

In the end, VimL script can work much the same way as other script, and `vim`
sever as an interpretor of this new or old language. And more, because `svex`
can output to stdout, pip and redirct is available too.

## Various

### My ~/.vim example

This repository or pluign is only a guide to vimrc, and start to use vim in
different mode. The `~/.vim` is personal data that should fill yourself.
My `~/.vim` is backup in: https://github.com/lymslive/dotvim 

And here is a sample plugin list of mine: [gplugins.md](start/gplugins.md)

### Stay along with SpaceVim

If you are lazy to config vimrc youself, SpaceVim maybe a good choice:
https://github.com/SpaceVim/SpaceVim

If you want to try to use SpaceVim as along with vimrc of yourself, you can
first "uninstall" SapceVim, but SpaceVim not really removed, it still stayed
in `~/.SpaceVim`, and `~/.SpaceVim.d` if you have create it. Then create a 
simple bash script call `spvim` in `~/bin` as following:
```bash
#! /bin/bash
exec vim -u ~/.SpaceVim/vimrc
```

Then you can use `spvim` to start the extream heavy SpaceVim, while use `vim`
still start you lighter vimrc. If you also follow this "StartVim", `vi` and
`ex` etc. are all available, that start vim in a complete different way.

## Contact and Bug Report
