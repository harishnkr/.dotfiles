#!/bin/bash
#Remove txt files if there are no corresponding pictures in the images files (which share the same name).
#For exapmle, delete a.txt if there is no corresponding a.jpg
for file in output/YOLO_darknet/*.txt
do
    if [[ ! -f "input/$(basename ${file%.*}).jpg" ]]
    then
        rm "$file"
    fi
done

