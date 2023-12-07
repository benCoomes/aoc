#!/bin/bash

# usage: ./setup-problem <year> <day>

# prereqs:

# Store your AoC session cookie in keychain:
# security add-generic-password -a "$USER" -s "AOC_SESSION" -w "session=<YOUR_SESSION>"

# Then export the AOC_SESSION variable:
# export AOC_SESSION=$(security find-generic-password -s "AOC_SESSION" -w)

if [ "$#" -ne 2 ]; then
  echo "usage: ./setup <year> <day>"
  exit 1
fi

# strip leading zeros (and throw if not number)
YEAR=$((10#$1))
DAY=$((10#$2))
RAWDAY=$2

PROBLEM_DIR="$YEAR/day$RAWDAY"

mkdir -p $PROBLEM_DIR
cd $PROBLEM_DIR
touch sample-a.txt
touch sample-b.txt
curl --cookie $AOC_SESSION https://adventofcode.com/$YEAR/day/$DAY/input > input.txt
