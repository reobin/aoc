package day

import (
	"testing"
)

func TestRunDay18(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `1 + (2 * 3) + (4 * (5 + 6))`

		answerPart1, answerPart2 := RunDay18(input)

		if answerPart1 != "51" {
			t.Errorf("Incorrect result for RunDay18 (part 1), got: %s, want: %s", answerPart1, "51")
		}

		if answerPart2 != "51" {
			t.Errorf("Incorrect result for RunDay18 (part 2), got: %s, want: %s", answerPart2, "51")
		}
	})

	t.Run("sample test 1", func(t *testing.T) {
		input := `2 * 3 + (4 * 5)`

		answerPart1, answerPart2 := RunDay18(input)

		if answerPart1 != "26" {
			t.Errorf("Incorrect result for RunDay18 (part 1), got: %s, want: %s", answerPart1, "26")
		}

		if answerPart2 != "46" {
			t.Errorf("Incorrect result for RunDay18 (part 2), got: %s, want: %s", answerPart2, "51")
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		input := `5 + (8 * 3 + 9 + 3 * 4 * 3)`

		answerPart1, answerPart2 := RunDay18(input)

		if answerPart1 != "437" {
			t.Errorf("Incorrect result for RunDay18 (part 1), got: %s, want: %s", answerPart1, "437")
		}

		if answerPart2 != "1445" {
			t.Errorf("Incorrect result for RunDay18 (part 2), got: %s, want: %s", answerPart2, "1445")
		}
	})

	t.Run("sample test 3", func(t *testing.T) {
		input := `5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))`

		answerPart1, answerPart2 := RunDay18(input)

		if answerPart1 != "12240" {
			t.Errorf("Incorrect result for RunDay18 (part 1), got: %s, want: %s", answerPart1, "12240")
		}

		if answerPart2 != "669060" {
			t.Errorf("Incorrect result for RunDay18 (part 2), got: %s, want: %s", answerPart2, "669060")
		}
	})

	t.Run("sample test 4", func(t *testing.T) {
		input := `((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2`

		answerPart1, answerPart2 := RunDay18(input)

		if answerPart1 != "13632" {
			t.Errorf("Incorrect result for RunDay18 (part 1), got: %s, want: %s", answerPart1, "13632")
		}

		if answerPart2 != "23340" {
			t.Errorf("Incorrect result for RunDay18 (part 2), got: %s, want: %s", answerPart2, "23340")
		}
	})

	t.Run("sample test 5", func(t *testing.T) {
		input := `1 + 2 * 3 + 4 * 5 + 6`

		answerPart1, answerPart2 := RunDay18(input)

		if answerPart1 != "71" {
			t.Errorf("Incorrect result for RunDay18 (part 1), got: %s, want: %s", answerPart1, "71")
		}

		if answerPart2 != "231" {
			t.Errorf("Incorrect result for RunDay18 (part 2), got: %s, want: %s", answerPart2, "231")
		}
	})
}
