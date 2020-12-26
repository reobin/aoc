package day

import "testing"

func TestRunDay25(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `5764801
17807724`

		answerPart1, answerPart2 := RunDay25(input)

		if answerPart1 != "14897079" {
			t.Errorf("Incorrect result for RunDay25 (part 1), got: %s, want: %s", answerPart1, "14897079")
		}

		if answerPart2 != "" {
			t.Errorf("Incorrect result for RunDay25 (part 2), got: %s, want: %s", answerPart2, "")
		}
	})
}

func TestComputeLoopSize(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		loopSize := computeLoopSize("5764801", 7)
		if loopSize != 8 {
			t.Errorf("Incorrect result for computeLoopSize, got: %d, want: %d", loopSize, 8)
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		loopSize := computeLoopSize("17807724", 7)
		if loopSize != 11 {
			t.Errorf("Incorrect result for computeLoopSize, got: %d, want: %d", loopSize, 11)
		}
	})
}

func TestComputeKey(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		key := computeKey(7, 8)
		expectedKey := "5764801"
		if key != expectedKey {
			t.Errorf("Incorrect result for computeKey, got: %s, want: %s", key, expectedKey)
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		key := computeKey(7, 11)
		expectedKey := "17807724"
		if key != expectedKey {
			t.Errorf("Incorrect result for computeKey, got: %s, want: %s", key, expectedKey)
		}
	})
}
