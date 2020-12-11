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

// Direction represents the velocity in x and y of a direction
type Direction struct {
	X int
	Y int
}

// GetPlanSize returns the 2d size of a plan
func GetPlanSize(plan Plan) Size {
	columnCount := len(plan)
	firstColumnRowCount := len(plan[0])
	return Size{Width: columnCount, Height: firstColumnRowCount}
}

// GetLoopedNextPosition returns the next position after computing 1 instance of the direction
// Note: If the right end has been reached, it starts back at the complete left
func GetLoopedNextPosition(position Coordinates, planSize Size, direction Direction) Coordinates {
	nextX := position.X + direction.X
	if nextX > planSize.Width {
		nextX = nextX - planSize.Width
	}
	nextY := position.Y + direction.Y
	if nextY > planSize.Height {
		nextY = planSize.Height
	}
	return Coordinates{X: nextX, Y: nextY}
}

// GetNextPosition returns the next position after computing 1 instance of the direction
// Note: Does not care about the size of the plan
func GetNextPosition(position Coordinates, direction Direction) Coordinates {
	nextX := position.X + direction.X
	nextY := position.Y + direction.Y
	return Coordinates{X: nextX, Y: nextY}
}

// GetElementAt returns the character at a position in a plan
func GetElementAt(plan Plan, position Coordinates) (string, error) {
	column := plan[position.X]

	if len(column) == 0 {
		return "", fmt.Errorf("Column %d does not exist", position.X)
	}

	character := column[position.Y]
	if character == "" {
		return "", fmt.Errorf("Row %d does not exist in column %d", position.X, position.Y)
	}

	return plan[position.X][position.Y], nil
}

// ConvertToPlan takes in a string representation of a plan and returns a 2d map
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

// CopyPlan returns a deep copy of the plan
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
