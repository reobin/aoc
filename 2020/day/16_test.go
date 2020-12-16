package day

import (
	"testing"
)

func TestRunDay16(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12`

		answerPart1, _ := RunDay16(input)

		if answerPart1 != "71" {
			t.Errorf("Incorrect result for RunDay16 (part 1), got: %s, want: %s", answerPart1, "71")
		}
	})
}
