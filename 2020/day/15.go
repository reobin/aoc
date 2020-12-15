package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay15 runs aoc day 15 challenge
func RunDay15(input string) (string, string) {
	startingNumbers := number.ConvertToNumbers(strings.Split(str.RemoveEmptyLines(input), ","))

	lastNumberSpokenPart1 := playGame(startingNumbers, 2020)
	lastNumberSpokenPart2 := playGame(startingNumbers, 30000000)

	return strconv.Itoa(lastNumberSpokenPart1), strconv.Itoa(lastNumberSpokenPart2)
}

func playGame(startingNumbers []int, turnCount int) int {
	spokenNumbers := make(map[int][]int)
	lastNumberSpoken := 0

	for index, startingNumber := range startingNumbers {
		spokenNumbers[startingNumber] = []int{index + 1}
		lastNumberSpoken = startingNumber
	}

	for turn := len(startingNumbers) + 1; turn <= turnCount; turn++ {
		timesSpokenCount := len(spokenNumbers[lastNumberSpoken])
		if timesSpokenCount == 1 {
			lastNumberSpoken = 0
		}

		if timesSpokenCount > 1 {
			lastTurn := spokenNumbers[lastNumberSpoken][timesSpokenCount-1]
			previousToLastTurn := spokenNumbers[lastNumberSpoken][timesSpokenCount-2]
			lastNumberSpoken = lastTurn - previousToLastTurn
		}

		spokenNumbers[lastNumberSpoken] = append(spokenNumbers[lastNumberSpoken], turn)
	}

	return lastNumberSpoken
}
