#!/bin/bash -
set -e

vim -Nu <(cat << VIMRC
filetype off
set rtp+=~/.vim/bundle/vader.vim
set rtp+=~/.vim/bundle/CompleteParameter.vim
runtime! cm_parser/*.vim
filetype plugin indent on
syntax enable
VIMRC) -c 'Vader! *' > /dev/null

