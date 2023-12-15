package day03

import (
	"regexp"
	"strconv"
)

var numParser = regexp.MustCompile(`\d+`)

func SolveA(input []string) (int, error) {
	charmap := [][]rune{}
	for _, line := range input {
		charmap = append(charmap, []rune(line))
	}

	sum := 0
	for y, line := range input {
		num_indices := numParser.FindAllStringIndex(line, -1)
		for _, indices := range num_indices {
			value, err := strconv.Atoi(line[indices[0]:indices[1]])
			if err != nil {
				return 0, err
			}

			hasAdjSym := false
			for x := indices[0]; x < indices[1]; x++ {
				adj := Adjacent(charmap, x, y)
				if HasSym(adj) {
					hasAdjSym = true
					break
				}
			}

			if hasAdjSym {
				sum += value
			}
		}
	}
	return sum, nil

}

var gearParser = regexp.MustCompile(`\*`)

func SolveB(input []string) (int, error) {
	sum := 0
	for y, line := range input {
		// find gears
		gears := gearParser.FindAllStringIndex(line, -1)
		for _, gear_index := range gears {
			numbers := make([]int, 0)
			// parse numbers for line, above, and below
			for li := y - 1; li <= y+1; li++ {
				if li < 0 || li >= len(input) {
					continue
				}
				line = input[li]
				adjnums, err := AdjacentNumbers(line, gear_index[0])
				if err != nil {
					return 0, err
				}
				numbers = append(numbers, adjnums...)
			}
			if len(numbers) == 2 {
				// a gear!
				sum += numbers[0] * numbers[1]
			}
		}
	}

	return sum, nil
}

func AdjacentNumbers(line string, index int) ([]int, error) {
	numbers := make([]int, 0)
	num_indices := numParser.FindAllStringIndex(line, -1)
	for _, indices := range num_indices {
		// x1 <= g+1 && x2 >= x-1 should work for all lines
		if indices[0] <= index+1 && indices[1] >= index {
			value, err := strconv.Atoi(line[indices[0]:indices[1]])
			if err != nil {
				return nil, err
			}
			numbers = append(numbers, value)
		}
	}
	return numbers, nil
}

type Coord struct {
	x int
	y int
}

func Adjacent(charmap [][]rune, x, y int) []rune {
	// 3 4 5
	// 2 X 6
	// 1 8 7
	var adj = []Coord{
		{x - 1, y - 1},
		{x - 1, y},
		{x - 1, y + 1},
		{x, y + 1},
		{x + 1, y + 1},
		{x + 1, y},
		{x + 1, y - 1},
		{x, y - 1},
	}

	chars := []rune{}
	for _, a := range adj {
		if a.y < 0 || a.y >= len(charmap) {
			continue
		}
		row := charmap[a.y]

		if a.x < 0 || a.x >= len(row) {
			continue
		}

		chars = append(chars, row[a.x])
	}

	return chars
}

// =*+/&#%\-$@
var SYMBOLS = []rune{'@', '#', '$', '%', '^', '&', '*', '-', '+', '=', '/', '\\'}

func HasSym(runes []rune) bool {
	for _, sym := range SYMBOLS {
		for _, r := range runes {
			if r == sym {
				return true
			}
		}
	}
	return false
}
