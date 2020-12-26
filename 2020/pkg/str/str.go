package str

import (
	"regexp"
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

// Reverse reverses a string
func Reverse(s string) string {
	var result string
	for _, v := range s {
		result = string(v) + result
	}
	return result
}

// CountCommon counts the common values in 2 lists of strings
func CountCommon(listA []string, listB []string) int {
	var count int
	for _, itemA := range listA {
		for _, itemB := range listB {
			if itemA == itemB {
				count++
			}
    }
  }
  return count
}

// CountMatches counts the occurences of each character in a string
func CountMatches(values []string, expression string) int {
	compiled := regexp.MustCompile(expression)
	count := 0
	for _, value := range values {
		if compiled.MatchString(value) {
			count++
		}
	}
	return count
}
