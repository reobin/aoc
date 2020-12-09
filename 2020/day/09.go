package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
)

// RunDay09 runs aoc day 9 challenge
func RunDay09(input string) (string, string) {
	xMasData := number.ConvertToNumbers(strings.Split(input, "\n"))
	preambleLength := 25

	invalidEntry := validateXmasData(xMasData, preambleLength)
	contiguousSummands := findContiguousSummands(xMasData, invalidEntry)
	weakness := computeWeakness(contiguousSummands)

	return strconv.Itoa(invalidEntry), strconv.Itoa(weakness)
}

func validateXmasData(xMasData []int, preambleLength int) int {
	sums := computeInitialSums(xMasData, preambleLength)

	for index, entry := range xMasData[preambleLength:] {
		if !number.Contains(sums, entry) {
			return entry
		}

		sums = sums[preambleLength:]

		for i := index; i < preambleLength+index; i++ {
			sums = append(sums, xMasData[i]+entry)
		}
	}

	return -1
}

func computeInitialSums(xMasData []int, preambleLength int) []int {
	var sums []int

	for i := 0; i < preambleLength; i++ {
		for j := 1; j < preambleLength; j++ {
			if i == j {
				continue
			}
			sums = append(sums, xMasData[i]+xMasData[j])
		}
	}

	return sums
}

func findContiguousSummands(xMasData []int, target int) []int {
	for index, entryA := range xMasData {
		summands := []int{entryA}

		if index == len(xMasData)-1 {
			break
		}

		for _, entryB := range xMasData[index+1:] {
			summands = append(summands, entryB)

			sum := number.ComputeSum(summands)

			if sum == target {
				return summands
			}

			if sum < target {
				continue
			}

			summands = []int{}
			break
		}
	}

	return []int{}
}

func computeWeakness(contiguousSummands []int) int {
	if len(contiguousSummands) < 2 {
		return -1
	}
	smallestSummand, biggestSummand := number.MinMax(contiguousSummands)
	return smallestSummand + biggestSummand
}
