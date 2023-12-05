package day01

import (
	"fmt"
	"regexp"
	"strconv"
)

func Solve(input []string) (string, error) {
	sum := 0
	for _, line := range input {
		first := firstInt(line)
		last := lastInt(line)
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

func firstInt(line string) string {
	digit := regexp.MustCompile(`\d`)
	matches := digit.FindAllString(line, -1)
	if matches == nil {
		return ""
	} else {
		return matches[0]
	}
}

func lastInt(line string) string {
	digit := regexp.MustCompile(`\d`)
	matches := digit.FindAllString(line, -1)
	if matches == nil {
		return ""
	} else {
		return matches[len(matches)-1]
	}
}
