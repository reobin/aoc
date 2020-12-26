package point

import (
	"fmt"
	"reflect"
	"regexp"
	"testing"
)

func TestGetSize(t *testing.T) {
	t.Run("should return size of a valid 2d grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		size := grid.GetSize()
		expectedSize := Size{Width: 4, Height: 3, Depth: 1}
		if size.Width != expectedSize.Width || size.Height != expectedSize.Height {
			t.Errorf("Incorrect result for GetSize, got: %d, want: %d", size, expectedSize)
		}
	})

	t.Run("should return size of a valid 3d grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0, Z: 0}: "1", {X: 1, Y: 0, Z: 0}: "2", {X: 2, Y: 0, Z: 0}: "3", {X: 3, Y: 0, Z: 0}: "4",
			{X: 0, Y: 1, Z: 0}: "1", {X: 1, Y: 1, Z: 0}: "2", {X: 2, Y: 1, Z: 0}: "3", {X: 3, Y: 1, Z: 0}: "4",
			{X: 0, Y: 2, Z: 0}: "1", {X: 1, Y: 2, Z: 0}: "2", {X: 2, Y: 2, Z: 0}: "3", {X: 3, Y: 2, Z: 0}: "4",
			{X: 0, Y: 0, Z: 1}: "1", {X: 1, Y: 0, Z: 1}: "2", {X: 2, Y: 0, Z: 1}: "3", {X: 3, Y: 0, Z: 1}: "4",
			{X: 0, Y: 1, Z: 1}: "1", {X: 1, Y: 1, Z: 1}: "2", {X: 2, Y: 1, Z: 1}: "3", {X: 3, Y: 1, Z: 1}: "4",
			{X: 0, Y: 2, Z: 1}: "1", {X: 1, Y: 2, Z: 1}: "2", {X: 2, Y: 2, Z: 1}: "3", {X: 3, Y: 2, Z: 1}: "4",
		}
		size := grid.GetSize()
		expectedSize := Size{Width: 4, Height: 3, Depth: 2}
		if size.Width != expectedSize.Width || size.Height != expectedSize.Height {
			t.Errorf("Incorrect result for GetSize, got: %d, want: %d", size, expectedSize)
		}
	})

	t.Run("should return size of an empty grid", func(t *testing.T) {
		grid := Grid{}
		size := grid.GetSize()
		expectedSize := Size{Width: 1, Height: 1, Depth: 1}
		if !reflect.DeepEqual(size, expectedSize) {
			t.Errorf("Incorrect result for GetSize, got: %d, want: %d", size, expectedSize)
		}
	})
}

func TestFlipX(t *testing.T) {
	t.Run("should return flipped grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "0", {X: 1, Y: 0}: "0", {X: 2, Y: 0}: "0", {X: 3, Y: 0}: "0",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "0", {X: 1, Y: 2}: "0", {X: 2, Y: 2}: "0", {X: 3, Y: 2}: "0",
		}
		result := grid.FlipX()
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for FlipX, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return flipped 2x2 grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "0", {X: 1, Y: 0}: "0",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2",
			{X: 0, Y: 1}: "0", {X: 1, Y: 1}: "0",
		}
		result := grid.FlipX()
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for FlipX, got: %v, want: %v", false, true)
		}
	})
}

func TestFlipY(t *testing.T) {
	t.Run("should return flipped grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "4", {X: 1, Y: 0}: "3", {X: 2, Y: 0}: "2", {X: 3, Y: 0}: "1",
			{X: 0, Y: 1}: "4", {X: 1, Y: 1}: "3", {X: 2, Y: 1}: "2", {X: 3, Y: 1}: "1",
			{X: 0, Y: 2}: "4", {X: 1, Y: 2}: "3", {X: 2, Y: 2}: "2", {X: 3, Y: 2}: "1",
		}
		result := grid.FlipY()
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for FlipY, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return flipped 2x2 grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "0", {X: 1, Y: 0}: "0",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "0", {X: 1, Y: 0}: "0",
			{X: 0, Y: 1}: "2", {X: 1, Y: 1}: "1",
		}
		result := grid.FlipY()
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for FlipY, got: %v, want: %v", false, true)
		}
	})
}

