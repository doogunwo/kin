#!/bin/bash


# 초기화
sudo rm -rf config
sudo rm -rf organizations/ordererOrganizations
sudo rm -rf organizations/peerOrganizations

# 디렉토리 구성
if [ ! -d config ]; then
    mkdir config
fi

# identity 생성
sudo ../bin/cryptogen generate --config=./crypto-config.yaml --output="organizations"

# 제네시스블록 생성
sudo ../bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID system-channel -outputBlock ./config/genesis.block

# 채널트랜젝션 생성
sudo ../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./config/mychannel.tx -channelID mychannel

# 앵커 트랜젝션 생성
sudo ../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org1MSPAnchor.tx -channelID mychannel -asOrg Org1MSP

sudo ../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org2MSPAnchor.tx -channelID mychannel -asOrg Org2MSP