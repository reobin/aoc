package regex

import (
	"reflect"
	"testing"
)

func TestFind(t *testing.T) {
	t.Run("should return submatches", func(t *testing.T) {
		matches := Find("key: value", `(\w+): (\w+)`)
		expectedMatches := []string{"key: value", "key", "value"}
		if !reflect.DeepEqual(matches, expectedMatches) {
			t.Errorf("Incorrect result for Find, got: %s, want: %s", matches, expectedMatches)
		}
	})

	t.Run("should return empty array if no match", func(t *testing.T) {
		matches := Find("key - value", `(\w+:)(\w+)`)
		if len(matches) > 0 {
			t.Errorf("Incorrect result for Find, got: %s, want: %s", matches, []string{})
		}
	})
}

func TestFindAll(t *testing.T) {
	t.Run("should return all matches", func(t *testing.T) {
		matches := FindAll("d:3 e:4 f:5", `(\w):(\d)`)
		expectedMatches := [][]string{{"d:3", "d", "3"}, {"e:4", "e", "4"}, {"f:5", "f", "5"}}
		if !reflect.DeepEqual(matches, expectedMatches) {
			t.Errorf("Incorrect result for FindAll, got: %s, want: %s", matches, expectedMatches)
		}
	})

	t.Run("should return empty array if no match", func(t *testing.T) {
		matches := FindAll("d:3 e:4 f:5", `(\d):(\w)`)
		if len(matches) > 0 {
			t.Errorf("Incorrect result for FindAll, got: %s, want: %s", matches, [][]string{})
		}
	})
}
