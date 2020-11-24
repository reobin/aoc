package day

import "testing"

func TestRunDay03(t *testing.T) {
	t.Run("sample test >", func(t *testing.T) {
		input := ">"

		part1Answer, part2Answer := RunDay03(input)

		if part1Answer != "2" {
			t.Errorf("Incorrect result for RunDay03 (part 1), got %s, want: %s", part1Answer, "2")
		}

		if part2Answer != "2" {
			t.Errorf("Incorrect result for RunDay03 (part 2), got %s, want: %s", part2Answer, "2")
		}
	})

	t.Run("sample test ^v", func(t *testing.T) {
		input := "^v"

		part1Answer, part2Answer := RunDay03(input)

		if part1Answer != "2" {
			t.Errorf("Incorrect result for RunDay03 (part 1), got %s, want: %s", part1Answer, "2")
		}

		if part2Answer != "3" {
			t.Errorf("Incorrect result for RunDay03 (part 2), got %s, want: %s", part2Answer, "3")
		}
	})

	t.Run("sample test ^>v<", func(t *testing.T) {
		input := "^>v<"

		part1Answer, part2Answer := RunDay03(input)

		if part1Answer != "4" {
			t.Errorf("Incorrect result for RunDay03 (part 1), got %s, want: %s", part1Answer, "4")
		}

		if part2Answer != "3" {
			t.Errorf("Incorrect result for RunDay03 (part 2), got %s, want: %s", part2Answer, "3")
		}
	})

	t.Run("sample test ^v^v^v^v^v", func(t *testing.T) {
		input := "^v^v^v^v^v"

		part1Answer, part2Answer := RunDay03(input)

		if part1Answer != "2" {
			t.Errorf("Incorrect result for RunDay03 (part 1), got %s, want: %s", part1Answer, "2")
		}

		if part2Answer != "11" {
			t.Errorf("Incorrect result for RunDay03 (part 2), got %s, want: %s", part2Answer, "11")
		}
	})
}

func TestGetNextPosition(t *testing.T) {
	t.Run("up", func(t *testing.T) {
		position := Position{x: 10, y: 10}
		nextPosition := getNextPosition("^", position)
		expectedNextPosition := Position{x: 10, y: 9}

		if nextPosition != expectedNextPosition {
			t.Errorf("Incorrect result for getNextPosition, got: %d, want: %d", nextPosition, expectedNextPosition)
		}
	})

	t.Run("right", func(t *testing.T) {
		position := Position{x: 10, y: 10}
		nextPosition := getNextPosition(">", position)
		expectedNextPosition := Position{x: 11, y: 10}

		if nextPosition != expectedNextPosition {
			t.Errorf("Incorrect result for getNextPosition, got: %d, want: %d", nextPosition, expectedNextPosition)
		}
	})

	t.Run("down", func(t *testing.T) {
		position := Position{x: 10, y: 10}
		nextPosition := getNextPosition("v", position)
		expectedNextPosition := Position{x: 10, y: 11}

		if nextPosition != expectedNextPosition {
			t.Errorf("Incorrect result for getNextPosition, got: %d, want: %d", nextPosition, expectedNextPosition)
		}
	})

	t.Run("left", func(t *testing.T) {
		position := Position{x: 10, y: 10}
		nextPosition := getNextPosition("<", position)
		expectedNextPosition := Position{x: 9, y: 10}

		if nextPosition != expectedNextPosition {
			t.Errorf("Incorrect result for getNextPosition, got: %d, want: %d", nextPosition, expectedNextPosition)
		}
	})
}
