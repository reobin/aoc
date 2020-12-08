package day

import "testing"

func TestRunDay08(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6`

		answerPart1, answerPart2 := RunDay08(input)

		if answerPart1 != "5" {
			t.Errorf("Incorrect result for RunDay08 (part 1), got: %s, want: %s", answerPart1, "5")
		}

		if answerPart2 != "8" {
			t.Errorf("Incorrect result for RunDay08 (part 1), got: %s, want: %s", answerPart2, "8")
		}
	})
}
