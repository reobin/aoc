package day

import (
	"testing"
)

func TestRunDay15(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `0,3,6`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "436" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "436")
		}

		if answerPart2 != "175594" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "175594")
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		input := `1,3,2`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "1" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "1")
		}

		if answerPart2 != "2578" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "2578")
		}
	})

	t.Run("sample test 3", func(t *testing.T) {
		input := `2,1,3`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "10" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "10")
		}

		if answerPart2 != "3544142" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "3544142")
		}
	})

	t.Run("sample test 4", func(t *testing.T) {
		input := `1,2,3`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "27" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "27")
		}

		if answerPart2 != "261214" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "261214")
		}
	})

	t.Run("sample test 5", func(t *testing.T) {
		input := `2,3,1`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "78" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "78")
		}

		if answerPart2 != "6895259" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "6895259")
		}
	})

	t.Run("sample test 6", func(t *testing.T) {
		input := `3,2,1`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "438" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "438")
		}

		if answerPart2 != "18" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "18")
		}
	})

	t.Run("sample test 7", func(t *testing.T) {
		input := `3,1,2`

		answerPart1, answerPart2 := RunDay15(input)

		if answerPart1 != "1836" {
			t.Errorf("Incorrect result for RunDay15 (part 1), got: %s, want: %s", answerPart1, "1836")
		}

		if answerPart2 != "362" {
			t.Errorf("Incorrect result for RunDay15 (part 2), got: %s, want: %s", answerPart2, "362")
		}
	})
}
