package input

import (
	"fmt"
	"log"
	"os"
	"strings"
)

func ReadInput() []string {
	return ReadFile("input.txt")
}

func ReadSampleA() []string {
	return ReadFile("sample-a.txt")
}

func ReadSampleB() []string {
	return ReadFile("sample-b.txt")
}

func ReadFile(name string) []string {
	data, err := os.ReadFile(name)
	if err != nil {
		log.Fatal(err)
	}

	str := string(data)
	return strings.Split(str, "\n")
}

// todo: bench this vs my readFile
func copilotReadFile(name string) []string {
	file, err := os.Open(name)
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
