package day

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/point"
	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type tileMap map[string]point.Grid

// RunDay20 runs aoc day 20 challenge
func RunDay20(input string) (string, string) {
	tiles := getTiles(input)
	cornerIDs := findCornerIDs(tiles)
	grid, tiles := initializeTileGrid(cornerIDs, tiles)
	grid, tiles = completeTileGrid(grid, tiles)
	monsterCount, finalGrid := countMonsters(grid, tiles)
	finalGrid.Print()
	totalSquareCount := finalGrid.CountMatches(`\#`)

	fmt.Println(monsterCount)

	return strconv.Itoa(totalSquareCount - monsterCount*15), ""
}

func completeTileGrid(grid point.Grid, tiles tileMap) (point.Grid, tileMap) {
	excludeIDs := []string{grid[point.Point{}], grid[point.Point{X: 1}], grid[point.Point{Y: 1}]}
	for y := 0; y < 12; y++ {
		p := point.Point{X: 0, Y: y}
		if grid[p] == "" {
			upP := point.Point{X: 0, Y: y - 1}
			neighborDownID, neighborDownGrid := findNeighborDown(grid[upP], tiles[grid[upP]], excludeIDs, tiles)
			if neighborDownID == "" {
				return grid, tiles
			}

			excludeIDs = append(excludeIDs, neighborDownID)
			grid[p] = neighborDownID
			tiles[neighborDownID] = neighborDownGrid
		}

		for x := 0; x < 12; x++ {
			if x == 0 {
				continue
			}

			p := point.Point{X: x, Y: y}
			if grid[p] != "" {
				continue
			}

			leftP := point.Point{X: x - 1, Y: y}
			neighborRightID, neighborRightGrid := findNeighborRight(grid[leftP], tiles[grid[leftP]], excludeIDs, tiles)
			if neighborRightID == "" {
				return grid, tiles
			}

			excludeIDs = append(excludeIDs, neighborRightID)
			grid[p] = neighborRightID
			tiles[neighborRightID] = neighborRightGrid
		}
	}
	return grid, tiles
}

func countMonsters(grid point.Grid, tiles tileMap) (int, point.Grid) {
	var result string
	for y := 0; y < 12; y++ {
		for innerY := 1; innerY < 9; innerY++ {
			for x := 0; x < 12; x++ {
				id := grid[point.Point{X: x, Y: y}]
				tile := tiles[id]
				line := getLine(tile, innerY)
				result += line
			}
			result += "\n"
		}
	}

	grid = point.ConvertToGrid(result)
	for _, orientation := range grid.GetAllOrientations() {
		matches := regex.FindAll(orientation.ConvertToString(), `\#....\#\#....\#\#....\#\#\#`)
		if len(matches) > 0 {
			return len(matches), orientation
		}
	}

	return 0, point.Grid{}
}

func getLine(grid point.Grid, y int) string {
	var line string
	for x := 1; x < grid.GetSize().Width-1; x++ {
		line += grid[point.Point{X: x, Y: y}]
	}
	return line
}

func initializeTileGrid(cornerIDs []string, tiles tileMap) (point.Grid, tileMap) {
	grid := make(point.Grid)

	topLeftCornerID := cornerIDs[0]
	grid[point.Point{X: 0, Y: 0}] = topLeftCornerID

	excludeIDs := []string{topLeftCornerID}

	for _, orientation := range tiles[topLeftCornerID].GetAllOrientations() {
		neighborDownID, neighborDownGrid := findNeighborDown(topLeftCornerID, orientation, excludeIDs, tiles)
		if neighborDownID == "" {
			continue
		}

		neighborRightID, neighborRightGrid := findNeighborRight(topLeftCornerID, orientation, excludeIDs, tiles)
		if neighborRightID == "" {
			continue
		}

		tiles[topLeftCornerID] = orientation
		grid[point.Point{X: 0, Y: 1}] = neighborDownID
		tiles[neighborDownID] = neighborDownGrid
		grid[point.Point{X: 1, Y: 0}] = neighborRightID
		tiles[neighborRightID] = neighborRightGrid
		excludeIDs = append(excludeIDs, []string{neighborDownID, neighborRightID}...)
		break
	}

	return grid, tiles
}

func findNeighborDown(tileID string, tileGrid point.Grid, excludeIDs []string, tiles tileMap) (string, point.Grid) {
	bottom := tileGrid.GetBottom()

	for neighborID, neighborGrid := range tiles {
		if tileID == neighborID || str.Contains(excludeIDs, neighborID) {
			continue
		}

		for _, neighborGrid := range neighborGrid.GetAllOrientations() {
			top := neighborGrid.GetTop()
			if top == bottom {
				return neighborID, neighborGrid
			}
		}
	}

	return "", point.Grid{}
}

func findNeighborRight(tileID string, tile point.Grid, excludeIDs []string, tiles tileMap) (string, point.Grid) {
	right := tile.GetRight()

	for neighborID, neighborGrid := range tiles {
		if tileID == neighborID || str.Contains(excludeIDs, neighborID) {
			continue
		}

		for _, neighborGrid := range neighborGrid.GetAllOrientations() {
			left := neighborGrid.GetLeft()
			if left == right {
				return neighborID, neighborGrid
			}
		}
	}

	return "", point.Grid{}
}

func findCornerIDs(tiles tileMap) []string {
	var cornerIDs []string

	for id, grid := range tiles {
		var neighbors []string
		sides := grid.GetSides()
		for idB, gridB := range tiles {
			if id == idB {
				continue
			}

			var commonSides int

			var sidesB []string
			for _, side := range gridB.GetSides() {
				sidesB = append(sidesB, side)
				sidesB = append(sidesB, str.Reverse(side))
			}
			commonSides += str.CountCommon(sides, sidesB)

			if commonSides > 0 {
				neighbors = append(neighbors, idB)
			}
		}

		if len(neighbors) == 2 {
			cornerIDs = append(cornerIDs, id)
		}
	}

	return cornerIDs
}

func getTiles(input string) tileMap {
	tileDefinitions := strings.Split(input, "\n\n")

	tiles := make(tileMap)

	for _, definition := range tileDefinitions {
		lines := strings.Split(str.RemoveEmptyLines(definition), "\n")
		if len(lines) < 2 {
			continue
		}

		match := regex.Find(lines[0], `\d+`)
		if len(match) < 1 {
			continue
		}

		content := strings.Join(lines[1:], "\n")
		grid := point.ConvertToGrid(content)

		tiles[match[0]] = grid
	}

	return tiles
}
