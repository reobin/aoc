package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/point"
	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay24 runs aoc day 24 challenge
func RunDay24(input string) (string, string) {
	grid := make(point.Grid)
	grid[point.Point{}] = "W"

	for _, line := range strings.Split(str.RemoveEmptyLines(input), "\n") {
		instructions := getInstructions(line)
		tileToFlip := followInstructions(instructions)
		grid[tileToFlip] = flipTilePart1(grid, tileToFlip)
	}
	resultPart1 := strconv.Itoa(grid.CountMatches(`B`))

	grid = applyTileRules(grid)
	resultPart2 := strconv.Itoa(grid.CountMatches(`B`))

	return resultPart1, resultPart2
}

func applyTileRules(grid point.Grid) point.Grid {
	for i := 0; i < 100; i++ {
		result := grid.Copy()
		for tile := range grid {
			result[tile] = flipTilePart2(grid, tile)
			for _, neighbor := range getHexNeighbors(grid, tile) {
				if result[neighbor] == "" {
					result[neighbor] = flipTilePart2(grid, neighbor)
				}
			}
		}
		grid = result
	}
	return grid
}

func flipTilePart1(grid point.Grid, tile point.Point) string {
	switch grid[tile] {
	case "W":
		return "B"
	case "B":
		return "W"
	default:
		// untouched tiles are considered white
		return "B"
	}
}

func flipTilePart2(grid point.Grid, tile point.Point) string {
	neighbors := getHexNeighbors(grid, tile)

	var neighborValues []string
	for _, neighbor := range neighbors {
		neighborValues = append(neighborValues, grid[neighbor])
	}

	matchingNeighborsCount := str.CountMatches(neighborValues, `B`)

	if grid[tile] == "B" {
		if matchingNeighborsCount == 0 || matchingNeighborsCount > 2 {
			return "W"
		}
		return "B"
	}

	if matchingNeighborsCount == 2 {
		return "B"
	}
	return "W"
}

func followInstructions(instructions []string) point.Point {
	current := point.Point{}
	for _, instruction := range instructions {
		current = getAdjacentTile(current, instruction)
	}
	return current
}

func getInstructions(line string) []string {
	var instructions []string
	for _, match := range regex.FindAll(line, `se|ne|sw|nw|e|w`) {
		instructions = append(instructions, match[0])
	}
	return instructions
}

func getHexNeighbors(grid point.Grid, tile point.Point) []point.Point {
	return []point.Point{
		getAdjacentTile(tile, "se"),
		getAdjacentTile(tile, "ne"),
		getAdjacentTile(tile, "sw"),
		getAdjacentTile(tile, "nw"),
		getAdjacentTile(tile, "e"),
		getAdjacentTile(tile, "w"),
	}
}

func getAdjacentTile(tile point.Point, direction string) point.Point {
	rIsEven := tile.Y%2 == 0
	switch direction {
	case "se":
		if rIsEven {
			return tile.Move(point.Point{X: 1, Y: 1})
		}
		return tile.Move(point.Point{Y: 1})
	case "ne":
		if rIsEven {
			return tile.Move(point.Point{X: 1, Y: -1})
		}
		return tile.Move(point.Point{Y: -1})
	case "sw":
		if rIsEven {
			return tile.Move(point.Point{Y: 1})
		}
		return tile.Move(point.Point{X: -1, Y: 1})
	case "nw":
		if rIsEven {
			return tile.Move(point.Point{Y: -1})
		}
		return tile.Move(point.Point{X: -1, Y: -1})
	case "e":
		return tile.Move(point.Point{X: 1})
	case "w":
		return tile.Move(point.Point{X: -1})
	default:
		return tile
	}
}
