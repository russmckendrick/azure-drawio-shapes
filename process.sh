#!/bin/bash

# Set some variables

INPUT_FOLDER="Icons"
OUTPUT_FOLDER="Processed"
SHAPE_FOLDER="shapes"
SIZE="60"

# Rename the files

find ./$INPUT_FOLDER -name "*.svg" -exec rename 's/\d+-icon-service-(.*)$/${1}/' {} \;

# Create the folder structure

find ./$INPUT_FOLDER -type d -print0 | while IFS= read -r -d '' file; do
    if [[ ! -h "$file" ]]; then
        echo "$file"
        mkdir -p "$OUTPUT_FOLDER/$file"
    fi
done

# Reszie the SVGs

find ./$INPUT_FOLDER -name "*.svg" -print0 | while IFS= read -r -d '' file; do
    if [[ ! -h "$file" ]]; then
        rsvg-convert "$file" -h $SIZE -w $SIZE -a -f svg -o "$OUTPUT_FOLDER/$file"

    fi
done

# Rename the folders
find $OUTPUT_FOLDER -depth -type d -name "* *" -execdir rename 's/ /-/g' "{}" \;

# Trim the files
find ./$OUTPUT_FOLDER -type d -exec svgo --enable=removeDimensions -f {} \;

# Run svg2mxlibrary
npm install --no-save ./svg2mxlibrary

mkdir $SHAPE_FOLDER

find ./$OUTPUT_FOLDER -type d -print0 | while IFS= read -r -d '' file; do
    if [[ ! -h "$file" ]]; then
        OUTPUT_FILE=$(echo $file | cut -d'/' -f4)
        node svg2mxlibrary -o $SHAPE_FOLDER/$OUTPUT_FILE.xml $file/*.svg
    fi
done
