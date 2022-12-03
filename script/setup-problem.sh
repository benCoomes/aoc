#!/bin/zsh

# usage: ./setup-problem <year> <day>

# prereqs:
# Store your AoC session cookie in keychain:
# security add-generic-password -a "$USER" -s "AOC_SESSION" -w "session=<YOUR_SESSION>"

if [ "$#" -ne 2 ]; then
  echo "usage: ./setup-problem <year> <day>"
  exit 1
fi

# strip leading zeros (and throw if not number)
YEAR=$((10#$1))
DAY=$((10#$2))

PROBLEM_DIR="$YEAR/day$DAY"

mkdir -p $PROBLEM_DIR
cp -n $(dirname "$0")/../templates/solution.rb $PROBLEM_DIR/solution.rb
curl --cookie $AOC_SESSION https://adventofcode.com/$YEAR/day/$DAY/input > $PROBLEM_DIR/input.txt
