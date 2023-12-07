package day02

import (
	"testing"

	"github.com/benCoomes/aoc/go/2023/input"
	"github.com/benCoomes/aoc/go/2023/test"
)

func Test_A_Sample(t *testing.T) {
	value, err := SolveA(input.ReadSampleA())
	test.Report(t, value, "", err)
}
