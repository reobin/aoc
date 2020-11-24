package day

import "testing"

func checkAnswer(answer string, expectedAnswer string, t *testing.T, name string) {
	if answer != expectedAnswer {
		t.Errorf("Incorrect result for RunDay01 (%s), got: %s, want: %s", name, answer, expectedAnswer)
	}
}

func TestRunDay01(t *testing.T) {
	t.Run("sample test #1", func(t *testing.T) {
		input := "(())"
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "0", t, "part 1")
		checkAnswer(part2Answer, "-1", t, "part 2")
	})

	t.Run("sample test #2", func(t *testing.T) {
		input := "()()"
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "0", t, "part 1")
		checkAnswer(part2Answer, "-1", t, "part 2")
	})

	t.Run("sample test #3", func(t *testing.T) {
		input := "((("
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "3", t, "part 1")
		checkAnswer(part2Answer, "-1", t, "part 2")
	})

	t.Run("sample test #4", func(t *testing.T) {
		input := "(()(()("
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "3", t, "part 1")
		checkAnswer(part2Answer, "-1", t, "part 2")
	})

	t.Run("sample test #5", func(t *testing.T) {
		input := "))((((("
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "3", t, "part 1")
		checkAnswer(part2Answer, "1", t, "part 2")
	})

	t.Run("sample test #6", func(t *testing.T) {
		input := "())"
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "-1", t, "part 1")
		checkAnswer(part2Answer, "3", t, "part 2")
	})

	t.Run("sample test #7", func(t *testing.T) {
		input := "))("
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "-1", t, "part 1")
		checkAnswer(part2Answer, "1", t, "part 2")
	})

	t.Run("sample test #8", func(t *testing.T) {
		input := ")))"
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "-3", t, "part 1")
		checkAnswer(part2Answer, "1", t, "part 2")
	})

	t.Run("sample test #9", func(t *testing.T) {
		input := ")())())"
		part1Answer, part2Answer := RunDay01(input)
		checkAnswer(part1Answer, "-3", t, "part 1")
		checkAnswer(part2Answer, "1", t, "part 2")
	})
}
