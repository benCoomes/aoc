#!/bin/zsh

# usage: ./setup <year> <day>

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

PROBLEM_DIR="$YEAR/day$DAY"

mkdir -p $PROBLEM_DIR
cp -n $(dirname "$0")/../templates/*.rb $PROBLEM_DIR
touch $PROBLEM_DIR/sample.txt
curl --cookie $AOC_SESSION https://adventofcode.com/$YEAR/day/$DAY/input > $PROBLEM_DIR/input.txt
