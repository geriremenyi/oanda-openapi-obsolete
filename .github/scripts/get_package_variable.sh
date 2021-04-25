#!/bin/sh

# Parameter to named parameter
name=`[ ! -z "$1" ] && echo "$1" || [ ! -z "$GET_PACKAGE_VARIABLE_NAME" ] && echo "$GET_PACKAGE_VARIABLE_NAME" || echo ""`
directory=`[ ! -z "$2" ] && echo "$2" || [ ! -z "$GET_PACKAGE_VARIABLE_DIRECTORY" ] && echo "$GET_PACKAGE_VARIABLE_DIRECTORY" || echo $(pwd)`
# Check that all parameters are given
if [ -z $name ]; then
    echo "::error file=get_package_variable.sh::The variable name to get is not given. Either pass the variable name as the first parameter to the script or set the GET_PACKAGE_VARIABLE_NAME environment variable."
    exit 1
fi

# Log parameters
echo "Getting '$name' variable from the '$directory/package.json'..."

# Check that directory and package.json exists
if [ ! -d "$directory" ]; then
    echo "::error file=get_package_variable.sh::The given '$directory' directory doesn't exist."
    exit 1
elif [ ! -f "$directory/package.json" ]; then
    echo "::error file=get_package_variable.sh::The given '$directory' directory doesn't contain a package.json file at it's root."
    exit 1
fi

# Get the current value of the variable
value=`awk -F '"' '/"'"$name"'": ".+"/{ print $4; exit; }' $directory/package.json`
echo "Obtained '$name' variable's value: '$value'."

echo "::set-output name=$name::$value"