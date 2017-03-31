#! /usr/bin/env bash

if ! hash git &>/dev/null; then
	echo git not installed
	exit 1
fi

# download plugin
echo clone down from https://github.com/lymslive/StartVim ...
mkdir -p ~/.vim/pack/lymslive/opt
cd ~/.vim/pack/lymslive/opt
if [[ -d StartVim ]]; then
	cd StartVim
	git pull
else
	git clone https://github.com/lymslive/StartVim
fi

echo clone down from https://github.com/lymslive/vimloo ...
cd ~/.vim/pack/lymslive/opt
if [[ -d vimloo ]]; then
	cd vimloo
	git pull
else
	git clone https://github.com/lymslive/vimloo
fi

# copy start/
echo install start vimrc files ...
if [[ ! -d ~/.vim ]]; then
	mkdir ~/.vim
fi

cd ~/.vim/pack/lymslive/opt/StartVim
cp -r start/ ~/.vim

# copy bin
echo install ex ...
if [[ ! -d ~/bin ]]; then
	mkdir ~/bin
fi

cd ~/.vim/pack/lymslive/opt/StartVim
copy bin/vex ~/bin/vex
copy bin/svex ~/bin/svex

if ! hash ex &>/dev/null; then
	ln -s `which vim` ~/bin/ex
fi

# install vimrc
echo backup personal vimrc to start/self.vim
if [[ -e ~/.vim/vimrc ]]; then
	mv ~/.vim/vimrc ~/.vim/start/self.vim
fi

if [[ -e ~/.vimrc ]]; then
	mv ~/.vimrc ~/.vim/start/self.vim
fi

echo install start main vimrc
cd ~/.vim
ln -s start/main.vim vimrc

# footer
echo done!
echo basic StartVim installed
echo to install plugin list:
echo 'cd ~/.vim/start/install'
echo '~/install-plugins.vim'
echo you can use vim before that complete
