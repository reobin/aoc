package point

import (
	"fmt"
	"math"
	"regexp"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/regex"
)

// Grid represents a 2 dimensional map
type Grid map[Point]string

// Point represents a point in a 2d map
type Point struct {
	X int
	Y int
	Z int
	W int
}

// Size represents the 2d size of a plan
type Size struct {
	Width  int
	Height int
	Depth  int
}

type Ranges struct {
	X number.Range
	Y number.Range
	Z number.Range
	W number.Range
}

func (grid Grid) GetRanges() Ranges {
	var x []int
	var y []int
	var z []int
	var w []int
	for point := range grid {
		x = append(x, point.X)
		y = append(y, point.Y)
		z = append(z, point.Z)
		w = append(w, point.W)
	}
	minX, maxX := number.MinMax(x)
	minY, maxY := number.MinMax(y)
	minZ, maxZ := number.MinMax(z)
	minW, maxW := number.MinMax(w)
	return Ranges{
		X: number.Range{Minimum: minX, Maximum: maxX},
		Y: number.Range{Minimum: minY, Maximum: maxY},
		Z: number.Range{Minimum: minZ, Maximum: maxZ},
		W: number.Range{Minimum: minW, Maximum: maxW},
	}
}

func (grid Grid) GetSize() Size {
	ranges := grid.GetRanges()
	return Size{
		Width:  ranges.X.Maximum - ranges.X.Minimum + 1,
		Height: ranges.Y.Maximum - ranges.Y.Minimum + 1,
		Depth:  ranges.Z.Maximum - ranges.Z.Minimum + 1,
	}
}

// ConvertToString takes in a grid and turns it into a visual string
func (grid Grid) ConvertToString() string {
	result := ""

	ranges := grid.GetRanges()

	for w := ranges.W.Minimum; w <= ranges.W.Maximum; w++ {
		if w != ranges.W.Minimum {
			result += "\n"
		}
		result += fmt.Sprintf("w: %d", w)
		for z := ranges.Z.Minimum; z <= ranges.Z.Maximum; z++ {
			result += fmt.Sprintf("\nz: %d\n", z)
			for y := ranges.Y.Minimum; y <= ranges.Y.Maximum; y++ {
				for x := ranges.X.Minimum; x <= ranges.X.Maximum; x++ {
					result += grid[Point{X: x, Y: y, Z: z, W: w}]
				}
				if y < ranges.Y.Maximum {
					result += "\n"
				}
			}
			if w < ranges.W.Maximum {
				result += "\n"
			}
		}
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
			grid[Point{X: x, Y: y, Z: 0, W: 0}] = string(character)
		}
	}
	return grid
}

// GetNeighbors returns all points around a point
func (point Point) GetNeighbors() []Point {
	var neighbors []Point
	for x := -1; x <= 1; x++ {
		for y := -1; y <= 1; y++ {
			for z := -1; z <= 1; z++ {
				for w := -1; w <= 1; w++ {
					neighbor := Point{X: point.X + x, Y: point.Y + y, Z: point.Z + z, W: point.W + w}
					if point.IsEqualTo(neighbor) {
						continue
					}
					neighbors = append(neighbors, neighbor)
				}
			}
		}
	}
	return neighbors
}

// CountMatchingNeighbors counts the immediate neighbors that match a regex
func (point Point) CountMatchingNeighbors(expression string, grid Grid) int {
	count := 0
	for _, point := range point.GetNeighbors() {
		if regex.Match(grid[point], expression) {
			count++
		}
	}
	return count
}

func (grid Grid) AddNeighbors(value string, dimensionCount int) Grid {
	result := make(Grid)
	for point, cube := range grid {
		result[point] = cube
		for _, neighbor := range point.GetNeighbors() {
			if dimensionCount < 4 && point.W != neighbor.W {
				continue
			}

			if grid[neighbor] == "" {
				result[neighbor] = value
			}
		}
	}
	return result
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
	return Point{X: point.X + direction.X, Y: point.Y + direction.Y, Z: point.Z + direction.Z, W: point.W + direction.W}
}

// MoveWithLoopX returns the next point after going in a direction once
// It loops back to 0 if the end of the plan has been reached
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
	return point.X == pointB.X && point.Y == pointB.Y && point.Z == pointB.Z && point.W == pointB.W
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
