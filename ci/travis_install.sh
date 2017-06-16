#!/bin/bash -
set -e

# if [[ $TRAVIS_OS_NAME == 'osx'  ]]; then
#     brew update
#     brew install lua
#     export CFLAGS=/usr/local/opt/lua/include
#     export CPPFLAGS=/usr/local/opt/lua/include
#     export LDFLAGS=-L/usr/local/opt/lua/include
# fi

wget https://codeload.github.com/vim/vim/tar.gz/v7.4.2367
tar xzf v7.4.2367
cd vim-7.4.2367
./configure --prefix="$HOME/vim" \
    --enable-fail-if-missing \
    --with-features=huge
make -j 2
make install
