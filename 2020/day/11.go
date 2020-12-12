package day

import (
	"strconv"

	"github.com/reobin/aoc/2020/pkg/plan"
	"github.com/reobin/aoc/2020/pkg/str"
)

type ruleApplier func(seatMap plan.Plan) plan.Plan

// RunDay11 runs aoc day 11 challenge
func RunDay11(input string) (string, string) {
	seatMap := plan.ConvertToPlan(str.RemoveEmptyLines(input))

	occupiedSeatCountPart1 := getStabilizeOccupiedSeats(seatMap, applyRulesPart1)
	occupiedSeatCountPart2 := getStabilizeOccupiedSeats(seatMap, applyRulesPart2)

	return strconv.Itoa(occupiedSeatCountPart1), strconv.Itoa(occupiedSeatCountPart2)
}

func getStabilizeOccupiedSeats(seatMap plan.Plan, applyRules ruleApplier) int {
	previousOccupiedSeatCount := -1
	for {
		occupiedSeatCount := seatMap.CountMatches(`(\#)`)
		if occupiedSeatCount == previousOccupiedSeatCount {
			break
		}
		previousOccupiedSeatCount = occupiedSeatCount

		seatMap = applyRules(seatMap)
	}
	return previousOccupiedSeatCount
}

func applyRulesPart1(seatMap plan.Plan) plan.Plan {
	result := make(plan.Plan)

	for point, seat := range seatMap {
		count := point.CountMatchingNeighbors(`\#`, seatMap)

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

func applyRulesPart2(seatMap plan.Plan) plan.Plan {
	result := make(plan.Plan)

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