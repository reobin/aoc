package plan

import (
	"fmt"
	"testing"
)

func TestGetPlanSize(t *testing.T) {
	t.Run("should return size of a valid plan", func(t *testing.T) {
		plan := "1234\n1234\n1234"
		size := GetPlanSize(plan)
		expectedSize := Size{Width: 4, Height: 3}
		if size.Width != expectedSize.Width || size.Height != expectedSize.Height {
			t.Errorf("Incorrect result for GetPlanSize, got: %d, want: %d", size, expectedSize)
		}
	})
}

func TestGetNextPosition(t *testing.T) {
	t.Run("should return next position if values are valid", func(t *testing.T) {
		currentPosition := Coordinates{X: 1, Y: 1}
		planSize := Size{Width: 5, Height: 5}
		slope := Slope{X: 1, Y: 1}

		nextPosition := GetNextPosition(currentPosition, planSize, slope)
		expectedPosition := Coordinates{X: 2, Y: 2}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})

	t.Run("should return next position restarting from left if far right has passed", func(t *testing.T) {
		currentPosition := Coordinates{X: 5, Y: 1}
		planSize := Size{Width: 5, Height: 5}
		slope := Slope{X: 2, Y: 1}

		nextPosition := GetNextPosition(currentPosition, planSize, slope)
		expectedPosition := Coordinates{X: 2, Y: 2}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})

	t.Run("should return next position staying at bottom if bottom had been reached", func(t *testing.T) {
		currentPosition := Coordinates{X: 5, Y: 5}
		planSize := Size{Width: 5, Height: 5}
		slope := Slope{X: 2, Y: 1}

		nextPosition := GetNextPosition(currentPosition, planSize, slope)
		expectedPosition := Coordinates{X: 2, Y: 5}

		if nextPosition.X != expectedPosition.X || nextPosition.Y != expectedPosition.Y {
			t.Errorf("Incorrect result for GetNextPosition, got: %d, want: %d", nextPosition, expectedPosition)
		}
	})
}

func TestGetElementAt(t *testing.T) {
	t.Run("should return element at valid position", func(t *testing.T) {
		plan := "1234\n1234\n1234"
		position := Coordinates{X: 1, Y: 2}

		element, err := GetElementAt(plan, position)
		if err != nil {
			t.Errorf("Incorrect return for GetElementAt, got error: %s", err)
		}

		expectedElement := "1"
		if element != expectedElement {
			t.Errorf("Incorrect return for GetElementAt, got: %s, want: %s", element, expectedElement)
		}
	})

	t.Run("should return error if x is overflown", func(t *testing.T) {
		plan := "1234\n1234\n1234"
		position := Coordinates{X: 8, Y: 2}
		_, err := GetElementAt(plan, position)
		if err == nil {
			t.Errorf("Incorrect return for GetElementAt, did not get error for position: %d", position)
		}
	})

	t.Run("should return error if y is overflown", func(t *testing.T) {
		plan := "1234\n1234\n1234"
		position := Coordinates{X: 2, Y: 5}
		_, err := GetElementAt(plan, position)
		if err == nil {
			t.Errorf("Incorrect return for GetElementAt, did not get error for position: %d", position)
		}
	})
}

func TestConvertToPlan(t *testing.T) {
	t.Run("should convert to plan", func(t *testing.T) {
		value := `LLLLLL.LLL
....L.LL.L
L.L.LLLLLL
L..L.LLLLL
L.LLLLLLL.
LLLLLLLLLL
L.LLL.LL.L
.....LL...
..LLLLLLLL
L.L.LLLLLL`

		expectedPlan := map[int]map[int]string{
			0: {0: "L", 1: ".", 2: "L", 3: "L", 4: "L", 5: "L", 6: "L", 7: ".", 8: ".", 9: "L"},
			1: {0: "L", 1: ".", 2: ".", 3: ".", 4: ".", 5: "L", 6: ".", 7: ".", 8: ".", 9: "."},
			2: {0: "L", 1: ".", 2: "L", 3: ".", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
			3: {0: "L", 1: ".", 2: ".", 3: "L", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "."},
			4: {0: "L", 1: "L", 2: "L", 3: ".", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
			5: {0: "L", 1: ".", 2: "L", 3: "L", 4: "L", 5: "L", 6: ".", 7: "L", 8: "L", 9: "L"},
			6: {0: ".", 1: "L", 2: "L", 3: "L", 4: "L", 5: "L", 6: "L", 7: "L", 8: "L", 9: "L"},
			7: {0: "L", 1: "L", 2: "L", 3: "L", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
			8: {0: "L", 1: ".", 2: "L", 3: "L", 4: "L", 5: "L", 6: ".", 7: ".", 8: "L", 9: "L"},
			9: {0: "L", 1: "L", 2: "L", 3: "L", 4: ".", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
		}

		plan := ConvertToPlan(value)

		if !plansAreEqual(plan, expectedPlan) {
			t.Error("Incorrect result for ConvertToPlan")
			fmt.Println("got:")
			PrintPlan(plan)
			fmt.Println("want:")
			PrintPlan(expectedPlan)
		}
	})
}

func TestCopyPlan(t *testing.T) {
	t.Run("should convert to plan", func(t *testing.T) {
		planA := map[int]map[int]string{
			0: {0: "L", 1: ".", 2: "L", 3: "L", 4: "L", 5: "L", 6: "L", 7: ".", 8: ".", 9: "L"},
			1: {0: "L", 1: ".", 2: ".", 3: ".", 4: ".", 5: "L", 6: ".", 7: ".", 8: ".", 9: "."},
			2: {0: "L", 1: ".", 2: "L", 3: ".", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
			3: {0: "L", 1: ".", 2: ".", 3: "L", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "."},
			4: {0: "L", 1: "L", 2: "L", 3: ".", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
			5: {0: "L", 1: ".", 2: "L", 3: "L", 4: "L", 5: "L", 6: ".", 7: "L", 8: "L", 9: "L"},
			6: {0: ".", 1: "L", 2: "L", 3: "L", 4: "L", 5: "L", 6: "L", 7: "L", 8: "L", 9: "L"},
			7: {0: "L", 1: "L", 2: "L", 3: "L", 4: "L", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
			8: {0: "L", 1: ".", 2: "L", 3: "L", 4: "L", 5: "L", 6: ".", 7: ".", 8: "L", 9: "L"},
			9: {0: "L", 1: "L", 2: "L", 3: "L", 4: ".", 5: "L", 6: "L", 7: ".", 8: "L", 9: "L"},
		}

		planB := CopyPlan(planA)

		if !plansAreEqual(planA, planB) {
			t.Errorf("Incorrect result for ConvertToPlan, got: %v, want: %v", false, true)
		}
	})
}

func plansAreEqual(planA Plan, planB Plan) bool {
	for x, rowA := range planA {
		for y, valueA := range rowA {
			valueB := planB[x][y]
			if valueA != valueB {
				return false
			}
		}
	}

	return true
}
