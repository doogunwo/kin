#!/bin/bash

pushd organizations/fabric-ca
    sudo rm -rf ordererOrg org1 org2
popd
pushd organizations
    sudo rm -rf ordererOrganizations peerOrganizations
popd
docker-compose down

sudo rm -rf config/*