func TestRotateGrid(t *testing.T) {
	t.Run("should return rotated grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "0", {X: 1, Y: 0}: "0", {X: 2, Y: 0}: "0",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "1", {X: 2, Y: 0}: "0",
			{X: 0, Y: 1}: "2", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "0",
			{X: 0, Y: 2}: "3", {X: 1, Y: 2}: "3", {X: 2, Y: 2}: "0",
		}
		result := grid.Rotate(90)
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for Rotate, got: %v, want: %v", false, true)
			fmt.Println("from:")
			grid.Print()
			fmt.Println("got:")
			result.Print()
			fmt.Println("want:")
			expectedGrid.Print()
		}
	})

	t.Run("should return bigger rotated grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L", {X: 3, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".", {X: 3, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: "L", {X: 2, Y: 2}: ".", {X: 3, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: "L", {X: 2, Y: 3}: ".", {X: 3, Y: 3}: "L",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: ".", {X: 3, Y: 0}: "L",
			{X: 0, Y: 1}: "L", {X: 1, Y: 1}: "L", {X: 2, Y: 1}: ".", {X: 3, Y: 1}: "L",
			{X: 0, Y: 2}: ".", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: ".", {X: 3, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: "L", {X: 2, Y: 3}: ".", {X: 3, Y: 3}: "L",
		}
		result := grid.Rotate(90)
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for Rotate, got: %v, want: %v", false, true)
			fmt.Println("from:")
			grid.Print()
			fmt.Println("got: ")
			result.Print()
			fmt.Println("want: ")
			expectedGrid.Print()
		}
	})

	t.Run("should return bigger rotated grid 180", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L", {X: 3, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".", {X: 3, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: "L", {X: 2, Y: 2}: ".", {X: 3, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: "L", {X: 2, Y: 3}: ".", {X: 3, Y: 3}: "L",
		}
		expectedGrid := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: ".", {X: 2, Y: 0}: "L", {X: 3, Y: 0}: "L",
			{X: 0, Y: 1}: "L", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: "L", {X: 3, Y: 1}: "L",
			{X: 0, Y: 2}: ".", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: ".", {X: 3, Y: 2}: ".",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: "L", {X: 2, Y: 3}: "L", {X: 3, Y: 3}: "L",
		}
		result := grid.Rotate(180)
		if !result.IsEqualTo(expectedGrid) {
			t.Errorf("Incorrect result for Rotate (180), got: %v, want: %v", false, true)
			fmt.Println("from:")
			grid.Print()
			fmt.Println("got: ")
			result.Print()
			fmt.Println("want: ")
			expectedGrid.Print()
		}
	})
}

func TestConvertToString(t *testing.T) {
	t.Run("should convert a valid grid to a string value", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}
		expectedStringValue := `1234
1234
1234`
		stringValue := grid.ConvertToString()

		if stringValue != expectedStringValue {
			t.Errorf("Incorrect result for ConvertToString, got: %s, want: %s", stringValue, expectedStringValue)
		}
	})
}

func TestIsGridEqualTo(t *testing.T) {
	t.Run("should return true for equal grids", func(t *testing.T) {
		gridA := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		gridB := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		if !gridA.IsEqualTo(gridB) {
			t.Errorf("Incorrect result for IsEqualTo, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return false for unequal grids", func(t *testing.T) {
		gridA := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		gridB := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
		}

		if gridA.IsEqualTo(gridB) {
			t.Errorf("Incorrect result for IsEqualTo, got: %v, want: %v", true, false)
		}
	})
}

func TestCopy(t *testing.T) {
	t.Run("should return an equal copy of grid", func(t *testing.T) {
		gridA := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		gridB := gridA.Copy()

		if !gridA.IsEqualTo(gridB) {
			t.Errorf("Incorrect result for Copy, got: %v, want: %v", false, true)
		}
	})
}

func TestCountMatches(t *testing.T) {
	t.Run("should return match count", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
		}

		matchCount := grid.CountMatches(`(L)`)

		if matchCount != 8 {
			t.Errorf("Incorrect result for CountMatches, got: %d, want: %d", matchCount, 8)
		}
	})

	t.Run("should return match count on 3d grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "L", {X: 1, Y: 0}: "L", {X: 2, Y: 0}: "L",
			{X: 0, Y: 1}: ".", {X: 1, Y: 1}: ".", {X: 2, Y: 1}: ".",
			{X: 0, Y: 2}: "L", {X: 1, Y: 2}: ".", {X: 2, Y: 2}: "L",
			{X: 0, Y: 3}: "L", {X: 1, Y: 3}: ".", {X: 2, Y: 3}: ".",
			{X: 0, Y: 4}: "L", {X: 1, Y: 4}: ".", {X: 2, Y: 4}: "L",
			{X: 0, Y: 0, Z: 1}: "L", {X: 1, Y: 0, Z: 1}: "L", {X: 2, Y: 0, Z: 1}: "L",
			{X: 0, Y: 1, Z: 1}: ".", {X: 1, Y: 1, Z: 1}: ".", {X: 2, Y: 1, Z: 1}: ".",
			{X: 0, Y: 2, Z: 1}: "L", {X: 1, Y: 2, Z: 1}: ".", {X: 2, Y: 2, Z: 1}: "L",
			{X: 0, Y: 3, Z: 1}: "L", {X: 1, Y: 3, Z: 1}: ".", {X: 2, Y: 3, Z: 1}: ".",
			{X: 0, Y: 4, Z: 1}: "L", {X: 1, Y: 4, Z: 1}: ".", {X: 2, Y: 4, Z: 1}: "L",
		}

		matchCount := grid.CountMatches(`(L)`)

		if matchCount != 16 {
			t.Errorf("Incorrect result for CountMatches, got: %d, want: %d", matchCount, 16)
		}
	})
}

