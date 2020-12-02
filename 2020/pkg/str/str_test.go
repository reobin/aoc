package str

import "testing"

func TestCountCharactersInString(t *testing.T) {
	t.Run("should return count if character is found", func(t *testing.T) {
		value := "abcdefabab"
		character := "a"
		exepectedCount := 3

		count := CountCharactersInString(value, character)

		if count != exepectedCount {
			t.Errorf("Incorrect result for CountCharactersInString, got: %d, want: %d", count, exepectedCount)
		}
	})

	t.Run("should return 0 if character is not found", func(t *testing.T) {
		value := "abcdefabab"
		character := "z"
		exepectedCount := 0

		count := CountCharactersInString(value, character)

		if count != exepectedCount {
			t.Errorf("Incorrect result for CountCharactersInString, got: %d, want: %d", count, exepectedCount)
		}
	})

	t.Run("should return 0 if string is empty", func(t *testing.T) {
		value := ""
		character := "z"
		exepectedCount := 0

		count := CountCharactersInString(value, character)

		if count != exepectedCount {
			t.Errorf("Incorrect result for CountCharactersInString, got: %d, want: %d", count, exepectedCount)
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
