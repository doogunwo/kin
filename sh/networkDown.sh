#!/bin/bash
set -ex
pushd ../network
./network.sh down
popd

#clean
rm -rf ../wallet/*