func TestConvertToGrid(t *testing.T) {
	t.Run("should convert string to an equivalent grid", func(t *testing.T) {
		value := `1234
1234
1234`

		grid := ConvertToGrid(value)

		expectedGrid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		if !grid.IsEqualTo(expectedGrid) {
			t.Error("Incorrect result for ConvertToGrid")
			fmt.Println("got: ")
			grid.Print()
			fmt.Println("got: ")
			expectedGrid.Print()
		}
	})
}

func TestGetNeighbors(t *testing.T) {
	t.Run("should get all 8 neighbors if point is in middle", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		point := Point{X: 2, Y: 1}

		count := point.CountMatchingNeighbors(`.`, grid, 2)
		expectedCount := 8

		if count != expectedCount {
			t.Errorf("Incorrect result for CountMatchingNeighbors, got: %d, want: %d", count, expectedCount)
		}
	})

	t.Run("should get immediate neighbors if point is on edge", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		point := Point{X: 3, Y: 0}

		count := point.CountMatchingNeighbors(`.`, grid, 2)
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
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		point := Point{X: 2, Y: 1}
		direction := Point{X: 2, Y: 1}

		point = point.MoveWithLoopX(direction, grid)
		expectedPoint := Point{X: 0, Y: 2}

		if !point.IsEqualTo(expectedPoint) {
			t.Errorf("Incorrect result for MoveWithLoopX, got: %d, want: %d", point, expectedPoint)
		}
	})
}

func TestGetLeft(t *testing.T) {
	t.Run("should return left of grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		left := grid.GetLeft()
		expectedLeft := "111"

		if left != expectedLeft {
			t.Errorf("Incorrect result for GetLeft, got: %s, want: %s", left, expectedLeft)
		}
	})
}

func TestGetRight(t *testing.T) {
	t.Run("should return right of grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		right := grid.GetRight()
		expectedRight := "444"

		if right != expectedRight {
			t.Errorf("Incorrect result for GetRight, got: %s, want: %s", right, expectedRight)
		}
	})
}

func TestGetBottom(t *testing.T) {
	t.Run("should return bottom of grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		bottom := grid.GetBottom()
		expectedBottom := "1234"

		if bottom != expectedBottom {
			t.Errorf("Incorrect result for GetBottom, got: %s, want: %s", bottom, expectedBottom)
		}
	})
}

func TestGetTop(t *testing.T) {
	t.Run("should return top of grid", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2", {X: 2, Y: 0}: "3", {X: 3, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2", {X: 2, Y: 1}: "3", {X: 3, Y: 1}: "4",
			{X: 0, Y: 2}: "1", {X: 1, Y: 2}: "2", {X: 2, Y: 2}: "3", {X: 3, Y: 2}: "4",
		}

		top := grid.GetTop()
		expectedTop := "1234"

		if top != expectedTop {
			t.Errorf("Incorrect result for GetTop, got: %s, want: %s", top, expectedTop)
		}
	})
}

