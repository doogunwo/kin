#!/bin/bash

pushd organizations/fabric-ca
    rm -rf ordererOrg org1 org2
popd
pushd organizations
    rm -rf ordererOrganizations peerOrganizations
popd
docker-compose down

rm -rf config/*