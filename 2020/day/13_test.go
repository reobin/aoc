package day

import (
	"testing"
)

func TestRunDay13(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `939
7,13,x,x,59,x,31,19`

		answerPart1, answerPart2 := RunDay13(input)

		if answerPart1 != "295" {
			t.Errorf("Incorrect result for RunDay13 (part 1), got: %s, want: %s", answerPart1, "295")
		}

		if answerPart2 != "1068781" {
			t.Errorf("Incorrect result for RunDay13 (part 2), got: %s, want: %s", answerPart2, "1068781")
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		input := `939
17,x,13,19`

		_, answerPart2 := RunDay13(input)

		if answerPart2 != "3417" {
			t.Errorf("Incorrect result for RunDay13 (part 2), got: %s, want: %s", answerPart2, "3417")
		}
	})

	t.Run("sample test 3", func(t *testing.T) {
		input := `939
67,7,59,61`

		_, answerPart2 := RunDay13(input)

		if answerPart2 != "754018" {
			t.Errorf("Incorrect result for RunDay13 (part 2), got: %s, want: %s", answerPart2, "754018")
		}
	})

	t.Run("sample test 4", func(t *testing.T) {
		input := `939
67,x,7,59,61`

		_, answerPart2 := RunDay13(input)

		if answerPart2 != "779210" {
			t.Errorf("Incorrect result for RunDay13 (part 2), got: %s, want: %s", answerPart2, "779210")
		}
	})

	t.Run("sample test 5", func(t *testing.T) {
		input := `939
67,7,x,59,61`

		_, answerPart2 := RunDay13(input)

		if answerPart2 != "1261476" {
			t.Errorf("Incorrect result for RunDay13 (part 2), got: %s, want: %s", answerPart2, "1261476")
		}
	})

	t.Run("sample test 6", func(t *testing.T) {
		input := `939
1789,37,47,1889`

		_, answerPart2 := RunDay13(input)

		if answerPart2 != "1202161486" {
			t.Errorf("Incorrect result for RunDay13 (part 2), got: %s, want: %s", answerPart2, "1202161486")
		}
	})
}
