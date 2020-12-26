package day

import (
	"testing"
)

func TestRunDay22(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10`

		answerPart1, answerPart2 := RunDay22(input)

		if answerPart1 != "306" {
			t.Errorf("Incorrect result for RunDay22 (part 1), got: %s, want: %s", answerPart1, "306")
		}

		if answerPart2 != "291" {
			t.Errorf("Incorrect result for RunDay22 (part 2), got: %s, want: %s", answerPart2, "291")
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		input := `Player 1:
43
19

Player 2:
2
29
14`

		RunDay22(input)
	})
}
