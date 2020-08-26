#!/bin/sh

# This is needed because of the bug 
# https://github.com/OpenAPITools/openapi-generator/issues/5416 in the openapi-generator

# Removing 'foreach(var x in BaseValidate(validationContext)) yield return x;' lines
ls -all ./out/code/csharp-netcore/src
find ./out/code/csharp-netcore/src/GeriRemenyi.OANDA.V20/Model -name "*.cs" -print0 | while read -d $'\0' model_file
do
    sed -i "s/foreach(var x in BaseValidate(validationContext)) yield return x;//g" "$model_file"
done