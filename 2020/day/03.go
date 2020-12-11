package day

import (
	"log"
	"strconv"

	planHelper "github.com/reobin/aoc/2020/pkg/plan"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay03 runs aoc day 3 challenge
func RunDay03(input string) (string, string) {
	plan := planHelper.ConvertToPlan(str.RemoveEmptyLines(input))
	planSize := planHelper.GetPlanSize(plan)

	treeHitsPart1 := countTreeHits(plan, planSize, planHelper.Direction{X: 3, Y: 1})

	treeHitsPart2 := 1
	slopes := []planHelper.Direction{{X: 1, Y: 1}, {X: 3, Y: 1}, {X: 5, Y: 1}, {X: 7, Y: 1}, {X: 1, Y: 2}}
	for _, slope := range slopes {
		treeHits := countTreeHits(plan, planSize, slope)
		treeHitsPart2 *= treeHits
	}

	return strconv.Itoa(treeHitsPart1), strconv.Itoa(treeHitsPart2)
}

func countTreeHits(plan planHelper.Plan, planSize planHelper.Size, slope planHelper.Direction) int {
	currentPosition := planHelper.Coordinates{X: 0, Y: 0}
	treeCount := 0
	for currentPosition.Y < planSize.Height {
		currentPosition = planHelper.GetLoopedNextPosition(currentPosition, planSize, slope)
		element, err := planHelper.GetElementAt(plan, currentPosition)
		if err != nil {
			log.Printf("Error getting element at %d: %s", currentPosition, err)
			continue
		}
		if element == "#" {
			treeCount++
		}
	}
	return treeCount
}
