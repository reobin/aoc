package regex

import (
	"reflect"
	"testing"
)

func TestFindAll(t *testing.T) {
	t.Run("should return submatches", func(t *testing.T) {
		matches := FindAll("key: value", `(\w+): (\w+)`)
		expectedMatches := []string{"key", "value"}
		if !reflect.DeepEqual(matches, expectedMatches) {
			t.Errorf("Incorrect result for FindAll, got: %s, want: %s", matches, expectedMatches)
		}
	})

	t.Run("should return empty array if no match", func(t *testing.T) {
		matches := FindAll("key - value", `(\w+:)(\w+)`)
		expectedMatches := []string{}
		if !reflect.DeepEqual(matches, expectedMatches) {
			t.Errorf("Incorrect result for FindAll, got: %s, want: %s", matches, expectedMatches)
		}
	})
}
