package plan

import (
	"fmt"
	"strings"
)

// Plan represents a 2 dimensional map
type Plan map[Coordinates]string

// Coordinates represents cartesian coordinates
type Coordinates struct {
	X int
	Y int
}

// Size represents the 2d size of a plan
type Size struct {
	Width  int
	Height int
}

// Direction represents the velocity in x and y of a direction
type Direction struct {
	X int
	Y int
}

// All directions around a position
var directions = [8]Direction{
	{X: -1, Y: -1}, {X: 0, Y: -1}, {X: 1, Y: -1},
	{X: -1, Y: 0}, {X: 1, Y: 0},
	{X: -1, Y: 1}, {X: 0, Y: 1}, {X: 1, Y: 1},
}

// GetSize returns the 2d size of a plan
func (plan Plan) GetSize() Size {
	maxX := -1
	maxY := -1

	for position := range plan {
		if position.X > maxX {
			maxX = position.X
		}

		if position.Y > maxY {
			maxY = position.Y
		}
	}

	return Size{Width: maxX + 1, Height: maxY + 1}
}

// ConvertToString takes in a string representation of a plan and returns a 2d map
func (plan Plan) ConvertToString() string {
	result := ""

	size := plan.GetSize()

	for x := 0; x < size.Width; x++ {
		for y := 0; y < size.Height; y++ {
			result += plan[Coordinates{X: x, Y: y}]
		}
		result += "\n"
	}

	return result
}

// Copy returns a deep copy of the plan
func (plan Plan) Copy() Plan {
	result := make(Plan)

	for position, character := range plan {
		result[position] = character
	}

	return result
}

// Print prints a plan nicely assuming it's squared
func (plan Plan) Print() {
	fmt.Println(plan.ConvertToString())
}

// GetLoopedNextPosition returns the next position after computing 1 instance of the direction
// Note: If the right end has been reached, it starts back at the complete left
func (plan Plan) GetLoopedNextPosition(position Coordinates, direction Direction) Coordinates {
	planSize := plan.GetSize()

	nextX := position.X + direction.X
	if nextX > planSize.Width-1 {
		nextX = nextX - planSize.Width
	}

	nextY := position.Y + direction.Y
	if nextY > planSize.Height-1 {
		nextY = planSize.Height - 1
	}

	return Coordinates{X: nextX, Y: nextY}
}

// GetNeighbors returns all valid positions around a position
func (plan Plan) GetNeighbors(position Coordinates) []Coordinates {
	var result []Coordinates
	for _, direction := range directions {
		nextPosition := GetNextPosition(position, direction)
		if plan[nextPosition] != "" {
			result = append(result, nextPosition)
		}
	}
	return result
}

// GetNextPosition returns the next position after computing 1 instance of the direction
// Note: Does not care about the size of the plan
func GetNextPosition(position Coordinates, direction Direction) Coordinates {
	return Coordinates{X: position.X + direction.X, Y: position.Y + direction.Y}
}

// ConvertToPlan takes in a string representation of a plan and returns a 2d map
func ConvertToPlan(value string) Plan {
	plan := make(Plan)

	lines := strings.Split(value, "\n")

	for y, line := range lines {
		for x, character := range line {
			plan[Coordinates{X: x, Y: y}] = string(character)
		}
	}

	return plan
}
