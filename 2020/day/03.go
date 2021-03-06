package day

import (
	"strconv"

	"github.com/reobin/aoc/2020/pkg/point"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay03 runs aoc day 3 challenge
func RunDay03(input string) (string, string) {
	treeMap := point.ConvertToGrid(str.RemoveEmptyLines(input))
	mapSize := treeMap.GetSize()

	treeHitsPart1 := countTreeHits(treeMap, mapSize, point.Point{X: 3, Y: 1})

	treeHitsPart2 := 1
	slopes := []point.Point{{X: 1, Y: 1}, {X: 3, Y: 1}, {X: 5, Y: 1}, {X: 7, Y: 1}, {X: 1, Y: 2}}
	for _, slope := range slopes {
		treeHits := countTreeHits(treeMap, mapSize, slope)
		treeHitsPart2 *= treeHits
	}

	return strconv.Itoa(treeHitsPart1), strconv.Itoa(treeHitsPart2)
}

func countTreeHits(treeMap point.Grid, mapSize point.Size, slope point.Point) int {
	currentPosition := point.Point{X: 0, Y: 0}
	treeCount := 0
	for currentPosition.Y < mapSize.Height-1 {
		currentPosition = currentPosition.MoveWithLoopX(slope, treeMap)
		element := treeMap[currentPosition]

		if element == "#" {
			treeCount++
		}
	}
	return treeCount
}
