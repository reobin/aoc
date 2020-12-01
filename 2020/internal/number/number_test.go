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
			t.Errorf("Incorrect result for ConvertToNumbers, got :%d, want: %d", numbers, expectedNumbers)
		}
	})

	t.Run("should ignore non number values without erroring", func(t *testing.T) {
		values := []string{"2", "3", "4", "test", "5"}
		expectedNumbers := []int{2, 3, 4, 5}
		numbers := ConvertToNumbers(values)
		if !reflect.DeepEqual(expectedNumbers, numbers) {
			t.Errorf("Incorrect result for ConvertToNumbers, got :%d, want: %d", numbers, expectedNumbers)
		}
	})

	t.Run("should accept negative numbers", func(t *testing.T) {
		values := []string{"2", "-3", "4"}
		expectedNumbers := []int{2, -3, 4}
		numbers := ConvertToNumbers(values)
		if !reflect.DeepEqual(expectedNumbers, numbers) {
			t.Errorf("Incorrect result for ConvertToNumbers, got :%d, want: %d", numbers, expectedNumbers)
		}
	})
}
