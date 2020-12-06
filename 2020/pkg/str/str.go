package str

import (
	"strings"
)

// CountCharacters counts the occurences of each character in a string
func CountCharacters(value string) map[string]int {
	characterCount := make(map[string]int)
	for _, character := range value {
		characterCount[string(character)]++
	}
	return characterCount
}

// RemoveEmptyLines removes all empty lines in a string
func RemoveEmptyLines(value string) string {
	var result []string

	for _, line := range strings.Split(value, "\n") {
		if line != "" {
			result = append(result, line)
		}
	}

	return strings.Join(result, "\n")
}

// Contains returns true if the value was found in the list
func Contains(values []string, value string) bool {
	for _, v := range values {
		if v == value {
			return true
		}
	}
	return false
}
