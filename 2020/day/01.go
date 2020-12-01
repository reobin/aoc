package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/internal/number"
)

// RunDay01 runs aoc day 1 challenge
func RunDay01(input string) (string, string) {
	lines := strings.Split(input, "\n")

	expenseReport := number.ConvertToNumbers(lines)

	entriesPart1 := findEntries(expenseReport, 2, 2020)
	answerPart1 := number.ComputeProduct(entriesPart1)

	entriesPart2 := findEntries(expenseReport, 3, 2020)
	answerPart2 := number.ComputeProduct(entriesPart2)

	return strconv.Itoa(answerPart1), strconv.Itoa(answerPart2)
}

func findEntries(report []int, entryCount int, target int) []int {
	if entryCount == 1 && number.Contains(report, target) {
		return []int{target}
	}

	if entryCount == 1 {
		return []int{}
	}

	for index, entry := range report {
		newTarget := target - entry
		newReport := report[index+1:]
		foundEntries := findEntries(newReport, entryCount-1, newTarget)
		if len(foundEntries) == 0 {
			continue
		}
		return append(foundEntries, entry)
	}

	return []int{}
}
