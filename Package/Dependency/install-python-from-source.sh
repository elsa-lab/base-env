#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

PY_VER=$1
PY_NAME="Python ${PY_VER}"
PY_DOWN_LINK="https://www.python.org/ftp/python/${PY_VER}/Python-${PY_VER}.tgz"
PY_FILE_NAME=$(basename ${PY_DOWN_LINK})

TEMP_DIR=$(mktemp -d)
PY_SRC_DIR=${TEMP_DIR}/${PY_FILE_NAME%.*}
PY_INSTALL_DIR=$2/$1
PY_EXE=${PY_INSTALL_DIR}/bin/python${PY_VER%.*}

echo "Change directory to ${TEMP_DIR}"
cd ${TEMP_DIR}

echo "Download the source file of ${PY_NAME}"
wget ${PY_DOWN_LINK} > /dev/null

echo "Extract the source file of ${PY_NAME}"
tar zxf ${PY_FILE_NAME} > /dev/null

echo "Change directory to ${PY_SRC_DIR}"
cd ${PY_SRC_DIR}

echo "Configure ${PY_NAME}"
./configure --prefix=${PY_INSTALL_DIR} --enable-optimizations --with-lto --with-computed-gotos --with-system-ffi > /dev/null

echo "Build ${PY_NAME}"
make -j $(expr $(nproc) / 2) > /dev/null

echo "Install ${PY_NAME}"
make altinstall > /dev/null

echo "Install virtualenv for ${PY_NAME}"
${PY_EXE} -m pip install virtualenv > /dev/null

echo "Cleaning up"
rm -rf ${TEMP_DIR}

echo "${PY_NAME} is installed in ${PY_INSTALL_DIR}"
echo "Please create a virtual environment with the following command:"
echo "    ${PY_EXE} -m virtualenv -p ${PY_EXE} ENV_NAME"
