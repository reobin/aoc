package day

import "testing"

func TestRunDay06(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `abc

a
b
c

ab
ac

a
a
a
a

b`

		answerPart1, answerPart2 := RunDay06(input)

		if answerPart1 != "11" {
			t.Errorf("Incorrect result for RunDay06 (part 1), got: %s, want: %s", answerPart1, "11")
		}

		if answerPart2 != "6" {
			t.Errorf("Incorrect result for RunDay06 (part 2), got: %s, want: %s", answerPart2, "6")
		}
	})
}
