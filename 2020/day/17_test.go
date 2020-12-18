package day

import (
	"testing"
)

func TestRunDay17(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `.#.
..#
###`

		answerPart1, _ := RunDay17(input)

		if answerPart1 != "112" {
			t.Errorf("Incorrect result for RunDay17 (part 1), got: %s, want: %s", answerPart1, "112")
		}

		// if answerPart2 != "848" {
		// 	t.Errorf("Incorrect result for RunDay17 (part 2), got: %s, want: %s", answerPart1, "848")
		// }
	})
}
