package number

// MinMax returns the min and the max number from a list of numbers
func MinMax(numbers []int) (int, int) {
	minimum := -1
	maximum := -1
	for _, n := range numbers {
		if minimum == -1 || n < minimum {
			minimum = n
		}
		if maximum == -1 || n > maximum {
			maximum = n
		}
	}
	return minimum, maximum
}

// ExcludeMax returns a list without the maximum number of the given list
func ExcludeMax(numbers []int) []int {
	_, max := MinMax(numbers)
	excluded := false
	result := []int{}
	for _, n := range numbers {
		if n == max && !excluded {
			excluded = true
			continue
		}
		result = append(result, n)
	}
	return result
}
