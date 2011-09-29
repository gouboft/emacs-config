#!/bin/bash

echo "Install emacs config"
echo ""
echo "Note: the \"emacs-config\" should place in the path: ~/.emacs.d/"
echo ""
# Step 1
echo "1. backup the old \".emacs\" to \".emacs.backup\""
if [ -f ~/.emacs ]; then
    mv ~/.emacs ~/emacs.backup
    echo "Your ~/.emacs file is copyed to emacs.backup."
    ln -s ~/.emacs.d/emacs-config/.emacs ~/.emacs
else
    ln -s ~/.emacs.d/emacs-config/.emacs ~/.emacs
fi
echo ""
# Step 2
echo "2. make dictionary for auto backup and auto save"
if [ -d ~/.emacs.d/auto-backup ]; then
    #do nothing
else
    mkdir ~/.emacs.d/auto-backup
fi

if [ -d ~/.emacs.d/auto-save ]; then
    #do nothing
else
    mkdir ~/.emacs.d/auto-save
fi
echo ""
# Step 3
echo "3. Copy ecb user layouts config file to ~/"
cp ./tmp/.ecb-user-layouts.el ~/
echo ""
# Step 4
echo "4. Install cscope ruby w3m"
sudo apt-get install cscope cscope-el ruby w3m w3m-el> /dev/null
sudo cp ./tmp/cscope-indexer /usr/bin/cscope-indexer
sudo cp ./tmp/xcscope.el  /usr/share/emacs23/site-lisp/cscope/xcscope.el
sudo cp ./tmp/xcscope.elc /usr/share/emacs23/site-lisp/cscope/xcscope.elc
# set for evernote
cd ./download/evernote-0.30/ruby
sudo ruby setup.rb

echo ""
echo "All Done!"

