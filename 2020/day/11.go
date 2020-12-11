package day

import (
	"errors"
	"strconv"

	"github.com/reobin/aoc/2020/pkg/plan"
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
	occupiedSeatCount := 0
	for _, column := range seatMap {
		for _, seat := range column {
			if seat == "#" {
				occupiedSeatCount++
			}
		}
	}
	return occupiedSeatCount
}

func applyRulesPart1(seatMap plan.Plan) plan.Plan {
	result := plan.CopyPlan(seatMap)

	for x, column := range seatMap {
		for y, seat := range column {
			position := plan.Coordinates{X: x, Y: y}
			adjacentOccupiedSeatCount := countAdjacentOccupiedSeats(position, seatMap)

			if seat == "L" && adjacentOccupiedSeatCount == 0 {
				result[x][y] = "#"
			}

			if seat == "#" && adjacentOccupiedSeatCount >= 4 {
				result[x][y] = "L"
			}
		}
	}

	return result
}

func countAdjacentOccupiedSeats(position plan.Coordinates, seatMap plan.Plan) int {
	adjacentOccupiedSeatCount := 0

	adjacentPositions := []plan.Coordinates{
		{X: position.X - 1, Y: position.Y - 1},
		{X: position.X, Y: position.Y - 1},
		{X: position.X + 1, Y: position.Y - 1},
		{X: position.X - 1, Y: position.Y},
		{X: position.X + 1, Y: position.Y},
		{X: position.X - 1, Y: position.Y + 1},
		{X: position.X, Y: position.Y + 1},
		{X: position.X + 1, Y: position.Y + 1},
	}

	for _, position := range adjacentPositions {
		if seatMap[position.X][position.Y] == "#" {
			adjacentOccupiedSeatCount++
		}
	}

	return adjacentOccupiedSeatCount
}

func applyRulesPart2(seatMap plan.Plan) plan.Plan {
	result := plan.CopyPlan(seatMap)

	for x, column := range seatMap {
		for y, seat := range column {
			position := plan.Coordinates{X: x, Y: y}
			directionalOccupiedSeatCount := countDirectionalOccupiedSeats(position, seatMap)

			if seat == "L" && directionalOccupiedSeatCount == 0 {
				result[x][y] = "#"
			}

			if seat == "#" && directionalOccupiedSeatCount >= 5 {
				result[x][y] = "L"
			}
		}
	}

	return result
}

func countDirectionalOccupiedSeats(position plan.Coordinates, seatMap plan.Plan) int {
	directionalOccupiedSeatCount := 0

	directions := []plan.Direction{
		{X: -1, Y: -1},
		{X: 0, Y: -1},
		{X: +1, Y: -1},
		{X: -1, Y: 0},
		{X: +1, Y: 0},
		{X: -1, Y: +1},
		{X: 0, Y: +1},
		{X: +1, Y: +1},
	}

	for _, direction := range directions {
		seatPosition, err := getFirstNonEmptySeatInDirection(position, direction, seatMap)
		if err != nil {
			continue
		}

		if seatMap[seatPosition.X][seatPosition.Y] == "#" {
			directionalOccupiedSeatCount++
		}
	}

	return directionalOccupiedSeatCount
}

func getFirstNonEmptySeatInDirection(currentPosition plan.Coordinates, direction plan.Direction, seatMap plan.Plan) (plan.Coordinates, error) {
	for {
		currentPosition = plan.GetNextPosition(currentPosition, direction)
		seat, err := plan.GetElementAt(seatMap, currentPosition)

		if err != nil {
			break
		}

		if seat != "." {
			return currentPosition, nil
		}
	}

	return plan.Coordinates{}, errors.New("No non-empty seat found in direction")
}
