#!/bin/bash

PHONEBOOK="phonebook.txt"

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <이름> <전화번호>"
    exit 1
fi

name=$1
phone=$2

# 전화번호가 올바른지 확인하기
if ! [[ $phone =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]; then
    echo "올바르지 않은 전화번호입니다. 02-2222-2222 이나 031-222-2222 과 같은 전화번호 형식을 사용해주세요."
    exit 1
fi

# 입력한 전화번호에 따른 지역 설정하기
case "${phone:0:3}" in
    031) region="경기" ;;
    032) region="인천" ;;
    051) region="부산" ;;
    053) region="대구" ;;
    042) region="대전" ;;
    062) region="광주" ;;
    *)
        case "${phone:0:2}" in
            02) region="서울" ;;
            *) region="기타" ;;
        esac
    ;;
esac

if grep -q "^$name " $PHONEBOOK; then
    existing_phone=$(grep "^$name " $PHONEBOOK | awk '{print $2}')
    if [[ $existing_phone == $phone ]]; then
        echo "동일한 전화번호가 존재합니다."
        exit 0
    else
        grep -v "^$name " $PHONEBOOK > temp.txt && mv temp.txt $PHONEBOOK
    fi
fi

# 새로운 전화번호를 텍스트 파일에 추가하기
echo "$name $phone $region" >> $PHONEBOOK

# 이름순으로 전화번호부를 정렬해주기
sort $PHONEBOOK -o $PHONEBOOK

echo "Added/Updated $name with phone number $phone in region $region."
exit 0