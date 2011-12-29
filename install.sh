#!/bin/bash

echo "    EMACS: Install emacs config"

echo "        Note: the \"emacs-config\" should place in the path: ~/.emacs.d/"

# 1. link the .emacs
if [ -e ~/.emacs ]; then
    rm ~/.emacs
    ln -s ~/.emacs.d/emacs-config/emacs ~/.emacs
else
    ln -s ~/.emacs.d/emacs-config/emacs ~/.emacs
fi
echo ""

# 2. make dictionary for auto backup and auto save
if [ -e ~/.emacs.d/auto-backup ]; then
    echo "folder auto-backup is exist"
else
    mkdir ~/.emacs.d/auto-backup
fi

if [ -e ~/.emacs.d/auto-save ]; then
    echo "folder auto-save is exist"
else
    mkdir ~/.emacs.d/auto-save
fi
echo ""

# 3. Copy ecb user layouts config file to ~/
cp ./tmp/.ecb-user-layouts.el ~/
echo ""

# 4. Install cscope ruby w3m mew
sudo apt-get install cscope cscope-el ruby w3m w3m-el mew -y > /dev/null
sudo cp ./tmp/cscope-indexer /usr/bin/cscope-indexer
sudo cp ./tmp/xcscope.el  /usr/share/emacs23/site-lisp/cscope/xcscope.el
sudo cp ./tmp/xcscope.elc /usr/share/emacs23/site-lisp/cscope/xcscope.elc
# set for evernote
cd ./download/evernote-0.30/ruby
sudo ruby setup.rb

echo "    EMACS: Setup Done!"

