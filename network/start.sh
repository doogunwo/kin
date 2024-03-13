#!/bin/bash

NET_DIR=$PWD
export FABRIC_CFG_PATH=$PWD

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${NET_DIR}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_ORG1_CA=${NET_DIR}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export PEER0_ORG2_CA=${NET_DIR}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

# 환경설정 함수 setEnv
setEnv() {
    ORG=$1
    if [ $ORG -eq 1 ]; then
        export CORE_PEER_LOCALMSPID="Org1MSP"
        export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
        export CORE_PEER_MSPCONFIGPATH=${NET_DIR}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
        export CORE_PEER_ADDRESS=localhost:7051
    else
        export CORE_PEER_LOCALMSPID="Org2MSP"
        export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
        export CORE_PEER_MSPCONFIGPATH=${NET_DIR}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
        export CORE_PEER_ADDRESS=localhost:9051
    fi
}
set -ev
# docker-compose -> container up
docker-compose up -d

sleep 5

# org1 환경변수 설정
setEnv 1

# 채널 생성
peer channel create -o localhost:7050 -c mychannel --ordererTLSHostnameOverride orderer.example.com -f ./config/mychannel.tx --outputBlock ./config/mychannel.block --tls --cafile $ORDERER_CA 

sleep 3

# 채널 조인 x 2

peer channel join -b ./config/mychannel.block 

# org2 환경변수 설정
setEnv 2
peer channel join -b ./config/mychannel.block 

sleep 3

# 앵커 업데이트 x 2
# org1 환경변수 설정
setEnv 1
peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c mychannel -f ./config/Org1MSPAnchor.tx --tls --cafile $ORDERER_CA 

# org2 환경변수 설정
setEnv 2
peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c mychannel -f ./config/Org2MSPAnchor.tx --tls --cafile $ORDERER_CA 