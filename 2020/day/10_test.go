package day

import (
	"testing"
)

func TestRunDay10(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3`

		answerPart1, answerPart2 := RunDay10(input)

		if answerPart1 != "220" {
			t.Errorf("Incorrect result for RunDay10 (part 1), got: %s, want: %s", answerPart1, "220")
		}

		if answerPart2 != "19208" {
			t.Errorf("Incorrect result for RunDay10 (part 2), got: %s, want: %s", answerPart2, "19208")
		}
	})
}

func TestCountJoltageDifferences(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		adapters := []int{
			0,
			1,
			4,
			5,
			6,
			7,
			10,
			11,
			12,
			15,
			16,
			19,
			22,
		}

		count1, count3 := countJoltageDifferences(adapters)
		expectedCount1 := 7
		expectedCount3 := 5

		if count1 != expectedCount1 {
			t.Errorf("Incorrect result for countJoltageDifferences, got: %d, want: %d", count1, expectedCount1)
		}

		if count3 != expectedCount3 {
			t.Errorf("Incorrect result for countJoltageDifferences, got: %d, want: %d", count3, expectedCount3)
		}
	})
}

func TestCountArrangements(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		adapters := []int{
			0,
			1,
			4,
			5,
			6,
			7,
			10,
			11,
			12,
			15,
			16,
			19,
			22,
		}

		count := countArrangements(adapters)
		expectedCount := 8

		if count != expectedCount {
			t.Errorf("Incorrect result for countArrangments, got: %d, want: %d", count, expectedCount)
		}
	})
}
