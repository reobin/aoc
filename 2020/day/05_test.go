package day

import (
	"testing"

	"github.com/reobin/aoc/2020/pkg/number"
)

func TestRunDay05(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL`

		answerPart1, answerPart2 := RunDay05(input)

		if answerPart1 != "820" {
			t.Errorf("Incorrect result for RunDay05 (part 1), got: %s, want: %s", answerPart1, "820")
		}

		if answerPart2 != "-1" {
			t.Errorf("Incorrect result for RunDay05 (part 2), got: %s, want: %s", answerPart2, "-1")
		}
	})
}

func TestPartitionBinarySpace(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		rowValue := "FBFBBFF"

		row := partitionBinarySpace(rowValue, 0, number.Range{Minimum: 0, Maximum: 127})

		if row != 44 {
			t.Errorf("Incorrect result for partitionBinarySpace, got: %d, want: %d", row, 44)
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		columnValue := "RLR"

		column := partitionBinarySpace(columnValue, 0, number.Range{Minimum: 0, Maximum: 7})

		if column != 5 {
			t.Errorf("Incorrect result for partitionBinarySpace, got: %d, want: %d", column, 5)
		}
	})
}
