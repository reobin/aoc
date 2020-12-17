package number

import (
	"reflect"
	"testing"
)

func TestComputeProduct(t *testing.T) {
	t.Run("should return product of 2 integers", func(t *testing.T) {
		numbers := []int{2, 3}
		expectedProduct := 6
		product := ComputeProduct(numbers)
		if product != expectedProduct {
			t.Errorf("Incorrect result for ComputeProduct, got: %d, want: %d", product, expectedProduct)
		}
	})

	t.Run("should return product of 6 integers", func(t *testing.T) {
		numbers := []int{2, 3, 5, 6, 199, 100}
		expectedProduct := 3582000
		product := ComputeProduct(numbers)
		if product != expectedProduct {
			t.Errorf("Incorrect result for ComputeProduct, got: %d, want: %d", product, expectedProduct)
		}
	})

	t.Run("should return 0 if one 0 is present", func(t *testing.T) {
		numbers := []int{2, 3, 5, 6, 199, 0}
		expectedProduct := 0
		product := ComputeProduct(numbers)
		if product != expectedProduct {
			t.Errorf("Incorrect result for ComputeProduct, got: %d, want: %d", product, expectedProduct)
		}
	})

	t.Run("should handle negative numbers", func(t *testing.T) {
		numbers := []int{2, 3, 5, 6, 199, 100, -1}
		expectedProduct := -3582000
		product := ComputeProduct(numbers)
		if product != expectedProduct {
			t.Errorf("Incorrect result for ComputeProduct, got: %d, want: %d", product, expectedProduct)
		}
	})
}

func TestComputeSum(t *testing.T) {
	t.Run("should return sum of 2 integers", func(t *testing.T) {
		numbers := []int{2, 3}
		expectedSum := 5
		sum := ComputeSum(numbers)
		if sum != expectedSum {
			t.Errorf("Incorrect result for ComputeSum, got: %d, want: %d", sum, expectedSum)
		}
	})

	t.Run("should return product of 6 integers", func(t *testing.T) {
		numbers := []int{2, 3, 5, 6, 199, 100}
		expectedSum := 315
		sum := ComputeSum(numbers)
		if sum != expectedSum {
			t.Errorf("Incorrect result for ComputeSum, got: %d, want: %d", sum, expectedSum)
		}
	})

	t.Run("should handle negative numbers", func(t *testing.T) {
		numbers := []int{2, 3, -1, -1, -1}
		expectedSum := 2
		sum := ComputeSum(numbers)
		if sum != expectedSum {
			t.Errorf("Incorrect result for ComputeSum, got: %d, want: %d", sum, expectedSum)
		}
	})
}

func TestContains(t *testing.T) {
	t.Run("should return true if number is in the list", func(t *testing.T) {
		numbers := []int{1, 2, 3}
		n := 1

		if !Contains(numbers, n) {
			t.Errorf("Incorrect result for Contains, got false with %d in %d", n, numbers)
		}
	})

	t.Run("should return false if number is not in the list", func(t *testing.T) {
		numbers := []int{1, 2, 3}
		n := 4

		if Contains(numbers, n) {
			t.Errorf("Incorrect result for Contains, got true with %d in %d", n, numbers)
		}
	})

	t.Run("should return false if list is empty", func(t *testing.T) {
		numbers := []int{}
		n := 4

		if Contains(numbers, n) {
			t.Errorf("Incorrect result for Contains, got true with %d in %d", n, numbers)
		}
	})
}

func TestConvertToNumbers(t *testing.T) {
	t.Run("should convert a list of string numbers", func(t *testing.T) {
		values := []string{"2", "3", "4"}
		expectedNumbers := []int{2, 3, 4}
		numbers := ConvertToNumbers(values)
		if !reflect.DeepEqual(expectedNumbers, numbers) {
			t.Errorf("Incorrect result for ConvertToNumbers, got: %d, want: %d", numbers, expectedNumbers)
		}
	})

	t.Run("should ignore non number values without erroring", func(t *testing.T) {
		values := []string{"2", "3", "4", "test", "5"}
		expectedNumbers := []int{2, 3, 4, 5}
		numbers := ConvertToNumbers(values)
		if !reflect.DeepEqual(expectedNumbers, numbers) {
			t.Errorf("Incorrect result for ConvertToNumbers, got: %d, want: %d", numbers, expectedNumbers)
		}
	})

	t.Run("should accept negative numbers", func(t *testing.T) {
		values := []string{"2", "-3", "4"}
		expectedNumbers := []int{2, -3, 4}
		numbers := ConvertToNumbers(values)
		if !reflect.DeepEqual(expectedNumbers, numbers) {
			t.Errorf("Incorrect result for ConvertToNumbers, got: %d, want: %d", numbers, expectedNumbers)
		}
	})
}

