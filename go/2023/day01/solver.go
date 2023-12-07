package day01

import (
	"errors"
	"fmt"
	"regexp"
	"strconv"
)

func SolveA(input []string) (string, error) {
	sum := 0
	for _, line := range input {
		first := firstIntA(line)
		last := lastIntA(line)
		if first == "" && last == "" {
			continue
		}
		lineSum, err := strconv.ParseInt(first+last, 10, 0)

		if err != nil {
			fmt.Printf("Error parsing %v: %v\n", line, err)
			return "", err
		}

		sum += int(lineSum)
	}
	return fmt.Sprintf("%v", sum), nil
}

func firstIntA(line string) string {
	digit := regexp.MustCompile(`\d`)
	matches := digit.FindAllString(line, -1)
	if matches == nil {
		return ""
	} else {
		return matches[0]
	}
}

func lastIntA(line string) string {
	digit := regexp.MustCompile(`\d`)
	matches := digit.FindAllString(line, -1)
	if matches == nil {
		return ""
	} else {
		return matches[len(matches)-1]
	}
}

func SolveB(input []string) (string, error) {
	sum := 0
	for _, line := range input {
		first, err := firstIntB(line)
		if err != nil {
			continue
		}
		last, err := lastIntB(line)
		if err != nil {
			continue
		}

		lineSum, err := strconv.ParseInt(first+last, 10, 0)

		if err != nil {
			fmt.Printf("Error parsing %v: %v\n", line, err)
			return "", err
		}

		sum += int(lineSum)
	}
	return fmt.Sprintf("%v", sum), nil
}

var WORD_TO_DIGIT = map[string]string{
	"one":   "1",
	"two":   "2",
	"three": "3",
	"four":  "4",
	"five":  "5",
	"six":   "6",
	"seven": "7",
	"eight": "8",
	"nine":  "9",
	"eno":   "1",
	"owt":   "2",
	"eerht": "3",
	"ruof":  "4",
	"evif":  "5",
	"xis":   "6",
	"neves": "7",
	"thgie": "8",
	"enin":  "9",
}

func firstIntB(line string) (string, error) {
	digit := regexp.MustCompile(`one|two|three|four|five|six|seven|eight|nine|\d`)
	matches := digit.FindAllString(line, -1)
	if matches == nil {
		return "", errors.New("no matches")
	} else {
		match := matches[0]
		fromWord := WORD_TO_DIGIT[match]
		if fromWord != "" {
			return fromWord, nil
		} else {
			return match, nil
		}
	}
}

func lastIntB(line string) (string, error) {
	digit := regexp.MustCompile(`eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|\d`)
	rev := reverseString(line)
	matches := digit.FindAllString(rev, -1)
	if matches == nil {
		return "", errors.New("no matches")
	} else {
		match := matches[0]
		fromWord := WORD_TO_DIGIT[match]
		if fromWord != "" {
			return fromWord, nil
		} else {
			return match, nil
		}
	}
}

// thanks:copilot
func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
