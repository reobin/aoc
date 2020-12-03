package plan

import "strings"

// Coordinates represents cartesian coordinates
type Coordinates struct {
	X int
	Y int
}

// PlanSize represents the 2d size of a plan
type PlanSize struct {
	Width  int
	Height int
}

// Slope represents the velocity in x and y of a slope
type Slope struct {
	X int
	Y int
}

// GetPlanSize returns the 2d size of a string plan
func GetPlanSize(plan string) PlanSize {
	lines := strings.Split(plan, "\n")
	return PlanSize{Width: len(lines[0]), Height: len(lines)}
}

// GetNextPosition returns the next position after computing 1 instance of the slope
// Note: If the right end has been reached, it starts back at the complete left
func GetNextPosition(position Coordinates, planSize PlanSize, slope Slope) Coordinates {
	nextX := position.X + slope.X
	if nextX > planSize.Width {
		nextX = nextX - planSize.Width
	}
	nextY := position.Y + slope.Y
	return Coordinates{X: nextX, Y: nextY}
}

// GetElementAt returns the character at a position in a plan
func GetElementAt(plan string, position Coordinates) string {
	lines := strings.Split(plan, "\n")
	line := lines[position.Y-1]
	return string(line[position.X-1])
}
