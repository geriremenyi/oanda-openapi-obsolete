#!/bin/sh

# This is needed because of the bug 
# https://github.com/OpenAPITools/openapi-generator/issues/5416 in the openapi-generator

# Removing 'foreach(var x in BaseValidate(validationContext)) yield return x;' lines
for model_file in ./out/code/csharp-netcore/src/GeriRemenyi.Oanda.V20/Model/*.cs; do
    sed -i "s/foreach(var x in BaseValidate(validationContext)) yield return x;//g" "$model_file"
done