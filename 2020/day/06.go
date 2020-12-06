package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay06 runs aoc day 6 challenge
func RunDay06(input string) (string, string) {
	groups := strings.Split(input, "\n\n")

	questionCountSumPart1 := 0
	questionCountSumPart2 := 0

	for _, group := range groups {
		group = str.RemoveEmptyLines(group)

		peopleCount := len(strings.Split(group, "\n"))

		questions := strings.ReplaceAll(group, "\n", "")

		uniqueQuestionCount := str.CountCharacters(questions)
		for _, questionCount := range uniqueQuestionCount {
			questionCountSumPart1++
			if questionCount == peopleCount {
				questionCountSumPart2++
			}
		}
	}

	return strconv.Itoa(questionCountSumPart1), strconv.Itoa(questionCountSumPart2)
}
