package plan

import (
	"fmt"
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
}

func TestGetLoopedNextPosition(t *testing.T) {
	t.Run("should return next position if values are valid", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		currentPosition := Coordinates{X: 1, Y: 1}
		slope := Direction{X: 1, Y: 1}

		nextPosition := plan.GetLoopedNextPosition(currentPosition, slope)
		expectedPosition := Coordinates{X: 2, Y: 2}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetLoopedNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})

	t.Run("should return next position restarting from left if far right has passed", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		currentPosition := Coordinates{X: 3, Y: 0}
		slope := Direction{X: 2, Y: 1}

		nextPosition := plan.GetLoopedNextPosition(currentPosition, slope)
		expectedPosition := Coordinates{X: 1, Y: 1}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetLoopedNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})

	t.Run("should return next position staying at bottom if bottom had been reached", func(t *testing.T) {
		plan := Plan{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		currentPosition := Coordinates{X: 0, Y: 2}
		slope := Direction{X: 2, Y: 1}

		nextPosition := plan.GetLoopedNextPosition(currentPosition, slope)
		expectedPosition := Coordinates{X: 2, Y: 2}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetLoopedNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})
}

func TestGetNextPosition(t *testing.T) {
	t.Run("should return next position if values are valid", func(t *testing.T) {
		currentPosition := Coordinates{X: 1, Y: 1}
		slope := Direction{X: 1, Y: 1}

		nextPosition := GetNextPosition(currentPosition, slope)
		expectedPosition := Coordinates{X: 2, Y: 2}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})

	t.Run("should handle negative direction", func(t *testing.T) {
		currentPosition := Coordinates{X: 0, Y: 1}
		slope := Direction{X: -2, Y: -1}

		nextPosition := GetNextPosition(currentPosition, slope)
		expectedPosition := Coordinates{X: -2, Y: 0}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})
}

func TestConvertToPlan(t *testing.T) {
	t.Run("should convert to plan", func(t *testing.T) {
		value := `LLL
...
L.L
L..
L.L`

		expectedPlan := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		plan := ConvertToPlan(value)

		if !plansAreEqual(plan, expectedPlan) {
			t.Error("Incorrect result for ConvertToPlan")
			fmt.Println("got:")
			plan.Print()
			fmt.Println("want:")
			expectedPlan.Print()
		}
	})
}

func TestCopyPlan(t *testing.T) {
	t.Run("should convert to plan", func(t *testing.T) {
		planA := Plan{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: ".", {X: 2, Y: 0}: ".",
			{X: 0, Y: 1}: "L", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: "L",
		}

		planB := planA.Copy()

		if !plansAreEqual(planA, planB) {
			t.Errorf("Incorrect result for ConvertToPlan, got: %v, want: %v", false, true)
		}
	})
}

func plansAreEqual(planA Plan, planB Plan) bool {
	for position, valueA := range planA {
		valueB := planB[position]
		if valueA != valueB {
			return false
		}
	}
	return true
}
