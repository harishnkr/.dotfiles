#!/bin/bash
#
#script to split files to different folders
#script may be incomplete, use caution when running

cd XYZ || { echo "directory does not exist" >&2; exit 1 ;}
n=0
for i in *
do
  if [ $((n+=1)) -gt 8 ]; then
    n=1
  fi
  todir=../XYZ$n
  [ -d "$todir" ] || mkdir "$todir" 
  mv "$i" "$todir" 
done
