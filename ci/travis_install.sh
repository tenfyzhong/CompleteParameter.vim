#!/bin/bash -
set -e

if [[ $TRAVIS_OS_NAME == 'osx'  ]]; then
    brew update
    brew install neovim/neovim/neovim
else
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update -y
    sudo apt-get install neovim -y
fi

wget https://codeload.github.com/vim/vim/tar.gz/v7.4.774
tar xzf v7.4.774
cd vim-7.4.774
./configure --prefix="$HOME/vim" \
    --enable-fail-if-missing \
    --with-features=huge
make -j 2
make install
