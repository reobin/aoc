package regex

import (
	"regexp"
)

// Find returns all values of different target groups in a string
func Find(value string, expression string) []string {
	compiled := regexp.MustCompile(expression)
	matches := compiled.FindStringSubmatch(value)
	if len(matches) < 1 {
		return []string{}
	}
	return matches
}

// FindAll returns all values in the string that match the regex
func FindAll(value string, expression string) [][]string {
	compiled := regexp.MustCompile(expression)
	matches := compiled.FindAllStringSubmatch(value, -1)

	return matches
}
