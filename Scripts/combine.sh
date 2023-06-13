#!/bin/zsh

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=/home/dylan/combine.pdf -dBATCH /tmp/BROTHER/*.pdf

echo "Check Document"
read -k1 -s

rm -rf /tmp/BROTHER/*.pdf
