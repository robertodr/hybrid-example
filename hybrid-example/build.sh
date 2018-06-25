#!/usr/bin/env bash

# append conda-forge channel
conda config --append channels conda-forge

# load Intel compilers
set +x
. /global/hds/software/cpu/eb3/icc/2018.1.163-GCC-6.4.0-2.28/compilers_and_libraries_2018.1.163/linux/bin/compilervars.sh intel64
. /global/hds/software/cpu/eb3/ifort/2018.1.163-GCC-6.4.0-2.28/compilers_and_libraries_2018.1.163/linux/bin/compilervars.sh intel64
. /global/hds/software/cpu/eb3/imkl/2018.1.163-iimpi-2018a/bin/compilervars.sh intel64
set -x

# configure
"${BUILD_PREFIX}"/bin/cmake \
                 -H"${SRC_DIR}" \
                 -Bbuild_conda \
                 -G"${CMAKE_GENERATOR}" \
                 -DCMAKE_CXX_COMPILER=icpc \
                 -DCMAKE_INSTALL_PREFIX="${PREFIX}"

# build
cmake --build build_conda --target install

# test
env OMP_NUM_THREADS=2 mpirun -np 2 hybrid-hello

# clean up additional channels
conda config --remove channels conda-forge
