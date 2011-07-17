#!/bin/bash

echo "Install emacs config"
echo ""
echo "the \"emacs-config\" should place in the path: ~/.emacs.d/"
echo ""
echo "backup the old \".emacs\" to \".emacs.backup\""
mv ~/.emacs ~/.emacs.backup

ln -s ./.emacs ~/.emacs

echo "make dictionary for auto backup and auto save"
mkdir ~/.emacs.d/auto-backup
mkdir ~/.emacs.d/auto-save

echo "cp ecb user layouts config file to ~/"
cp ./tmp/.ecb-user-layouts.el ~/

echo ""
echo "All Done!"

