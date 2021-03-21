#!/bin/sh

# Parameter to named parameter
name=`[ ! -z $1 ] && echo "$1" || [ ! -z "$GET_PACKAGE_VARIABLE_NAME" ] && echo "$GET_PACKAGE_VARIABLE_NAME" || echo ""`
# Check that all parameters are given
if [ -z $name ]; then
    echo "::error file=get_package_variable.sh::\
    The variable name to get is not given. \
    Either pass the variable name as the first parameter to the script or set the GET_PACKAGE_VARIABLE_NAME environment variable."
    exit 1
fi

# Parse the package variable out of npm environment variables
npm_variable_name="npm_package_$name"
echo "The npm environment variable name is '$npm_variable_name'."
value=`npm run env | grep "$npm_variable_name" | cut -d '=' -f 2`
echo "The variable value is '$value'."
if [ -z "$value" ]; then
    echo "::warning file=get_package_variable.sh::The gathered package variable is empty."
fi
echo "::set-output name=$name::$value"