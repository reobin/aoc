package day

import (
	"testing"
)

func TestRunDay11(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL`

		answerPart1, answerPart2 := RunDay11(input)

		if answerPart1 != "37" {
			t.Errorf("Incorrect result for RunDay11 (part 1), got: %s, want: %s", answerPart1, "37")
		}

		if answerPart2 != "26" {
			t.Errorf("Incorrect result for RunDay11 (part 2), got: %s, want: %s", answerPart2, "26")
		}
	})
}
