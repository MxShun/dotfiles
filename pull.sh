#!/bin/bash
set -eu

# dotfiles 下に移動
BASEDIR=$(dirname "$0")
cd "$BASEDIR"

# dotfiles を最新化
git pull

# ドットファイルをコピーまたは同期
files=$(find . -mindepth 2 -type f -name ".*" -not -path ".git/*" -not -path "./.idea/*")
if [ "$(uname)" == "Darwin" ]; then
    for file in $files; do
        if [ "$file" == "./bash/.bashrc" ]; then
            continue
        fi
        if [ "$file" == "./zsh/.zsh.tmp" ]; then
            cp -n "${PWD}/$file" "$HOME/.zsh" || # ファイルが存在したらスキップ
            continue
        fi

        ln -snfv "${PWD}/$file" "$HOME/"
    done
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    for file in $files; do
        if [ "$file" == "./zsh/.zshrc" ]; then
            continue
        fi
        if [ "$file" == "./zsh/.zsh.tmp" ]; then
            continue
        fi

        cp "${PWD}/$file" "$HOME/"
    done

    # Mintty カラースキームを取得
    curl https://raw.githubusercontent.com/mavnn/mintty-colors-solarized/4999093b3223164b0aa39244a15fbb972c195815/sol.dark > "$HOME/dev/theme/mintty-colors-solarized/sol.dark"
else
    echo Do not supported
fi

# Vim カラースキームを取得
curl https://raw.githubusercontent.com/altercation/solarized/856f366dcbcf24c23e02e6f571e1eb8eab1c7902/vim-colors-solarized/colors/solarized.vim > "$HOME/.vim/colors/solarized.vim"
