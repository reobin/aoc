package str

import "testing"

func TestCountCharacters(t *testing.T) {
	t.Run("should return count if character is found", func(t *testing.T) {
		value := "abcdefabab"
		expectedCount := 3

		count := CountCharacters(value)

		if count["a"] != expectedCount {
			t.Errorf("Incorrect result for CountCharacters, got: %d, want: %d", count["a"], expectedCount)
		}
	})

	t.Run("should return 0 if character is not found", func(t *testing.T) {
		value := "abcdefabab"
		expectedCount := 0

		count := CountCharacters(value)

		if count["z"] != expectedCount {
			t.Errorf("Incorrect result for CountCharacters, got: %d, want: %d", count["z"], expectedCount)
		}
	})

	t.Run("should return 0 if string is empty", func(t *testing.T) {
		value := ""
		expectedCount := 0

		count := CountCharacters(value)

		if count["z"] != expectedCount {
			t.Errorf("Incorrect result for CountCharacters, got: %d, want: %d", count["z"], expectedCount)
		}
	})
}

func TestRemoveEmptyLines(t *testing.T) {
	t.Run("should remove first line if it's empty", func(t *testing.T) {
		input := `
test`

		trimmed := RemoveEmptyLines(input)

		if trimmed != "test" {
			t.Errorf("Incorrect result for RemoveEmptyLines, got: %s, want: %s", trimmed, "test")
		}
	})

	t.Run("should remove line in the middle if it's empty", func(t *testing.T) {
		input := `hey

test`

		trimmed := RemoveEmptyLines(input)

		expectedTrimmed := `hey
test`

		if trimmed != expectedTrimmed {
			t.Errorf("Incorrect result for RemoveEmptyLines, got: %s, want: %s", trimmed, expectedTrimmed)
		}
	})

	t.Run("should remove last line if it's empty", func(t *testing.T) {
		input := `test
`

		trimmed := RemoveEmptyLines(input)

		if trimmed != "test" {
			t.Errorf("Incorrect result for RemoveEmptyLines, got: %s, want: %s", trimmed, "test")
		}
	})

	t.Run("should remove nothing if there's no empty line", func(t *testing.T) {
		input := "test"

		trimmed := RemoveEmptyLines(input)

		if trimmed != "test" {
			t.Errorf("Incorrect result for RemoveEmptyLines, got: %s, want: %s", trimmed, "test")
		}
	})
}

func TestCountMatches(t *testing.T) {
	t.Run("should return count if match is found", func(t *testing.T) {
		values := []string{"abc", "ab", "abc"}
		expectedCount := 2

		count := CountMatches(values, `abc`)

		if expectedCount != count {
			t.Errorf("Incorrect result for CountMatches, got: %d, want: %d", count, expectedCount)
		}
	})
}
