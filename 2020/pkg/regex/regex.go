package regex

import (
	"regexp"
)

// FindAll returns all values searched with regex target groups
func FindAll(value string, expression string) []string {
	compiled := regexp.MustCompile(expression)
	matches := compiled.FindStringSubmatch(value)
	if len(matches) < 2 {
		return []string{}
	}
	return matches[1:]
}
