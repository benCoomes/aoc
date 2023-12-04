package main

import (
	"fmt"
	"os"
	"strconv"

	"github.com/benCoomes/aoc/go/2023/day01"
	"github.com/benCoomes/aoc/go/2023/day02"
)

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: go run main.go <day>")
		os.Exit(1)
	}

	day, err := strconv.Atoi(os.Args[1])
	if err != nil {
		panic("Cannot convert to int: '" + os.Args[1] + "'")
	}

	switch day {
	case 1:
		report(day01.Solve([]string{"sample"}))
	case 2:
		report(day02.Solve([]string{"sample"}))
	default:
		fmt.Println("Unknown day:", day)
		os.Exit(1)
	}
}

func report(value string, err error) {
	if err != nil {
		panic(err)
	}

	fmt.Println(value)
}
