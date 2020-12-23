package day

import (
	"testing"
)

func TestRunDay21(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)`

		answerPart1, answerPart2 := RunDay21(input)

		if answerPart1 != "5" {
			t.Errorf("Incorrect result for RunDay21 (part 1), got: %s, want: %s", answerPart1, "5")
		}

		if answerPart2 != "mxmxvkd,sqjhc,fvjkl" {
			t.Errorf("Incorrect result for RunDay21 (part 2), got: %s, want: %s", answerPart2, "mxmxvkd,sqjhc,fvjkl")
		}
	})
}
