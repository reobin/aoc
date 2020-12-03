package day

import (
	"testing"

	"github.com/reobin/aoc/2020/pkg/str"
)

func TestRunDay03(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := str.RemoveEmptyLines(`
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#`)

		answerPart1, answerPart2 := RunDay03(input)
		if answerPart1 != "7" {
			t.Errorf("Incorrect result for RunDay03 (part 1), got: %s, want: %s", answerPart1, "7")
		}

		if answerPart2 != "336" {
			t.Errorf("Incorrect result for RunDay03 (part 2), got: %s, want: %s", answerPart2, "336")
		}
	})
}
