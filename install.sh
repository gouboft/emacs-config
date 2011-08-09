#!/bin/bash

echo "Install emacs config"
echo ""
echo "Note: the \"emacs-config\" should place in the path: ~/.emacs.d/"
echo ""
# Step 1
echo "1. backup the old \".emacs\" to \".emacs.backup\""
mv ~/.emacs ~/.emacs.backup
ln -s ~/.emacs.d/emacs-config/.emacs ~/.emacs
echo ""
# Step 2
echo "2. make dictionary for auto backup and auto save"
mkdir ~/.emacs.d/auto-backup
mkdir ~/.emacs.d/auto-save
echo ""
# Step 3
echo "3. Copy ecb user layouts config file to ~/"
cp ./tmp/.ecb-user-layouts.el ~/
echo ""
# Step 4
echo "4. Install cscope ruby w3m"
sudo apt-get install cscope cscope-el ruby w3m > /dev/null
sudo cp ./tmp/cscope-indexer /usr/bin/cscope-indexer
# set for evernote
cd ./download/evernote-0.30/ruby
sudo ruby setup.rb

echo "alias em='emacsclient'" >> ~/.bashrc

echo ""
echo "All Done!"

