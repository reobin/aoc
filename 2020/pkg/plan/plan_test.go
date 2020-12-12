package plan

import (
	"fmt"
	"reflect"
	"regexp"
	"testing"
)

func TestGetSize(t *testing.T) {
	t.Run("should return size of a valid plan", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		size := plan.GetSize()
		expectedSize := Size{Width: 4, Height: 3}
		if size.Width != expectedSize.Width || size.Height != expectedSize.Height {
			t.Errorf("Incorrect result for GetSize, got: %d, want: %d", size, expectedSize)
		}
	})

	t.Run("should return size of an empty plan", func(t *testing.T) {
		plan := Plan{}
		size := plan.GetSize()
		expectedSize := Size{Width: 0, Height: 0}
		if !reflect.DeepEqual(size, expectedSize) {
			t.Errorf("Incorrect result for GetSize, got: %d, want: %d", size, expectedSize)
		}
	})
}

func TestConvertToString(t *testing.T) {
	t.Run("should convert a valid plan to a string value", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		expectedStringValue := `1234
1234
1234`
		stringValue := plan.ConvertToString()

		if stringValue != expectedStringValue {
			t.Errorf("Incorrect result for ConvertToString, got: %s, want: %s", stringValue, expectedStringValue)
		}
	})
}

func TestIsPlanEqualTo(t *testing.T) {
	t.Run("should return true for equal plans", func(t *testing.T) {
		planA := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		planB := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		if !planA.IsEqualTo(planB) {
			t.Errorf("Incorrect result for IsEqualTo, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return false for unequal plans", func(t *testing.T) {
		planA := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		planB := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
		}

		if planA.IsEqualTo(planB) {
			t.Errorf("Incorrect result for IsEqualTo, got: %v, want: %v", true, false)
		}
	})
}

func TestCopy(t *testing.T) {
	t.Run("should return an equal copy of plan", func(t *testing.T) {
		planA := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		planB := planA.Copy()

		if !planA.IsEqualTo(planB) {
			t.Errorf("Incorrect result for Copy, got: %v, want: %v", false, true)
		}
	})
}

func TestCountMatches(t *testing.T) {
	t.Run("should return match count", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		matchCount := plan.CountMatches(`(L)`)

		if matchCount != 8 {
			t.Errorf("Incorrect result for CountMatches, got: %d, want: %d", matchCount, 8)
		}
	})
}

func TestConvertToPlan(t *testing.T) {
	t.Run("should convert string to an equivalent plan", func(t *testing.T) {
		value := `1234
1234
1234`

		plan := ConvertToPlan(value)

		expectedPlan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		if !plan.IsEqualTo(expectedPlan) {
			t.Error("Incorrect result for ConvertToPlan")
			fmt.Println("got: ")
			plan.Print()
			fmt.Println("got: ")
			expectedPlan.Print()
		}
	})
}

func TestGetNeighbors(t *testing.T) {
	t.Run("should get all 8 neighbors if point is in middle", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		point := Point{X: 2, Y: 1}

		neighbors := point.GetNeighbors(plan)
		expectedNeigbors := []Point{
			{X: 1, Y: 0},
			{X: 2, Y: 0},
			{X: 3, Y: 0},
			{X: 1, Y: 1},
			{X: 3, Y: 1},
			{X: 1, Y: 2},
			{X: 2, Y: 2},
			{X: 3, Y: 2},
		}

		if !reflect.DeepEqual(neighbors, expectedNeigbors) {
			t.Errorf("Incorrect result for GetNeighbors, got: %d, want: %d", neighbors, expectedNeigbors)
		}
	})

	t.Run("should get immediate neighbors if point is on edge", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		point := Point{X: 3, Y: 0}

		neighbors := point.GetNeighbors(plan)
		expectedNeigbors := []Point{
			{X: 2, Y: 0},
			{X: 2, Y: 1},
			{X: 3, Y: 1},
		}

		if !reflect.DeepEqual(neighbors, expectedNeigbors) {
			t.Errorf("Incorrect result for GetNeighbors, got: %d, want: %d", neighbors, expectedNeigbors)
		}
	})
}

func TestCountMatchingNeighbors(t *testing.T) {
	t.Run("should return matching neighbor count", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		point := Point{X: 1, Y: 1}
		count := point.CountMatchingNeighbors("1", plan)
		expectedCount := 3
		if count != expectedCount {
			t.Errorf("Incorrect result for CountMatchingNeighbors, got: %d, want: %d", count, expectedCount)
		}
	})
}

func TestComputeManhattanDistance(t *testing.T) {
	t.Run("should return manhattan distance of point", func(t *testing.T) {
		point := Point{X: 17, Y: 8}
		distance := point.ComputeManhattanDistance()
		expectedDistance := 25
		if distance != expectedDistance {
			t.Errorf("Incorrect result for ComputeManhattanDistance, got: %d, want: %d", distance, expectedDistance)
		}
	})
}

