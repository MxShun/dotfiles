#!/bin/bash
set -eux

BASEDIR=$(dirname $0)
cd $BASEDIR

git pull

files=`find . -mindepth 2 -type f -name ".*" -not -path ".git/*"`
if [ "$(uname)" == "Darwin" ]; then
    for file in $files; do
        [[ $file == "./bash/.bashrc" ]] && continue

        ln -snfv ${PWD}/$file ~/
    done
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    for file in $files; do
        [[ $file == "./zsh/.zshrc" ]] && continue

        cp ${PWD}/$file ~/
    done

    # Colorscheme for Mintty
    curl https://raw.githubusercontent.com/mavnn/mintty-colors-solarized/master/sol.dark > ~/dev/theme/mintty-colors-solarized/sol.dark
else
    echo Do not supported
fi

# Colorscheme for Vim
curl https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim > ~/.vim/colors/solarized.vim
