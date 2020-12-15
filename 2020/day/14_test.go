package day

import (
	"testing"
)

func TestRunDay14(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `mask = 000000000000000000000000000000X1001X
	mem[42] = 100
	mask = 00000000000000000000000000000000X0XX
	mem[26] = 1`

		answerPart1, answerPart2 := RunDay14(input)

		if answerPart1 != "51" {
			t.Errorf("Incorrect result for RunDay14 (part 1), got: %s, want: %s", answerPart1, "51")
		}

		if answerPart2 != "208" {
			t.Errorf("Incorrect result for RunDay14 (part 2), got: %s, want: %s", answerPart2, "208")
		}
	})
}
