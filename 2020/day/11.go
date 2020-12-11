package day

import (
	"errors"
	"strconv"

	"github.com/reobin/aoc/2020/pkg/plan"
	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay11 runs aoc day 11 challenge
func RunDay11(input string) (string, string) {
	seatMap := plan.ConvertToPlan(str.RemoveEmptyLines(input))
	previousOccupiedSeatCountPart1 := -1
	for {
		occupiedSeatCount := countOccupiedSeats(seatMap)
		if occupiedSeatCount == previousOccupiedSeatCountPart1 {
			break
		}
		previousOccupiedSeatCountPart1 = occupiedSeatCount
		seatMap = applyRulesPart1(seatMap)
	}

	seatMap = plan.ConvertToPlan(str.RemoveEmptyLines(input))
	previousOccupiedSeatCountPart2 := -1
	for {
		occupiedSeatCount := countOccupiedSeats(seatMap)
		if occupiedSeatCount == previousOccupiedSeatCountPart2 {
			break
		}
		previousOccupiedSeatCountPart2 = occupiedSeatCount

		seatMap = applyRulesPart2(seatMap)
	}

	return strconv.Itoa(previousOccupiedSeatCountPart1), strconv.Itoa(previousOccupiedSeatCountPart2)
}

func countOccupiedSeats(seatMap plan.Plan) int {
	strValue := seatMap.ConvertToString()
	matches := regex.FindAll(strValue, `(\#)`)
	return len(matches)
}

func applyRulesPart1(seatMap plan.Plan) plan.Plan {
	result := seatMap.Copy()

	for position, seat := range seatMap {
		adjacentOccupiedSeatCount := countAdjacentOccupiedSeats(position, seatMap)

		if seat == "L" && adjacentOccupiedSeatCount == 0 {
			result[position] = "#"
		}

		if seat == "#" && adjacentOccupiedSeatCount >= 4 {
			result[position] = "L"
		}
	}

	return result
}

func countAdjacentOccupiedSeats(position plan.Coordinates, seatMap plan.Plan) int {
	adjacentOccupiedSeatCount := 0

	for _, position := range seatMap.GetCoordinateNeighbors(position) {
		if seatMap[position] == "#" {
			adjacentOccupiedSeatCount++
		}
	}

	return adjacentOccupiedSeatCount
}

func applyRulesPart2(seatMap plan.Plan) plan.Plan {
	result := seatMap.Copy()

	for position, seat := range seatMap {
		directionalOccupiedSeatCount := countDirectionalOccupiedSeats(position, seatMap)

		if seat == "L" && directionalOccupiedSeatCount == 0 {
			result[position] = "#"
		}

		if seat == "#" && directionalOccupiedSeatCount >= 5 {
			result[position] = "L"
		}
	}

	return result
}

func countDirectionalOccupiedSeats(position plan.Coordinates, seatMap plan.Plan) int {
	directionalOccupiedSeatCount := 0

	for _, direction := range directions {
		seatPosition, err := getFirstNonEmptySeatInDirection(position, direction, seatMap)
		if err != nil {
			continue
		}

		if seatMap[seatPosition] == "#" {
			directionalOccupiedSeatCount++
		}
	}

	return directionalOccupiedSeatCount
}

func getFirstNonEmptySeatInDirection(currentPosition plan.Coordinates, direction plan.Direction, seatMap plan.Plan) (plan.Coordinates, error) {
	for {
		currentPosition = plan.GetNextPosition(currentPosition, direction)

		seat := seatMap[currentPosition]
		if seat == "" {
			break
		}

		if seat != "." {
			return currentPosition, nil
		}
	}

	return plan.Coordinates{}, errors.New("No non-empty seat found in direction")
}
