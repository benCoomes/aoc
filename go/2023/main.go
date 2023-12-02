package main

import (
	"fmt"
	"os"
	"strconv"
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

	folder := fmt.Sprintf("day%d", day)
	switch day {
	case 1:
		day01(folder+"/sample.txt", folder+"/input.txt")
	default:
		fmt.Println("Unknown day:", day)
	}
}

func day01(sample string, input string) {
	fmt.Println("Day 1")
	fmt.Println("Sample file:", sample)
	fmt.Println("Input file:", input)
}
