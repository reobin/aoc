package plan

import (
	"fmt"
	"math"
	"regexp"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
)

// Plan represents a 2 dimensional map
type Plan map[Point]string

// Point represents a point in a 2d map
type Point struct {
	X int
	Y int
}

// Size represents the 2d size of a plan
type Size struct {
	Width  int
	Height int
}

// All directions around a point
var directions = [8]Point{
	{X: -1, Y: -1}, {X: 0, Y: -1}, {X: 1, Y: -1},
	{X: -1, Y: 0}, {X: 1, Y: 0},
	{X: -1, Y: 1}, {X: 0, Y: 1}, {X: 1, Y: 1},
}

// GetSize returns the 2d size of a plan
func (plan Plan) GetSize() Size {
	maxX := -1
	maxY := -1

	for point := range plan {
		if point.X > maxX {
			maxX = point.X
		}

		if point.Y > maxY {
			maxY = point.Y
		}
	}

	return Size{Width: maxX + 1, Height: maxY + 1}
}

// ConvertToString takes in a string representation of a plan and returns a 2d map
func (plan Plan) ConvertToString() string {
	result := ""

	size := plan.GetSize()

	for y := 0; y < size.Height; y++ {
		for x := 0; x < size.Width; x++ {
			result += plan[Point{X: x, Y: y}]
		}
		if y < size.Height-1 {
			result += "\n"
		}
	}

	return result
}

// Copy returns a deep copy of the plan
func (plan Plan) Copy() Plan {
	result := make(Plan)

	for point, character := range plan {
		result[point] = character
	}

	return result
}

// IsEqualTo returns true if the plan is equal at all positions to a second plan
func (plan Plan) IsEqualTo(planB Plan) bool {
	for point, valueA := range plan {
		valueB := planB[point]
		if valueA != valueB {
			return false
		}
	}
	return true
}

// Print prints a plan nicely assuming it's squared
func (plan Plan) Print() {
	fmt.Println(plan.ConvertToString())
}

// ConvertToPlan takes in a string representation of a plan and returns a 2d map
func ConvertToPlan(value string) Plan {
	plan := make(Plan)
	lines := strings.Split(value, "\n")
	for y, line := range lines {
		for x, character := range line {
			plan[Point{X: x, Y: y}] = string(character)
		}
	}
	return plan
}

// GetNeighbors returns all valid points around a point
func (point Point) GetNeighbors(plan Plan) []Point {
	var neighbors []Point
	for _, direction := range directions {
		nextPoint := point.Move(direction)
		if plan[nextPoint] != "" {
			neighbors = append(neighbors, nextPoint)
		}
	}
	return neighbors
}

// CountMatchingNeighbors counts the immediate neighbors that match a regex
func (point Point) CountMatchingNeighbors(expression string, plan Plan) int {
	count := 0
	for _, point := range point.GetNeighbors(plan) {
		if regex.Match(plan[point], expression) {
			count++
		}
	}
	return count
}

// CountMatches counts the occurences of an element in any of the points
func (plan Plan) CountMatches(expression string) int {
	strValue := plan.ConvertToString()
	matches := regex.FindAll(strValue, expression)
	return len(matches)
}

// ComputeManhattanDistance computes the manhattan distance of a point
func (point Point) ComputeManhattanDistance() int {
	return int(math.Abs(float64(point.X)) + math.Abs(float64(point.Y)))
}

// Move returns the next point after going in a direction once
func (point Point) Move(direction Point) Point {
	return Point{X: point.X + direction.X, Y: point.Y + direction.Y}
}

// MoveWithLoopX returns the next point after going in a direction once
// It loops back to 0 if the end of the plan has been reached
func (point Point) MoveWithLoopX(direction Point, plan Plan) Point {
	planSize := plan.GetSize()

	nextX := point.X + direction.X
	if nextX > planSize.Width-1 {
		nextX = nextX - planSize.Width
	}

	nextY := point.Y + direction.Y
	if nextY > planSize.Height-1 {
		nextY = planSize.Height - 1
	}

	return Point{X: nextX, Y: nextY}
}

// IsEqualTo returns true if the points are deeply equal
func (point Point) IsEqualTo(pointB Point) bool {
	return point.X == pointB.X && point.Y == pointB.Y
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

// CountMatchesInDirections counts the matches in any of the 8 directions
func (point Point) CountMatchesInDirections(expression string, ignoreExpression string, plan Plan) int {
	count := 0

	compiledExpression := regexp.MustCompile(expression)
	compiledIgnoreExpression := regexp.MustCompile(ignoreExpression)

	for _, direction := range directions {
		isElementInDirection := point.isMatchInDirection(direction, compiledExpression, compiledIgnoreExpression, plan)
		if isElementInDirection {
			count++
		}
	}

	return count
}

func (point Point) isMatchInDirection(direction Point, expression *regexp.Regexp, ignoreExpression *regexp.Regexp, plan Plan) bool {

	for {
		point = point.Move(direction)

		element := plan[point]
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
