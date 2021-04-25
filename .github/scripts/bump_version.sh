#!/bin/sh

# Parameters to named parameters
type=`[ ! -z "$1" ] && echo "$1" || [ ! -z "$BUMP_VERSION_TYPE" ] && echo "$BUMP_VERSION_TYPE" || echo "patch"`
# Validate version type
if [ "$type" != "patch" ] && [ "$type" != "minor" ] && [ "$type" != "major" ]; then
    echo "::error file=bump_version.sh::The version type should be either 'patch', 'minor' or 'major'."
    exit 1
fi

# Log parameters
echo "Will update node '$type' version..."

# Bump version in package.json
new_version=$(npm version "$type" --no-git-tag-version | sed "s/[^0-9\.]*//g")
echo "Node package version was updated to '$new_version'"

# Bump version in all config files
for config_file in ./config/*.json; do
    sed -i "s/\"packageVersion\":.*\,/\"packageVersion\": \"$new_version\"\,/g" "$config_file"
    echo "Config file '$config_file' was updated to '$new_version'"
done
