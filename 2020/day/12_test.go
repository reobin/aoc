package day

import (
	"testing"
)

func TestRunDay12(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `F10
N3
F7
R90
F11`

		answerPart1, answerPart2 := RunDay12(input)

		if answerPart1 != "25" {
			t.Errorf("Incorrect result for RunDay12 (part 1), got: %s, want: %s", answerPart1, "25")
		}

		if answerPart2 != "286" {
			t.Errorf("Incorrect result for RunDay12 (part 2), got: %s, want: %s", answerPart2, "286")
		}
	})
}
