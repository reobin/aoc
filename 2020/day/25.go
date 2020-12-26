package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay25 runs aoc day 25 challenge
func RunDay25(input string) (string, string) {
	values := strings.Split(str.RemoveEmptyLines(input), "\n")
	cardLoopSize := computeLoopSize(values[0], 7)
	doorKey, _ := strconv.Atoi(values[1])
	key := computeKey(doorKey, cardLoopSize)
	return key, ""
}

func computeKey(subjectNumber int, loopSize int) string {
	value := 1
	for i := 0; i < loopSize; i++ {
		value = transformSubjectNumber(value, subjectNumber)
	}
	return strconv.Itoa(value)
}

func transformSubjectNumber(value int, subjectNumber int) int {
	return (value * subjectNumber) % 20201227
}

func computeLoopSize(key string, subjectNumber int) int {
	keyValue, err := strconv.Atoi(key)
	if err != nil {
		return -1
	}

	size := 0
	value := 1
	for value != keyValue {
		value = transformSubjectNumber(value, subjectNumber)
		size++
	}

	return size
}
