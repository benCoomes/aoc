package day02

import (
	"errors"
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

type game struct {
	hands []hand
	id    int
}

type hand struct {
	red   int
	blue  int
	green int
}

var gameIdParser = regexp.MustCompile(`Game (\d+)`)
var handParser = regexp.MustCompile(`(\d+) ([a-z]+)`)

func SolveA(input []string) (int, error) {
	value := 0
	for _, line := range input {
		game, err := ParseGame(line)
		if err != nil {
			fmt.Printf("Error parsing game: %v, %v\n", line, err)
			continue
		}

		if IsPossible(*game, 12, 13, 14) {
			value += game.id
		}
	}

	return value, nil
}

func SolveB(input []string) (int, error) {
	value := 0
	for _, line := range input {
		game, err := ParseGame(line)
		if err != nil {
			fmt.Printf("Error parsing game: %v, %v\n", line, err)
			continue
		}

		value += Power(*game)
	}

	return value, nil
}

func ParseGame(input string) (*game, error) {
	parts := strings.Split(input, ":")
	if len(parts) != 2 {
		return nil, errors.New("invalid game")
	}
	gamestr, handsstr := parts[0], parts[1]

	matches := gameIdParser.FindStringSubmatch(gamestr)
	if matches == nil {
		return nil, errors.New("invalid game id")
	}
	id, err := strconv.Atoi(matches[1])
	if err != nil {
		return nil, err
	}

	hands := []hand{}
	rawhands := strings.Split(handsstr, ";")
	for _, rawhand := range rawhands {
		hand, err := ParseHand(rawhand)
		if err != nil {
			return nil, err
		}
		hands = append(hands, *hand)
	}

	return &game{
		hands: hands,
		id:    id,
	}, nil
}

func ParseHand(rawhand string) (*hand, error) {
	matches := handParser.FindAllStringSubmatch(rawhand, -1)
	if matches == nil {
		return nil, errors.New("invalid hand")
	}

	hand := hand{
		red:   0,
		blue:  0,
		green: 0,
	}
	for _, match := range matches {
		// 0:match text, 1:count, 2:color
		count, err := strconv.Atoi(match[1])
		if err != nil {
			return nil, err
		}

		switch match[2] {
		case "red":
			hand.red += count
		case "blue":
			hand.blue += count
		case "green":
			hand.green += count
		default:
			return nil, errors.New("invalid hand color")
		}

	}
	return &hand, nil
}

func IsPossible(game game, redCount int, greenCount int, blueCount int) bool {
	for _, hand := range game.hands {
		if hand.red > redCount {
			return false
		}
		if hand.blue > blueCount {
			return false
		}
		if hand.green > greenCount {
			return false
		}
	}
	return true
}

func Power(game game) int {
	minRed := 0
	minBlue := 0
	minGreen := 0
	for _, hand := range game.hands {
		if hand.red > minRed {
			minRed = hand.red
		}
		if hand.blue > minBlue {
			minBlue = hand.blue
		}
		if hand.green > minGreen {
			minGreen = hand.green
		}
	}
	return minRed * minBlue * minGreen
}
