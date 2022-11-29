#!/bin/bash
set -eux

BASEDIR=$(dirname $0)
cd $BASEDIR

# シンボリックリンク
filenames=`find . -mindepth 2 -type f -name ".*" -not -path ".git/*"`
for filename in filenames; do
    ln -snfv ${PWD}/"$filename" ~/
done

# Vim colorscheme 導入
#curl https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim > ~/.vim/colors/solarized.vim
