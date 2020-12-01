package day

import "testing"

func TestRunDay01(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := "1721\n979\n299\n366\n675\n1456"
		answerPart1, answerPart2 := RunDay01(input)

		if answerPart1 != "514579" {
			t.Errorf("Incorrect result for RunDay01 (part 1), got: %s, want: %s", answerPart1, "514579")
		}

		if answerPart2 != "241861950" {
			t.Errorf("Incorrect result for RunDay01 (part 2), got: %s, want: %s", answerPart2, "241861950")
		}
	})
}
