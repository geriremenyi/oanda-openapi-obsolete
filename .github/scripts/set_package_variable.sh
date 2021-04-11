#!/bin/sh

# Parameter to named parameter
name=`[ ! -z "$1" ] && echo "$1" || [ ! -z "$SET_PACKAGE_VARIABLE_NAME" ] && echo "$SET_PACKAGE_VARIABLE_NAME" || echo ""`
value=`[ ! -z "$2" ] && echo "$2" || [ ! -z "$SET_PACKAGE_VARIABLE_VALUE" ] && echo "$SET_PACKAGE_VARIABLE_VALUE" || echo ""`
directory=`[ ! -z "$3" ] && echo "$3" || [ ! -z "$SET_PACKAGE_VARIABLE_DIRECTORY" ] && echo "$SET_PACKAGE_VARIABLE_DIRECTORY" || echo $(pwd)`
# Check that all parameters are given
if [ -z $name ]; then
    echo "::error file=set_package_variable.sh::The variable name to set is not given. Either pass the variable name as the first parameter to the script or set the SET_PACKAGE_VARIABLE_NAME environment variable."
    exit 1
fi
if [ -z $value ]; then
    echo "::error file=set_package_variable.sh::The variable value to set is not given. Either pass the variable value as the first parameter to the script or set the SET_PACKAGE_VARIABLE_VALUE environment variable."
    exit 1
fi

# Log parameters
echo "Setting '$name' variable to '$value' in the '$directory/package.json'..."

# Check that directory and package.json exists
if [ ! -d "$directory" ]; then
    echo "::error file=set_package_variable.sh::The given '$directory' directory doesn't exist."
    exit 1
elif [ ! -f "$directory/package.json" ]; then
    echo "::error file=set_package_variable.sh::The given '$directory' directory doesn't contain a package.json file at it's root."
    exit 1
fi

# Get the current value of the variable
current_value=`awk -F '"' '/"'"$name"'": ".+"/{ print $4; exit; }' $directory/package.json`
echo "The current value '$current_value' will be replaced with '$value'."

# Replace current value
sed -i "s/\"$name\":.*\"$current_value\"/\"$name\": \"$value\"/g" "$directory/package.json"
echo "The replace has finished, the new value is '$value'."