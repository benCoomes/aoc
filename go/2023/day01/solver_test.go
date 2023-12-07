package day01

import (
	"testing"

	"github.com/benCoomes/aoc/go/2023/input"
	"github.com/benCoomes/aoc/go/2023/test"
)

func Test_A_Sample(t *testing.T) {
	value, err := SolveA(input.ReadSampleA())
	test.Report(t, value, "142", err)
}

func Test_A_Full(t *testing.T) {
	value, err := SolveA(input.ReadInput())
	test.Report(t, value, "54940", err)
}

func Test_B_Sample(t *testing.T) {
	value, err := SolveB(input.ReadSampleB())
	test.Report(t, value, "281", err)
}

func Test_B_Full(t *testing.T) {
	value, err := SolveB(input.ReadInput())
	test.Report(t, value, "54208", err)
}

// twone
// sevenine
// eightwo
// eighthree
func Test_B_Edge(t *testing.T) {
	value, err := SolveB([]string{"sevenshxtsixzdfjvpcsc5jvjhgzbssbrqtwonemx"})
	test.Report(t, value, "71", err)
}
