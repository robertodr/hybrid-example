#!/usr/bin/env bash

set -eu -o pipefail

if [ $# -eq 0 ] ; then
    echo 'No arguments passed!'
    exit 1
fi

# build directory is provided by the main script
build_directory="$1"
mkdir -p "${build_directory}"
cd "${build_directory}" || exit

cp -r ../conda-recipe .
cp ../CMakeLists.txt .
cp -r ../src .

PATH=$HOME/Deps/conda/bin${PATH:+:$PATH}

conda config --append channels conda-forge

conda build conda-recipe

conda install --use-local conda-example-hybrid

env OMP_NUM_THREADS=2 mpirun -np 2 hybrid-hello

exit $?
