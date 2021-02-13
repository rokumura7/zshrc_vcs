#!/bin/bash

echo "START"

rm ~/.zshrc
cp ./zshrc.sh ~/.zshrc
source ~/.zshrc

echo "DONE"