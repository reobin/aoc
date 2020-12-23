package point

import (
	"fmt"
	"math"
	"regexp"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/regex"
)

// Grid represents a 3 dimensional map
type Grid map[Point]string

// Point represents a point in a 4d map
type Point struct {
	X int
	Y int
	Z int
}

// Size represents the 3d size of a grid
type Size struct {
	Width  int
	Height int
	Depth  int
}

// GetSize returns the 3d size of a grid
func (grid Grid) GetSize() Size {
	ranges := grid.getRanges()
	return Size{
		Width:  ranges.X.Maximum - ranges.X.Minimum + 1,
		Height: ranges.Y.Maximum - ranges.Y.Minimum + 1,
		Depth:  ranges.Z.Maximum - ranges.Z.Minimum + 1,
	}
}

// FlipX flips the entire grid at the x axis
func (grid Grid) FlipX() Grid {
	result := make(Grid)
	size := grid.GetSize()
	for x := 0; x < size.Width; x++ {
		for y := 0; y < (size.Height / 2); y++ {
			result[Point{X: x, Y: y}] = grid[Point{X: x, Y: size.Height - y - 1}]
			result[Point{X: x, Y: size.Height - y - 1}] = grid[Point{X: x, Y: y}]
		}
	}
	return result
}

// FlipY flips the entire grid at the y axis
func (grid Grid) FlipY() Grid {
	result := make(Grid)
	size := grid.GetSize()
	for y := 0; y < size.Height; y++ {
		for x := 0; x < (size.Width / 2); x++ {
			result[Point{X: x, Y: y}] = grid[Point{X: size.Width - x - 1, Y: y}]
			result[Point{X: size.Width - x - 1, Y: y}] = grid[Point{X: x, Y: y}]
		}
	}
	return result
}

// Rotate rotates the entire grid by increments of 90 degrees
func (grid Grid) Rotate(degrees int) Grid {
	size := grid.GetSize()
	result := grid.Copy()

	tmp := grid.Copy()

	for i := 0; i < degrees; i += 90 {
		for x := 0; x < size.Height; x++ {
			for y := 0; y < size.Width; y++ {
				if degrees >= 0 {
					result[Point{X: x, Y: y}] = tmp[Point{X: y, Y: size.Height - x - 1}]
				} else {
					result[Point{X: x, Y: y}] = tmp[Point{X: size.Width - y - 1, Y: x}]
				}
			}
		}
		tmp = result.Copy()
	}

	return result
}

// Copy returns a deep copy of the grid
func (grid Grid) Copy() Grid {
	result := make(Grid)

	for point, character := range grid {
		result[point] = character
	}

	return result
}

// IsEqualTo returns true if the grid is equal at all positions to a second grid
func (grid Grid) IsEqualTo(gridB Grid) bool {
	for point, valueA := range grid {
		valueB := gridB[point]
		if valueA != valueB {
			return false
		}
	}
	return true
}

// Print prints a grid nicely
func (grid Grid) Print() {
	fmt.Println(grid.ConvertToString())
}

// ConvertToGrid takes in a string representation of a grid and returns a 2d map
func ConvertToGrid(value string) Grid {
	grid := make(Grid)
	lines := strings.Split(value, "\n")
	for y, line := range lines {
		for x, character := range line {
			grid[Point{X: x, Y: y, Z: 0}] = string(character)
		}
	}
	return grid
}

// GetNeighbors returns all points around a point
func (point Point) GetNeighbors(dimensionCount int) []Point {
	var neighbors []Point
	for x := -1; x <= 1; x++ {
		for y := -1; y <= 1; y++ {
			if dimensionCount == 2 {
				neighbors = addNeighbor(neighbors, point, Point{X: point.X + x, Y: point.Y + y, Z: point.Z})
				continue
			}
			for z := -1; z <= 1; z++ {
				neighbors = addNeighbor(neighbors, point, Point{X: point.X + x, Y: point.Y + y, Z: point.Z + z})
			}
		}
	}
	return neighbors
}

func addNeighbor(neighbors []Point, point Point, neighbor Point) []Point {
	if point.IsEqualTo(neighbor) {
		return neighbors
	}
	return append(neighbors, neighbor)
}

// CountMatchingNeighbors counts the immediate neighbors that match a regex
func (point Point) CountMatchingNeighbors(expression string, grid Grid, dimensionCount int) int {
	count := 0
	for _, point := range point.GetNeighbors(dimensionCount) {
		if regex.Match(grid[point], expression) {
			count++
		}
	}
	return count
}

// CountMatches counts the occurences of an element in any of the points
func (grid Grid) CountMatches(expression string) int {
	count := 0
	for _, value := range grid {
		if regex.Match(value, expression) {
			count++
		}
	}
	return count
}

// ComputeManhattanDistance computes the manhattan distance of a point
func (point Point) ComputeManhattanDistance() int {
	return int(math.Abs(float64(point.X)) + math.Abs(float64(point.Y)))
}

// Move returns the next point after going in a direction once
func (point Point) Move(direction Point) Point {
	return Point{X: point.X + direction.X, Y: point.Y + direction.Y, Z: point.Z + direction.Z}
}

