#/bin/zsh

yay -Qdtq > orphans
vim orphans
remove < orphans
yay -Rns orphans
