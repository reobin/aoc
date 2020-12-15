package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/str"
)

type gameState struct {
	spokenNumbers    map[int][]int
	lastNumberSpoken int
}

// RunDay15 runs aoc day 15 challenge
func RunDay15(input string) (string, string) {
	startingNumbers := number.ConvertToNumbers(strings.Split(str.RemoveEmptyLines(input), ","))

	lastNumberSpokenPart1 := playGame(startingNumbers, 2020)

	// commented out to avoid delaying tests
	// lastNumberSpokenPart2 := playGame(startingNumbers, 30000000)

	return strconv.Itoa(lastNumberSpokenPart1), "" //  strconv.Itoa(lastNumberSpokenPart2)
}

func playGame(startingNumbers []int, turnCount int) int {
	state := gameState{spokenNumbers: make(map[int][]int)}

	for index, startingNumber := range startingNumbers {
		state.spokenNumbers[startingNumber] = []int{index + 1}
		state.lastNumberSpoken = startingNumber
	}

	for turn := len(startingNumbers) + 1; turn <= turnCount; turn++ {
		nextNumber := state.speakNextNumber()
		state.spokenNumbers[nextNumber] = append(state.spokenNumbers[nextNumber], turn)
		state.lastNumberSpoken = nextNumber
	}

	return state.lastNumberSpoken
}

func (state gameState) speakNextNumber() int {
	var nextNumber int

	timesSpokenCount := len(state.spokenNumbers[state.lastNumberSpoken])

	if timesSpokenCount == 1 {
		nextNumber = 0
	}

	if timesSpokenCount > 1 {
		lastTurn := state.spokenNumbers[state.lastNumberSpoken][timesSpokenCount-1]
		previousToLastTurn := state.spokenNumbers[state.lastNumberSpoken][timesSpokenCount-2]
		nextNumber = lastTurn - previousToLastTurn
	}

	return nextNumber
}
