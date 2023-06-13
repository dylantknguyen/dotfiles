#!/bin/zsh

yay -Qdtq > /tmp/orphans
while read -r line; do
   echo | yay -Rns "$line";
done < /tmp/orphans
