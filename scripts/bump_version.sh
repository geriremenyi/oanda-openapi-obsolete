#!/bin/sh

# Parameters to named parameters
version_type=$1

# Parameter checks
if [ "$version_type" = "" ] 
then
    echo "[WARNING] Version type was not given. Setting version type to 'patch'"
    version_type="patch"
else 
    if [ "$version_type" != "patch" ] && [ "$version_type" != "minor" ] && [ "$version_type" != "major" ]
    then
        echo "[ERROR] The first parameter is the version type which should be either 'patch', 'minor' or 'major'."
        exit 1
    fi
fi

# Bumping version in package.json
new_version=$(npm version "$version_type" --no-git-tag-version | sed "s/[^0-9\.]*//g")
echo "[INFO] Node package version was updated to $new_version"

# Bumping version in all config files
for config_file in ./config/*.json; do
    sed -i "s/\"packageVersion\":.*\,/\"packageVersion\": \"$new_version\"\,/g" "$config_file"
    echo "[INFO] Config file '$config_file' was updated to $new_version"
done
