package day

import (
	"strconv"
)

var up = "^"
var right = ">"
var down = "v"
var left = "<"

// Position represents a 2d position on a plan
type Position struct {
	x int
	y int
}

// RunDay03 runs aoc day 3 challenge
func RunDay03(input string) (string, string) {
	santasSoloHouseCount := runSanta(input)
	allSantasHouseCount := runAllSantas(input)

	return strconv.Itoa(santasSoloHouseCount), strconv.Itoa(allSantasHouseCount)
}

func runSanta(input string) int {
	houseSet := make(map[Position]bool)

	initialPosition := Position{x: 0, y: 0}
	currentPosition := initialPosition
	houseSet[initialPosition] = true

	for _, char := range input {
		command := string(char)
		if command == "" {
			continue
		}

		currentPosition = getNextPosition(command, currentPosition)
		houseSet[currentPosition] = true
	}

	return len(houseSet)
}

func runAllSantas(input string) int {
	houseSet := make(map[Position]bool)

	initialPosition := Position{x: 0, y: 0}
	santasPosition := initialPosition
	roboSantasPosition := initialPosition
	houseSet[initialPosition] = true

	for index, char := range input {
		command := string(char)
		if command == "" {
			continue
		}

		if index%2 == 0 {
			santasPosition = getNextPosition(command, santasPosition)
			houseSet[santasPosition] = true
		} else {
			roboSantasPosition = getNextPosition(command, roboSantasPosition)
			houseSet[roboSantasPosition] = true
		}
	}

	return len(houseSet)
}

func getNextPosition(command string, position Position) Position {
	switch command {
	case up:
		return Position{x: position.x, y: position.y - 1}
	case right:
		return Position{x: position.x + 1, y: position.y}
	case down:
		return Position{x: position.x, y: position.y + 1}
	case left:
		return Position{x: position.x - 1, y: position.y}
	default:
		return Position{x: position.x, y: position.y}
	}
}
