#!/bin/bash

docker-compose up -d ca_org1 ca_org2 ca_orderer

sleep 5

# identity를 생성
. organizations/fabric_ca/registerEnroll.sh

createOrg1
createOrg2
createOrderer

# 제네시스블록, 채널트랜젝션 생성
./generate.sh

# 연결정보 생성
./organizations/ccp-generate.sh

# docker-compose -> container up
docker-compose up -d orderer.example.com peer0.org1.example.com peer0.org2.example.com

sleep 5