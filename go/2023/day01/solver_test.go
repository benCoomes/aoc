package day01

import (
	"fmt"
	"log"
	"os"
	"strings"
	"testing"
)

func Test_A_Sample(t *testing.T) {
	value, err := SolveA(readSampleA())
	report(t, value, "142", err)
}

func Test_A_Full(t *testing.T) {
	value, err := SolveA(readInput())
	report(t, value, "54940", err)
}

func Test_B_Sample(t *testing.T) {
	value, err := SolveB(readSampleB())
	report(t, value, "281", err)
}

func Test_B_Full(t *testing.T) {
	value, err := SolveB(readInput())
	report(t, value, "", err)
}

// twone
// sevenine
// eightwo
// eighthree
func Test_B_Edge(t *testing.T) {
	value, err := SolveB([]string{"sevenshxtsixzdfjvpcsc5jvjhgzbssbrqtwonemx"})
	report(t, value, "71", err)
}

func report(t *testing.T, value string, expected string, err error) {
	if err != nil {
		t.Fatalf(err.Error())
	}

	if expected == "" {
		t.Logf("Value: %v", value)
	} else {
		if value != expected {
			t.Fatalf("Expected %v but got %v", expected, value)
		} else {
			t.Logf("Pass! Value: %v", value)
		}
	}
}

func readInput() []string {
	return readFile("input")
}

func readSampleA() []string {
	return readFile("sample-a")
}

func readSampleB() []string {
	return readFile("sample-b")
}

func readFile(kind string) []string {
	data, err := os.ReadFile(fmt.Sprintf("%s.txt", kind))
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
