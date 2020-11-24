package number

import (
	"reflect"
	"testing"
)

func TestMinMax(t *testing.T) {
	t.Run("should return min and max with different numbers", func(t *testing.T) {
		n1 := 5
		n2 := 10
		n3 := 15

		min, max := MinMax([]int{n1, n2, n3})

		if min != n1 {
			t.Errorf("Incorrect result for MinMax (min), got %d, want: %d", min, n1)
		}

		if max != n3 {
			t.Errorf("Incorrect result for MinMax (max), got %d, want: %d", min, n3)
		}
	})

	t.Run("should return min and max with some equal numbers", func(t *testing.T) {
		n1 := 10
		n2 := 10
		n3 := 15

		min, max := MinMax([]int{n1, n2, n3})

		if min != n1 {
			t.Errorf("Incorrect result for MinMax (min), got %d, want: %d", min, n1)
		}

		if max != n3 {
			t.Errorf("Incorrect result for MinMax (max), got %d, want: %d", min, n3)
		}
	})

	t.Run("should return min and max with all equal numbers", func(t *testing.T) {
		n1 := 10
		n2 := 10
		n3 := 10

		min, max := MinMax([]int{n1, n2, n3})

		if min != n1 {
			t.Errorf("Incorrect result for MinMax (min), got %d, want: %d", min, n1)
		}

		if max != n3 {
			t.Errorf("Incorrect result for MinMax (max), got %d, want: %d", min, n3)
		}
	})
}

func TestExcludeMax(t *testing.T) {
	t.Run("should exclude max with different numbers", func(t *testing.T) {
		n1 := 5
		n2 := 10
		n3 := 15

		result := ExcludeMax([]int{n1, n2, n3})
		expectedResult := []int{n1, n2}

		if !reflect.DeepEqual(result, expectedResult) {
			t.Errorf("Incorrect result for ExcludeMax, got %d, want: %d", result, expectedResult)
		}
	})

	t.Run("should exclude max with some equal numbers", func(t *testing.T) {
		n1 := 10
		n2 := 10
		n3 := 15

		result := ExcludeMax([]int{n1, n2, n3})
		expectedResult := []int{n1, n2}

		if !reflect.DeepEqual(result, expectedResult) {
			t.Errorf("Incorrect result for ExcludeMax, got %d, want: %d", result, expectedResult)
		}
	})

	t.Run("should exclude max with all equal numbers", func(t *testing.T) {
		n1 := 10
		n2 := 10
		n3 := 10

		result := ExcludeMax([]int{n1, n2, n3})
		expectedResult := []int{n1, n2}

		if !reflect.DeepEqual(result, expectedResult) {
			t.Errorf("Incorrect result for ExcludeMax, got %d, want: %d", result, expectedResult)
		}
	})
}
