package day

import (
	"sort"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
)

// RunDay10 runs aoc day 10 challenge
func RunDay10(input string) (string, string) {
	adapters := number.ConvertToNumbers(strings.Split(input, "\n"))

	sort.Ints(adapters)

	target := adapters[len(adapters)-1] + 3
	adapters = append([]int{0}, adapters...)
	adapters = append(adapters, target)

	difference1Count, difference3Count := countJoltageDifferences(adapters)
	arrangementCount := countArrangements(adapters)

	return strconv.Itoa(difference1Count * difference3Count), strconv.Itoa(arrangementCount)
}

func countJoltageDifferences(adapters []int) (int, int) {
	difference1Count := 0
	difference3Count := 0

	adapterMap := number.ConvertToMap(adapters)

	for _, adapter := range adapters {
		if adapterMap[adapter+1] {
			difference1Count++
			continue
		}

		if adapterMap[adapter+3] {
			difference3Count++
		}
	}

	return difference1Count, difference3Count
}

func countArrangements(adapters []int) int {
	adapterMap := make(map[int]int)
	adapterMap[0] = 1

	for index, adapter := range adapters {
		for _, nextAdapter := range adapters[index+1:] {
			difference := nextAdapter - adapter

			if difference > 3 {
				break
			}

			adapterMap[nextAdapter] += adapterMap[adapter]
		}
	}

	return adapterMap[adapters[len(adapters)-1]]
}
