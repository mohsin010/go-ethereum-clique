#!/bin/bash

bootnodeAddress=$(geth attach --datadir duli1 --exec 'admin.nodeInfo.enr' | jq -r '.')
networkId=32382
func="admin,miner,txpool,web3,personal,eth,net"
gethPW=./geth_pw/geth_password.txt
jwt=./config/jwt.hex

geth --datadir=duli$1 --networkid=32382 init ./config/genesis.json

if [ $1 -eq 1 ]; then
geth \
--keystore=./keystore/keystore1 \
--networkid=$networkId \
--syncmode=full \
--datadir=./duli$1 \
--unlock=0xaca8126914b246634b08d4f9fdf31a1970ed9005 \
--password=$gethPW \
--allow-insecure-unlock \
--http \
--http.api $func \
--ws \
--http.addr "0.0.0.0" \
--http.port=9000 \
--ws.port=8546 \
--authrpc.addr localhost \
--authrpc.port=8551 \
--port=30303 \
--nat extip:192.168.0.170 \
--miner.extradata="nvirg" \
--mine
