package day04

import (
	"errors"
	"regexp"
	"strconv"
	"strings"
)

var numParser = regexp.MustCompile(`(\d+)`)

func SolveA(input []string) (int, error) {
	sum := 0
	for _, card := range input {
		winners, held, err := ParseCard(card)
		if err != nil {
			return 0, err
		}
		wins := Intersect(winners, held)
		if len(wins) > 0 {
			sum += 1 << (len(wins) - 1)
		}
	}
	return sum, nil
}

func SolveB(input []string) (int, error) {
	return 0, nil
}

func ParseCard(line string) ([]int, []int, error) {
	parts := strings.Split(line, ":")
	if len(parts) != 2 {
		return nil, nil, errors.New("invalid card (no :)")
	}
	parts = strings.Split(parts[1], "|")
	if len(parts) != 2 {
		return nil, nil, errors.New("invalid card (no |)")
	}

	rawWinners, rawHeld := parts[0], parts[1]
	winners, err := StringToIntList(rawWinners)
	if err != nil {
		return nil, nil, err
	}

	held, err := StringToIntList(rawHeld)
	if err != nil {
		return nil, nil, err
	}

	return winners, held, nil
}

func StringToIntList(input string) ([]int, error) {
	rawNums := numParser.FindAllString(input, -1)
	values := make([]int, 0)
	for _, rawNum := range rawNums {
		value, err := strconv.Atoi(rawNum)
		if err != nil {
			return nil, err
		}
		values = append(values, value)
	}
	return values, nil
}

// does the list contain the value?
func Contains[T comparable](list []T, value T) bool {
	for _, li := range list {
		if li == value {
			return true
		}
	}
	return false
}

// returns the intersection of A and B, including duplicates if they are in B
func Intersect[T comparable](lista []T, listb []T) []T {
	listamap := make(map[T]bool, len(lista))
	for _, a := range lista {
		listamap[a] = true
	}

	intersection := make([]T, 0)
	for _, b := range listb {
		if listamap[b] == true {
			intersection = append(intersection, b)
		}
	}

	return intersection
}