func TestIsNumberInRange(t *testing.T) {
	t.Run("should return true if number is inside range", func(t *testing.T) {
		valueRange := Range{Minimum: 120, Maximum: 150}
		value := 130
		if !IsNumberInRange(value, valueRange) {
			t.Errorf("Incorrect result for IsNumberInRange, got: %v, want: %v", true, false)
		}
	})

	t.Run("should return false if number is outside range", func(t *testing.T) {
		valueRange := Range{Minimum: 120, Maximum: 150}
		value := 170
		if IsNumberInRange(value, valueRange) {
			t.Errorf("Incorrect result for IsNumberInRange, got: %v, want: %v", false, true)
		}
	})

	t.Run("should return true if negative number is inside range", func(t *testing.T) {
		valueRange := Range{Minimum: -150, Maximum: -120}
		value := -130
		if !IsNumberInRange(value, valueRange) {
			t.Errorf("Incorrect result for IsNumberInRange, got: %v, want: %v", true, false)
		}
	})

	t.Run("should return true if number is equal to min range", func(t *testing.T) {
		valueRange := Range{Minimum: 120, Maximum: 150}
		value := 120
		if !IsNumberInRange(value, valueRange) {
			t.Errorf("Incorrect result for IsNumberInRange, got: %v, want: %v", true, false)
		}
	})

	t.Run("should return true if number is equal to max range", func(t *testing.T) {
		valueRange := Range{Minimum: 120, Maximum: 150}
		value := 150
		if !IsNumberInRange(value, valueRange) {
			t.Errorf("Incorrect result for IsNumberInRange, got: %v, want: %v", true, false)
		}
	})
}

func TestGetMiddle(t *testing.T) {
	t.Run("should return middle of even numbers", func(t *testing.T) {
		middle := GetMiddle(Range{Minimum: 100, Maximum: 200}, true)
		if middle != 150 {
			t.Errorf("Incorrect result for GetMiddle, got: %d, want: %d", middle, 150)
		}
	})

	t.Run("should return ceiling middle of uneven division", func(t *testing.T) {
		middle := GetMiddle(Range{Minimum: 2, Maximum: 3}, true)
		if middle != 3 {
			t.Errorf("Incorrect result for GetMiddle, got: %d, want: %d", middle, 3)
		}
	})

	t.Run("should return floor middle of uneven division", func(t *testing.T) {
		middle := GetMiddle(Range{Minimum: 2, Maximum: 3}, false)
		if middle != 2 {
			t.Errorf("Incorrect result for GetMiddle, got: %d, want: %d", middle, 2)
		}
	})
}

func TestConvertToMap(t *testing.T) {
	t.Run("should convert a slice of numbers to a map", func(t *testing.T) {
		slice := []int{1, 2, 3}
		converted := ConvertToMap(slice)
		expected := map[int]bool{
			1: true,
			2: true,
			3: true,
		}
		if !reflect.DeepEqual(converted, expected) {
			t.Errorf("Incorrect result for ConvertToMap, got: %v, want: %v", converted, expected)
		}
	})

	t.Run("should convert an empty slice of numbers to a map", func(t *testing.T) {
		slice := []int{}
		converted := ConvertToMap(slice)
		expected := map[int]bool{}
		if !reflect.DeepEqual(converted, expected) {
			t.Errorf("Incorrect result for ConvertToMap, got: %v, want: %v", converted, expected)
		}
	})
}

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

	t.Run("should return min and max with negative numbers", func(t *testing.T) {
		n1 := -2
		n2 := -3
		n3 := 4

		min, max := MinMax([]int{n1, n2, n3})

		if min != n2 {
			t.Errorf("Incorrect result for MinMax (min), got %d, want: %d", min, n2)
		}

		if max != n3 {
			t.Errorf("Incorrect result for MinMax (max), got %d, want: %d", min, n3)
		}
	})
}
