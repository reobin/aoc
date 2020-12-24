package day

import (
	"testing"
)

func TestRunDay23(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `389125467`

		answerPart1, answerPart2 := RunDay23(input)

		if answerPart1 != "67384529" {
			t.Errorf("Incorrect result for RunDay23 (part 1), got: %s, want: %s", answerPart1, "67384529")
		}

		if answerPart2 != "" {
			t.Errorf("Incorrect result for RunDay23 (part 2), got: %s, want: %s", answerPart2, "")
		}
	})
}
