#!/bin/bash

set -x
# 환경변수설정, configtx.yaml을 가르키는 환경변수 생성 -> configtxgen 유틸리티가 접근
export FABRIC_CFG_PATH=${PWD} 

# 초기화
rm -rf config
rm -rf organizations/ordererOrganizations
rm -rf organizations/peerOrganizations

# 디렉토리 구성
mkdir config

# identity 생성
cryptogen generate --config=./crypto-config.yaml --output="organizations"

# 제네시스블록 생성
configtxgen -profile TwoOrgsOrdererGenesis -channelID system-channel -outputBlock ./config/genesis.block

# 채널트랜젝션 생성
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./config/mychannel.tx -channelID mychannel

# 앵커 트랜젝션 생성
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org1MSPAnchor.tx -channelID mychannel -asOrg Org1MSP

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org2MSPAnchor.tx -channelID mychannel -asOrg Org2MSP