func TestGetAllOrientations(t *testing.T) {
	t.Run("should return all possible orientations", func(t *testing.T) {
		grid := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2",
			{X: 0, Y: 1}: "3", {X: 1, Y: 1}: "4",
		}
		rot90 := Grid{
			{X: 0, Y: 0}: "3", {X: 1, Y: 0}: "1",
			{X: 0, Y: 1}: "4", {X: 1, Y: 1}: "2",
		}
		rot180 := Grid{
			{X: 0, Y: 0}: "4", {X: 1, Y: 0}: "3",
			{X: 0, Y: 1}: "2", {X: 1, Y: 1}: "1",
		}
		rot270 := Grid{
			{X: 0, Y: 0}: "2", {X: 1, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "3",
		}
		flippedX := Grid{
			{X: 0, Y: 0}: "3", {X: 1, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2",
		}
		flippedXRot90 := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "3",
			{X: 0, Y: 1}: "2", {X: 1, Y: 1}: "4",
		}
		flippedXRot180 := Grid{
			{X: 0, Y: 0}: "2", {X: 1, Y: 0}: "1",
			{X: 0, Y: 1}: "4", {X: 1, Y: 1}: "3",
		}
		flippedXRot270 := Grid{
			{X: 0, Y: 0}: "4", {X: 1, Y: 0}: "2",
			{X: 0, Y: 1}: "3", {X: 1, Y: 1}: "1",
		}
		flippedY := Grid{
			{X: 0, Y: 0}: "2", {X: 1, Y: 0}: "1",
			{X: 0, Y: 1}: "4", {X: 1, Y: 1}: "3",
		}
		flippedYRot90 := Grid{
			{X: 0, Y: 0}: "4", {X: 1, Y: 0}: "2",
			{X: 0, Y: 1}: "3", {X: 1, Y: 1}: "1",
		}
		flippedYRot180 := Grid{
			{X: 0, Y: 0}: "3", {X: 1, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "2",
		}
		flippedYRot270 := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "3",
			{X: 0, Y: 1}: "2", {X: 1, Y: 1}: "4",
		}
		flipped := Grid{
			{X: 0, Y: 0}: "4", {X: 1, Y: 0}: "3",
			{X: 0, Y: 1}: "2", {X: 1, Y: 1}: "1",
		}
		flippedRot90 := Grid{
			{X: 0, Y: 0}: "2", {X: 1, Y: 0}: "4",
			{X: 0, Y: 1}: "1", {X: 1, Y: 1}: "3",
		}
		flippedRot180 := Grid{
			{X: 0, Y: 0}: "1", {X: 1, Y: 0}: "2",
			{X: 0, Y: 1}: "3", {X: 1, Y: 1}: "4",
		}
		flippedRot270 := Grid{
			{X: 0, Y: 0}: "3", {X: 1, Y: 0}: "1",
			{X: 0, Y: 1}: "4", {X: 1, Y: 1}: "2",
		}

		grids := grid.GetAllOrientations()
		expectedGrids := []Grid{grid, rot90, rot180, rot270, flippedX, flippedXRot90, flippedXRot180, flippedXRot270, flippedY, flippedYRot90, flippedYRot180, flippedYRot270, flipped, flippedRot90, flippedRot180, flippedRot270}

		isEqual := true
		for _, gridA := range grids {
			found := false
			for _, gridB := range expectedGrids {
				if gridA.IsEqualTo(gridB) {
					found = true
				}
			}
			if !found {
				isEqual = false
				break
			}
		}
		if !isEqual {
			t.Errorf("Incorrect result for GetAllOrientations, got length: %d, want length: %d", len(grids), len(expectedGrids))
			fmt.Println("got:")
			for _, grid := range grids {
				grid.Print()
				fmt.Println()
			}
			fmt.Println("want:")
			for _, grid := range expectedGrids {
				grid.Print()
				fmt.Println()
			}
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
			t.Errorf("Incorrect result for Rotate (-180 rotation on %d), got: %d, want: %d", initialPoint, point, expectedPoint)
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
		gridValue := `#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##`
		grid := ConvertToGrid(gridValue)
		point := Point{X: 2, Y: 3}
		count := point.CountMatchesInDirections(`\#`, `\.`, grid)
		expectedCount := 7

		if count != expectedCount {
			t.Errorf("Incorrect result for CountMatchesInDirections, got: %d, want: %d", count, expectedCount)
		}
	})
}

func TestIsMatchInDirection(t *testing.T) {
	t.Run("should return true if match is in direction", func(t *testing.T) {
		gridValue := `#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##`
		grid := ConvertToGrid(gridValue)
		point := Point{X: 2, Y: 2}
		direction := Point{X: 1, Y: 1}

		expression := regexp.MustCompile(`\#`)
		ignoreExpression := regexp.MustCompile(`\.`)
		if !point.isMatchInDirection(direction, expression, ignoreExpression, grid) {
			t.Errorf("Incorrect result for isMatchInDirection, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return false if match is not in direction", func(t *testing.T) {
		gridValue := `#.##.L#.##
#L###LL.L#
L.#.#..#..
#L##.##.L#
#.##.LL.LL
#.###L#.##
..#.#.....
#L######L#
#.LL###L.L
#.#L###.##`
		grid := ConvertToGrid(gridValue)
		point := Point{X: 6, Y: 1}
		direction := Point{X: -1, Y: 1}

		expression := regexp.MustCompile(`L`)
		ignoreExpression := regexp.MustCompile(`\.`)
		if point.isMatchInDirection(direction, expression, ignoreExpression, grid) {
			t.Errorf("Incorrect result for isMatchInDirection, got: %v, want: %v", true, false)
		}
	})
}
