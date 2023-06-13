#!/bin/zsh

base_dir=/tmp/BROTHER

mkdir -p $base_dir

# scanimage --source ADF --device "airscan:w0:Brother MFC-J870DW" --format tiff --output-file $base_dir/output.tiff --progress --mode Color --resolution 9600
scanimage --device "airscan:w0:Brother MFC-J870DW" --format tiff --output-file $base_dir/output.tiff --progress --mode Color --resolution 9600

name=output
i=1

if [[ -e $base_dir/$name$i.pdf || -L $base_dir/$name$i.pdf ]] ; then
    i=2
    while [[ -e $base_dir/$name$i.pdf || -L $base_dir/$name$i.pdf ]] ; do
        let i++
    done
fi

tiff2pdf -o $base_dir/$name$i.pdf $base_dir/output.tiff
rm $base_dir/output.tiff
