#!/bin/sh

# Parameter to named parameter
folder_or_file=`[ ! -z "$1" ] && echo "$1" || [ ! -z "$CALCULATE_HASH_FOLDER_OR_FILE" ] && echo "$CALCULATE_HASH_FOLDER_OR_FILE" || echo ""`
# Check that all parameters are given
if [ -z "$folder_or_file" ]; then
    echo "::error file=calculate_hash.sh::\
    The folder or file name is not given. \
    Either pass the folder or file name as the first parameter to the script or set the CALCULATE_HASH_FOLDER_OR_FILE environment variable."
    exit 1
fi

# Collect the hash and output it in the 'hash' github actions output variable
if [ -d "$folder_or_file" ]; then
    # Hashing a folder
    echo "The passed parameter is a folder. Calculating the hash by hashing the hashes of all files in the directory..."
    hash=`find $folder_or_file -type f -exec md5sum {} \; | sort -k 2 | md5sum | cut -d ' ' -f 1`
    echo "The calculated folder hash is '$hash'."
    echo "::set-output name=hash::$hash"
elif [ -f "$folder_or_file"  ]; then
    # Hashing a single file
    echo "The passed parameter is a file. Calculating the hash..."
    hash=`$folder_or_file | md5sum | cut -d ' ' -f 1`
    echo "The calculated file hash is '$hash'."
    echo "::set-output name=hash::$hash"
else
    # Parameter is invalid
    echo "::error file=calculate_hash.sh::The given parameter '$folder_or_file' is not a folder neither a file."
    exit 1
fi