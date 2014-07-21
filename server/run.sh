#!/bin/sh

mkdir -p logs

while true; do
  UTS=`date "+%s"`
  lua ./starfuck-server.lua > logs/$UTS.log
  sleep 1
done
