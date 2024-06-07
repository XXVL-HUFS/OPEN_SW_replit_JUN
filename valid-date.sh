#!/bin/bash

# 입력값 확인
if [ $# -ne 3 ]; then
    echo "입력값 오류"
    exit 1  # 오류 종료 코드
fi

# 변수 초기화
month=$(echo "$1" | tr '[:lower:]' '[:upper:]')
date="$2"
year="$3"
is_leap_year=0

# 월 변환 및 유효성 검사
case "$month" in
    JAN|JANUARY|1) month="Jan" ;;
    FEB|FEBRUARY|2) month="Feb" ;;
    MAR|MARCH|3) month="Mar" ;;
    APR|APRIL|4) month="Apr" ;;
    MAY|5) month="May" ;;
    JUN|JUNE|6) month="Jun" ;;
    JUL|JULY|7) month="Jul" ;;
    AUG|AUGUST|8) month="Aug" ;;
    SEP|SEPTEMBER|9) month="Sep" ;;
    OCT|OCTOBER|10) month="Oct" ;;
    NOV|NOVEMBER|11) month="Nov" ;;
    DEC|DECEMBER|12) month="Dec" ;;
    *) echo "월 입력 오류: $1은 유효하지 않습니다"
       exit 1 ;;
esac

# 윤년 계산
if [ $((year % 4)) -eq 0 ]; then
    if [ $((year % 100)) -eq 0 ]; then
        if [ $((year % 400)) -eq 0 ]; then
            is_leap_year=1
        fi
    else
        is_leap_year=1
    fi
fi

# 각 월의 일수 설정 (윤년 고려)
case "$month" in
    "Feb") max_date=$((28 + is_leap_year)) ;;
    "Apr"|"Jun"|"Sep"|"Nov") max_date=30 ;;
    *) max_date=31 ;;
esac

# 날짜 유효성 검사
if ! [[ "$date" =~ ^[0-9]+$ ]] || [ "$date" -lt 1 ] || [ "$date" -gt "$max_date" ]; then
    echo "날짜 입력 오류: $month $date $year은 유효하지 않습니다"
    exit 1
fi

# 유효한 날짜 출력
echo "$month $date $year"
