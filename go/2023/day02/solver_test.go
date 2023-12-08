package day02

import (
	"testing"

	"github.com/benCoomes/aoc/go/2023/input"
	"github.com/benCoomes/aoc/go/2023/test"
)

func Test_A_Sample(t *testing.T) {
	value, err := SolveA(input.ReadSampleA())
	test.Report(t, value, 8, err)
}

func Test_A_Full(t *testing.T) {
	value, err := SolveA(input.ReadInput())
	test.Report(t, value, 2416, err)
}

func Test_B_Sample(t *testing.T) {
	value, err := SolveB(input.ReadSampleB())
	test.Report(t, value, 2286, err)
}

func Test_B_Full(t *testing.T) {
	value, err := SolveB(input.ReadInput())
	test.Report(t, value, 63307, err)
}
