#!/bin/bash
set -e
CHAINCODE_PATH="/home/doogunwo/Desktop/kin/chaincode-go/test"

sudo rm -rf go/wallet/*

pushd ~/fabric-samples/test-network
./network.sh down
./network.sh up createChannel -ca -s coutchdb
./network.sh deployCC -ccn fabcar -ccv 1 -cci initLedger -ccl go -ccp "${CHAINCODE_PATH}"
popd

cat << EOF

Go:

  Start by changing into the "go" directory:
    cd go

  Then, install dependencies and run the test using:
    go run fabcar.go

  The test will invoke the sample client app which perform the following:
    - Import user credentials into the wallet (if they don't already exist there)
    - Submit a transaction to create a new car
    - Evaluate a transaction (query) to return details of this car
    - Submit a transaction to change the owner of this car
    - Evaluate a transaction (query) to return the updated details of this car

EOF