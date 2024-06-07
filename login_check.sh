#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "사용법: $0 <사용자이름>"
    exit 1
fi

user=$1

while true; do
    if who | grep -q "^$user\b"; then
        echo "$user 로그인함!"
    else 
        echo "$user 로그인하지 않음."
    fi
    sleep 60
done