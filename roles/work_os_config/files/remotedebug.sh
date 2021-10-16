#!/bin/bash
# usage:
# ./remotedebug.sh issues [dev|testing] 5006 # last arg Port is optional

backendName=$1
env=${2:-dev}

kubectl get pods -n $env-taxa > /tmp/pods.txt

sed -i -n "/^$backendName/p" /tmp/pods.txt # find all pods starting with arg 1

sed -i -n "/backend/p" /tmp/pods.txt # find backend pod

sed -i '/-db-/d' /tmp/pods.txt # remove DB pod for list

if [ ! `wc -l < /tmp/pods.txt` = 1 ]; then
        echo "no or more than on pod found having name, starting with '$backendName' and containing 'backend'.\nSee /tmp/pods.txt"; exit 1;
fi

podDescString=`cat /tmp/pods.txt`
podDesc=($podDescString)
podname=${podDesc[0]}

echo "executing command: kubectl -n $env-taxa port-forward $podname ${3:-5005}:5005"

kubectl -n $env-taxa port-forward $podname ${3:-5005}:5005