// MoveWithLoopX returns the next point after going in a direction once
// It loops back to 0 if the end of the grid has been reached
func (point Point) MoveWithLoopX(direction Point, grid Grid) Point {
	size := grid.GetSize()

	nextX := point.X + direction.X
	if nextX > size.Width-1 {
		nextX = nextX - size.Width
	}

	nextY := point.Y + direction.Y
	if nextY > size.Height-1 {
		nextY = size.Height - 1
	}

	return Point{X: nextX, Y: nextY}
}

// IsEqualTo returns true if the points are deeply equal
func (point Point) IsEqualTo(pointB Point) bool {
	return point.X == pointB.X && point.Y == pointB.Y && point.Z == pointB.Z
}

// Rotate returns a point after it has been rotated around the {0, 0} axis
// Only handles 90 degress based rotations
func (point Point) Rotate(degrees int) Point {
	isClockwise := degrees > 0

	loopCount := int(math.Abs(float64(degrees / 90)))

	for i := 0; i < loopCount; i++ {
		if isClockwise {
			point = Point{X: -point.Y, Y: point.X}
			continue
		}

		point = Point{X: point.Y, Y: -point.X}
	}

	return point
}

// ConvertToString takes in a grid and turns it into a visual string
func (grid Grid) ConvertToString() string {
	result := ""

	ranges := grid.getRanges()

	for z := ranges.Z.Minimum; z <= ranges.Z.Maximum; z++ {
		if z > ranges.Z.Minimum {
			result += "\n"
		}
		for y := ranges.Y.Minimum; y <= ranges.Y.Maximum; y++ {
			for x := ranges.X.Minimum; x <= ranges.X.Maximum; x++ {
				result += grid[Point{X: x, Y: y, Z: z}]
			}
			if y < ranges.Y.Maximum {
				result += "\n"
			}
		}
	}

	return result
}

// All 2d directions around a point
var directions2d = [8]Point{
	{X: -1, Y: -1}, {X: 0, Y: -1}, {X: 1, Y: -1},
	{X: -1, Y: 0}, {X: 1, Y: 0},
	{X: -1, Y: 1}, {X: 0, Y: 1}, {X: 1, Y: 1},
}

// CountMatchesInDirections counts the matches in any of the 8 directions
func (point Point) CountMatchesInDirections(expression string, ignoreExpression string, grid Grid) int {
	count := 0

	compiledExpression := regexp.MustCompile(expression)
	compiledIgnoreExpression := regexp.MustCompile(ignoreExpression)

	for _, direction := range directions2d {
		isElementInDirection := point.isMatchInDirection(direction, compiledExpression, compiledIgnoreExpression, grid)
		if isElementInDirection {
			count++
		}
	}

	return count
}

func (point Point) isMatchInDirection(direction Point, expression *regexp.Regexp, ignoreExpression *regexp.Regexp, grid Grid) bool {
	for {
		point = point.Move(direction)

		element := grid[point]
		if element == "" {
			return false
		}

		if expression.MatchString(element) {
			return true
		}

		if !ignoreExpression.MatchString(element) {
			return false
		}
	}
}

type ranges struct {
	X number.Range
	Y number.Range
	Z number.Range
}

func (grid Grid) getRanges() ranges {
	var x []int
	var y []int
	var z []int
	for point := range grid {
		x = append(x, point.X)
		y = append(y, point.Y)
		z = append(z, point.Z)
	}
	minX, maxX := number.MinMax(x)
	minY, maxY := number.MinMax(y)
	minZ, maxZ := number.MinMax(z)
	return ranges{
		X: number.Range{Minimum: minX, Maximum: maxX},
		Y: number.Range{Minimum: minY, Maximum: maxY},
		Z: number.Range{Minimum: minZ, Maximum: maxZ},
	}
}

// GetAllOrientations returns a list of all possible orientiations of a grid
func (grid Grid) GetAllOrientations() []Grid {
	var grids []Grid
	for degrees := 0; degrees <= 270; degrees += 90 {
		rotated := grid.Rotate(degrees)
		grids = append(grids, rotated)
		grids = append(grids, rotated.FlipX())
		grids = append(grids, rotated.FlipY())
		grids = append(grids, rotated.FlipX().FlipY())
	}
	return grids
}

// GetSides returns a list of all sides
func (grid Grid) GetSides() []string {
	return []string{grid.GetTop(), grid.GetRight(), grid.GetBottom(), grid.GetLeft()}
}

// GetBottom returns bottom side as a string
func (grid Grid) GetBottom() string {
	size := grid.GetSize()
	var downSide string
	for x := 0; x < size.Width; x++ {
		downSide += grid[Point{X: x, Y: size.Height - 1}]
	}
	return downSide
}

// GetTop returns top side as a string
func (grid Grid) GetTop() string {
	size := grid.GetSize()
	var upSide string
	for x := 0; x < size.Width; x++ {
		upSide += grid[Point{X: x, Y: 0}]
	}
	return upSide
}

// GetRight returns right side as a string
func (grid Grid) GetRight() string {
	size := grid.GetSize()
	var rightSide string
	for y := 0; y < size.Height; y++ {
		rightSide += grid[Point{X: size.Width - 1, Y: y}]
	}
	return rightSide
}

// GetLeft returns left side as a string
func (grid Grid) GetLeft() string {
	size := grid.GetSize()
	var leftSide string
	for y := 0; y < size.Height; y++ {
		leftSide += grid[Point{X: 0, Y: y}]
	}
	return leftSide
}
