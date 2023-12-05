package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"

	"github.com/benCoomes/aoc/go/2023/day01"
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
		value, err := day01.Solve(readSample(day))
		report(value, "", err)
		//value, err = day01.Solve(readInput(day))
		//report(value, "", err)
	case 2:
		// todo
	default:
		fmt.Println("Unknown day:", day)
		os.Exit(1)
	}
}

func report(value string, expected string, err error) {
	if err != nil {
		panic(err)
	}

	if expected == "" {
		fmt.Printf("Value: %v", value)
	} else {
		if value != expected {
			fmt.Printf("Expected %v but got %v\n", expected, value)
		} else {
			fmt.Printf("Pass! Value: %v", value)
		}
	}
}

func readInput(day int) []string {
	return readFile(day, "input")
}

func readSample(day int) []string {
	return readFile(day, "sample")
}

func readFile(day int, kind string) []string {
	data, err := os.ReadFile(fmt.Sprintf("./2023/inputs/day%02d-%s.txt", day, kind))
	if err != nil {
		log.Fatal(err)
	}

	str := string(data)
	return strings.Split(str, "\n")
}

// todo: bench this vs my readFile
func copilotReadFile(day int, kind string) []string {
	file, err := os.Open(fmt.Sprintf("./2023/inputs/day%02d-%s.txt", day, kind))
	if err != nil {
		panic(err)
	}
	defer file.Close()

	var lines []string
	for {
		var line string
		_, err := fmt.Fscanf(file, "%s", &line)
		if err != nil {
			break
		}
		lines = append(lines, line)
	}

	return lines
}
