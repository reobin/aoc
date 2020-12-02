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
