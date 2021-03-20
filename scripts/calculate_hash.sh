#!/bin/sh

# Parameter to named parameter
folder_or_file=$1
if [ "$folder_or_file" = "" ]; then
    if [ ! -z "$CALCULATE_HASH_FOLDER_OR_FILE" ]; then
        # Param is set in environment variable, so use that
        folder_or_file="$CALCULATE_HASH_FOLDER_OR_FILE"
    else
        # Param is not set at all
        echo "::error file=calculate_hash.sh,line=11::\
        The folder or file name is not given. \
        Either pass the folder or file name as the first parameter to the script or set the CALCULATE_HASH_FOLDER_OR_FILE environment variable."
        exit 1
    fi
fi

# Collect the hash and output it in the 'hash' github actions output variable
if [ -d "$folder_or_file" ]
    # Hashing a folder
    echo "::group::Calculating hash for folder '$folder_or_file'"
    echo "The passed parameter is a folder. Calculating the hash by hashing the hashes of all files in the directory..."
    hash=$(find $folder_or_file -type f -exec md5sum {} \; | sort -k 2 | md5sum)
    echo "The calculated folder hash is '$hash'."
    echo "::set-output name=hash::$hash"
    echo "::endgroup::"
elif [ -f "$folder_or_file"  ]
    # Hashing a single file
    echo "::group::Calculating hash for file '$folder_or_file'"
    echo "The passed parameter is a file. Calculating the hash..."
    hash=$($folder_or_file | md5sum)
    echo "The calculated file hash is '$hash'."
    echo "::set-output name=hash::$hash"
    echo "::endgroup::"
else
    # Parameter is invalid
    echo "::error file=calculate_hash.sh,line=37::The given parameter '$folder_or_file' is not a folder neither a file."
    exit 1
fi