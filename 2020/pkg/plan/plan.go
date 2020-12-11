package plan

import (
	"fmt"
	"strings"
)

// Plan represents a 2 dimensional map
type Plan map[int]map[int]string

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

// Slope represents the velocity in x and y of a slope
type Slope struct {
	X int
	Y int
}

// GetPlanSize returns the 2d size of a string plan
// Note: assumes the plan has the same width from top to bottom
func GetPlanSize(plan string) Size {
	lines := strings.Split(plan, "\n")
	return Size{Width: len(lines[0]), Height: len(lines)}
}

// GetNextPosition returns the next position after computing 1 instance of the slope
// Note: If the right end has been reached, it starts back at the complete left
func GetNextPosition(position Coordinates, planSize Size, slope Slope) Coordinates {
	nextX := position.X + slope.X
	if nextX > planSize.Width {
		nextX = nextX - planSize.Width
	}
	nextY := position.Y + slope.Y
	if nextY > planSize.Height {
		nextY = planSize.Height
	}
	return Coordinates{X: nextX, Y: nextY}
}

// GetElementAt returns the character at a position in a plan
func GetElementAt(plan string, position Coordinates) (string, error) {
	lines := strings.Split(plan, "\n")

	if len(lines) < position.Y {
		return "", fmt.Errorf("Plan is not high enough to get position: %d", position)
	}

	line := lines[position.Y-1]

	if len(line) < position.X {
		return "", fmt.Errorf("Plan is not wide enough to get position: %d", position)
	}

	return string(line[position.X-1]), nil
}

// ConvertToPlan takes in a string representation of a plan and returns a map
func ConvertToPlan(value string) Plan {
	plan := make(Plan)

	lines := strings.Split(value, "\n")

	for y, line := range lines {
		for x, character := range line {
			if plan[x] == nil {
				plan[x] = make(map[int]string)
			}
			plan[x][y] = string(character)
		}
	}

	return plan
}

// CopyPlan returns a copy of the plan
func CopyPlan(plan Plan) Plan {
	result := make(Plan)

	for x, column := range plan {
		result[x] = make(map[int]string)
		for y, character := range column {
			result[x][y] = character
		}
	}

	return result
}

// PrintPlan prints a plan nicely assuming it's squared
func PrintPlan(plan Plan) {
	columnCount := len(plan)

	for i := 0; i < columnCount; i++ {
		for j := 0; j < columnCount; j++ {
			fmt.Print(plan[j][i])
		}
		fmt.Println()
	}
}
