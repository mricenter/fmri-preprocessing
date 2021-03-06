#!/bin/bash
# Exports the container in the cwd.
# The container can be exported once it's started with
gear=functional-preprocessing
version=0.1.2
outname=$gear-$version.tar
container=$gear
image=mricenter/$gear

# Check if input was passed in.
if [[ -n $1 ]]; then
    outname=$1
fi

docker run --name=$container --entrypoint=/bin/true $image
docker export -o $outname $container
docker rm $container
