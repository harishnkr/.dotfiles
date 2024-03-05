#!/bin/sh
#script to delete alternate files in a folder. Used to cut the size of a large folder by 2

delete=yes
for file in *.jpg
do
    if [ $delete = yes ]
    then echo $file; delete=no
    else delete=yes
    fi
done |
xargs rm -f