func TestMove(t *testing.T) {
	t.Run("should return next point after moving", func(t *testing.T) {
		point := Point{X: 0, Y: 10}

		point = point.Move(Point{X: 10, Y: -5})

		expectedPoint := Point{X: 10, Y: 5}

		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Move, got: %d, want: %d", point, expectedPoint)
		}
	})
}

func TestMoveWithLoopX(t *testing.T) {
	t.Run("should return next point after looping", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		point := Point{X: 2, Y: 1}
		direction := Point{X: 2, Y: 1}

		point = point.MoveWithLoopX(direction, plan)
		expectedPoint := Point{X: 0, Y: 2}

		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for MoveWithLoopX, got: %d, want: %d", point, expectedPoint)
		}
	})
}

func TestIsPointEqualTo(t *testing.T) {
	t.Run("should return true for equal points", func(t *testing.T) {
		pointA := Point{X: 12, Y: -5}
		pointB := Point{X: 12, Y: -5}
		if !pointA.IsEqualTo(pointB) {
			t.Errorf("Incorrect result for IsEqualTo, got: %v, want: %v", true, false)
		}
	})

	t.Run("should return false for equal points", func(t *testing.T) {
		pointA := Point{X: 12, Y: -5}
		pointB := Point{X: 11, Y: -5}
		if pointA.IsEqualTo(pointB) {
			t.Errorf("Incorrect result for IsEqualTo, got: %v, want: %v", false, true)
		}
	})
}

func TestRotate(t *testing.T) {
	t.Run("should return next point after 90 degrees rotation", func(t *testing.T) {
		initialPoint := Point{X: 10, Y: -4}
		point := initialPoint.Rotate(90)
		expectedPoint := Point{X: 4, Y: 10}
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (90 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}

		initialPoint = point
		point = initialPoint.Rotate(90)
		expectedPoint = Point{X: -10, Y: 4}
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (90 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}

		initialPoint = point
		point = initialPoint.Rotate(90)
		expectedPoint = Point{X: -4, Y: -10}
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (90 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}

		initialPoint = point
		point = initialPoint.Rotate(90)
		expectedPoint = Point{X: 10, Y: -4}
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (90 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}
	})

	t.Run("should return next point after 180 degrees based rotation", func(t *testing.T) {
		initialPoint := Point{X: 10, Y: -4}
		point := initialPoint.Rotate(180)
		expectedPoint := Point{X: -10, Y: 4}
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (180 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}

		initialPoint = Point{X: 10, Y: -4}
		point = initialPoint.Rotate(-180)
		expectedPoint = Point{X: -10, Y: 4}
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (180 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}
	})

	t.Run("should return next point after -270 degrees based rotation", func(t *testing.T) {
		initialPoint := Point{X: 10, Y: -4}
		point := initialPoint.Rotate(-270)
		expectedPoint := Point{X: 4, Y: 10} // Same as 90deg rotation
		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for Rotate (-270 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
		}
	})
}

func TestCountMatchesInDirection(t *testing.T) {
	t.Run("should return match count in all directions", func(t *testing.T) {
		planValue := `#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##`
		plan := ConvertToPlan(planValue)
		point := Point{X: 2, Y: 3}
		count := point.CountMatchesInDirections(`\#`, `\.`, plan)
		expectedCount := 7

		if count != expectedCount {
			t.Errorf("Incorrect result for CountMatchesInDirections, got: %d, want: %d", count, expectedCount)
		}
	})
}

func TestIsMatchInDirection(t *testing.T) {
	t.Run("should return true if match is in direction", func(t *testing.T) {
		planValue := `#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##`
		plan := ConvertToPlan(planValue)
		point := Point{X: 2, Y: 2}
		direction := Point{X: 1, Y: 1}

		expression := regexp.MustCompile(`\#`)
		ignoreExpression := regexp.MustCompile(`\.`)
		if !point.isMatchInDirection(direction, expression, ignoreExpression, plan) {
			t.Errorf("Incorrect result for isMatchInDirection, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return false if match is not in direction", func(t *testing.T) {
		planValue := `#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##`
		plan := ConvertToPlan(planValue)
		point := Point{X: 6, Y: 1}
		direction := Point{X: -1, Y: 1}

		expression := regexp.MustCompile(`L`)
		ignoreExpression := regexp.MustCompile(`\.`)
		if point.isMatchInDirection(direction, expression, ignoreExpression, plan) {
			t.Errorf("Incorrect result for isMatchInDirection, got: %v, want: %v", true, false)
		}
	})
}
