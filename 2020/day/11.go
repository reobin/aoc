package day

import (
	"strconv"

	"github.com/reobin/aoc/2020/pkg/point"
	"github.com/reobin/aoc/2020/pkg/str"
)

type ruleApplier func(seatMap point.Grid) point.Grid

// RunDay11 runs aoc day 11 challenge
func RunDay11(input string) (string, string) {
	seatMap := point.ConvertToGrid(str.RemoveEmptyLines(input))

	occupiedSeatCountPart1 := getStabilizeOccupiedSeats(seatMap, applyRulesPart1)
	occupiedSeatCountPart2 := getStabilizeOccupiedSeats(seatMap, applyRulesPart2)

	return strconv.Itoa(occupiedSeatCountPart1), strconv.Itoa(occupiedSeatCountPart2)
}

func getStabilizeOccupiedSeats(seatMap point.Grid, applyRules ruleApplier) int {
	previousOccupiedSeatCount := -1
	for {
		occupiedSeatCount := seatMap.CountMatches(`\#`)
		if occupiedSeatCount == previousOccupiedSeatCount {
			break
		}
		previousOccupiedSeatCount = occupiedSeatCount

		seatMap = applyRules(seatMap)
	}
	return previousOccupiedSeatCount
}

func applyRulesPart1(seatMap point.Grid) point.Grid {
	result := make(point.Grid)

	for point, seat := range seatMap {
		count := point.CountMatchingNeighbors(`\#`, seatMap, 2)

		if seat == "L" && count == 0 {
			result[point] = "#"
			continue
		}

		if seat == "#" && count >= 4 {
			result[point] = "L"
			continue
		}

		result[point] = seat
	}

	return result
}

func applyRulesPart2(seatMap point.Grid) point.Grid {
	result := make(point.Grid)

	for point, seat := range seatMap {
		count := point.CountMatchesInDirections(`\#`, `\.`, seatMap)

		if seat == "L" && count == 0 {
			result[point] = "#"
			continue
		}

		if seat == "#" && count >= 5 {
			result[point] = "L"
			continue
		}

		result[point] = seat
	}

	return result
}
