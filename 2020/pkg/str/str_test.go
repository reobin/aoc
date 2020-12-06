package str

import "testing"

func TestCountCharacters(t *testing.T) {
	t.Run("should return count if character is found", func(t *testing.T) {
		value := "abcdefabab"
		exepectedCount := 3

		count := CountCharacters(value)

		if count["a"] != exepectedCount {
			t.Errorf("Incorrect result for CountCharacters, got: %d, want: %d", count["a"], exepectedCount)
		}
	})

	t.Run("should return 0 if character is not found", func(t *testing.T) {
		value := "abcdefabab"
		exepectedCount := 0

		count := CountCharacters(value)

		if count["z"] != exepectedCount {
			t.Errorf("Incorrect result for CountCharacters, got: %d, want: %d", count["z"], exepectedCount)
		}
	})

	t.Run("should return 0 if string is empty", func(t *testing.T) {
		value := ""
		exepectedCount := 0

		count := CountCharacters(value)

		if count["z"] != exepectedCount {
			t.Errorf("Incorrect result for CountCharacters, got: %d, want: %d", count["z"], exepectedCount)
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
