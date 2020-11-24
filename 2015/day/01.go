package day

import (
	"strconv"
)

var oneFloorUp = "("
var oneFloorDown = ")"

// RunDay01 runs aoc day 1 challenge
func RunDay01(input string) (string, string) {
	floor := 0
	firstBasementEntry := -1

	for index, character := range input {
		strCharacter := string(character)
		if strCharacter == oneFloorUp {
			floor++
		} else if strCharacter == oneFloorDown {
			floor--
		}

		if firstBasementEntry == -1 && floor < 0 {
			firstBasementEntry = index + 1
		}
	}

	return strconv.Itoa(floor), strconv.Itoa(firstBasementEntry)
}
