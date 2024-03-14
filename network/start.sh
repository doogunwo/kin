#!/bin/bash

# ca동작
docker-compose up -d ca_org1 ca_org2 ca_orderer
sleep 3

#identity 생성
./orgranizations/registerEnroll.sh

createOrg1
createOrg2
createOrderer

# genesis block , tx 생성
./generate.sh

# 연결정보 생성
./organizations/ccp-generate.sh

# docker-compose -> container up
docker-compose up -d orderer.example.com peer0.org1.example.com peer0.org2.example.com

sleep 5
