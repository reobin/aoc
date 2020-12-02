package day

import "testing"

func TestRunDay02(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := "1-3 a: abcde\n1-3 b: cdefg\n2-9 c: ccccccccc"
		answerPart1, answerPart2 := RunDay02(input)
		if answerPart1 != "2" {
			t.Errorf("Incorrect result for RunDay02 (part 1), got: %s, want: %s", answerPart1, "2")
		}

		if answerPart2 != "1" {
			t.Errorf("Incorrect result for RunDay02 (part 2), got: %s, want: %s", answerPart2, "1")
		}
	})
}
