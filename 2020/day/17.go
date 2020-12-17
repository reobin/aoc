package day

import (
	"strconv"

	"github.com/reobin/aoc/2020/pkg/point"
	"github.com/reobin/aoc/2020/pkg/str"
)

type gridRuleApplier func(grid point.Grid) point.Grid

// RunDay17 runs aoc day 17 challenge
func RunDay17(input string) (string, string) {
	grid := point.ConvertToGrid(str.RemoveEmptyLines(input))

	activeCubeCount3d := computeActiveCubeCount(grid, 3)
	activeCubeCount4d := computeActiveCubeCount(grid, 4)

	return strconv.Itoa(activeCubeCount3d), strconv.Itoa(activeCubeCount4d)
}

func computeActiveCubeCount(grid point.Grid, dimensionCount int) int {
	for cycle := 1; cycle <= 6; cycle++ {
		grid = applyGridRules(grid, dimensionCount)
	}

	return grid.CountMatches(`\#`)
}

func applyGridRules(grid point.Grid, dimensionCount int) point.Grid {
	result := make(point.Grid)

	gridCopy := grid.AddNeighbors(".", dimensionCount)

	for point, cube := range gridCopy {
		count := point.CountMatchingNeighbors(`\#`, gridCopy)

		switch cube {
		case "#":
			if count != 2 && count != 3 {
				result[point] = "."
				break
			}
			result[point] = "#"
			break
		case ".":
			if count == 3 {
				result[point] = "#"
				break
			}
			result[point] = "."
			break
		default:
			result[point] = cube
			break
		}
	}

	return result
}
