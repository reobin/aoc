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
		peopleEntries := strings.Split(str.RemoveEmptyLines(group), "\n")

		uniqueQuestions := make(map[string]int)

		for _, personEntry := range peopleEntries {
			questions := strings.Split(personEntry, "")

			for _, question := range questions {
				uniqueQuestions[string(question)]++
				if uniqueQuestions[string(question)] == len(peopleEntries) {
					questionCountSumPart2++
				}
			}
		}

		questionCountSumPart1 += len(uniqueQuestions)
	}

	return strconv.Itoa(questionCountSumPart1), strconv.Itoa(questionCountSumPart2)
}
