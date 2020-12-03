package day

import (
	"strconv"

	planHelper "github.com/reobin/aoc/2020/pkg/plan"
)

// RunDay03 runs aoc day 3 challenge
func RunDay03(plan string) (string, string) {
	planSize := planHelper.GetPlanSize(plan)

	treeHitsPart1 := countTreeHits(plan, planSize, planHelper.Slope{X: 3, Y: 1})

	treeHitsPart2 := 1
	slopes := []planHelper.Slope{{X: 1, Y: 1}, {X: 3, Y: 1}, {X: 5, Y: 1}, {X: 7, Y: 1}, {X: 1, Y: 2}}
	for _, slope := range slopes {
		treeHits := countTreeHits(plan, planSize, slope)
		treeHitsPart2 *= treeHits
	}

	return strconv.Itoa(treeHitsPart1), strconv.Itoa(treeHitsPart2)
}

func countTreeHits(plan string, planSize planHelper.PlanSize, slope planHelper.Slope) int {
	currentPosition := planHelper.Coordinates{X: 1, Y: 1}
	treeCount := 0
	for currentPosition.Y < planSize.Height {
		currentPosition = planHelper.GetNextPosition(currentPosition, planSize, slope)
		element := planHelper.GetElementAt(plan, currentPosition)
		if element == "#" {
			treeCount++
		}
	}
	return treeCount
}
