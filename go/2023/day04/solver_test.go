package day04

import (
	"testing"

	"github.com/benCoomes/aoc/go/2023/input"
	"github.com/benCoomes/aoc/go/2023/test"
)

func Test_A_Sample(t *testing.T) {
	value, err := SolveA(input.ReadSampleA())
	test.Report(t, value, 13, err)
}

func Test_A_Full(t *testing.T) {
	value, err := SolveA(input.ReadInput())
	test.Report(t, value, 27059, err)
}

func Test_B_Sample(t *testing.T) {
	value, err := SolveB(input.ReadSampleB())
	test.Report(t, value, 30, err)
}

func Test_B_Full(t *testing.T) {
	value, err := SolveB(input.ReadInput())
	test.Report(t, value, 0, err)
}
