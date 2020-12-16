package bootcode

import (
	"reflect"
	"testing"
)

func TestRun(t *testing.T) {
	t.Run("should return accumulator after instructions", func(t *testing.T) {
		instructions := []Instruction{
			{Operation: "nop", Argument: 0},
			{Operation: "acc", Argument: 1},
			{Operation: "jmp", Argument: 4},
			{Operation: "acc", Argument: 3},
			{Operation: "jmp", Argument: -3},
			{Operation: "acc", Argument: -99},
			{Operation: "acc", Argument: 1},
			{Operation: "nop", Argument: 0},
			{Operation: "acc", Argument: 6},
		}

		accumulator, err := Run(instructions)

		if err != nil {
			t.Errorf("Incorrect result for Run, got error: %s", err)
		}

		if accumulator != 8 {
			t.Errorf("Incorrect result for Run, got: %d, want: %d", accumulator, 0)
		}
	})

	t.Run("should return accumulator and error on infinite loop", func(t *testing.T) {
		instructions := []Instruction{
			{Operation: "nop", Argument: 0},
			{Operation: "acc", Argument: 1},
			{Operation: "jmp", Argument: 4},
			{Operation: "acc", Argument: 3},
			{Operation: "jmp", Argument: -3},
			{Operation: "acc", Argument: -99},
			{Operation: "acc", Argument: 1},
			{Operation: "jmp", Argument: -4},
			{Operation: "acc", Argument: 6},
		}

		accumulator, err := Run(instructions)

		if err == nil {
			t.Error("Incorrect result for Run, got no error on infinite loop")
		}

		if accumulator != 5 {
			t.Errorf("Incorrect result for Run, got: %d, want: %d", accumulator, 5)
		}
	})
}

func TestRunInstruction(t *testing.T) {
	t.Run("nop: should return index increase", func(t *testing.T) {
		instruction := Instruction{Operation: "nop", Argument: 0}
		indexIncrease, accumulatorIncrease := instruction.run()

		if indexIncrease != 1 {
			t.Errorf("Incorrect result for run, got indexIncrease: %d, want: %d", indexIncrease, 1)
		}

		if accumulatorIncrease != 0 {
			t.Errorf("Incorrect result for run, got accumulatorIncrease: %d, want: %d", accumulatorIncrease, 0)
		}
	})

	t.Run("acc: should return index and accumulator increase", func(t *testing.T) {
		instruction := Instruction{Operation: "acc", Argument: 5}
		indexIncrease, accumulatorIncrease := instruction.run()

		if indexIncrease != 1 {
			t.Errorf("Incorrect result for run, got indexIncrease: %d, want: %d", indexIncrease, 1)
		}

		if accumulatorIncrease != 5 {
			t.Errorf("Incorrect result for run, got accumulatorIncrease: %d, want: %d", accumulatorIncrease, 5)
		}
	})

	t.Run("jmp: should return index increase", func(t *testing.T) {
		instruction := Instruction{Operation: "jmp", Argument: 5}
		indexIncrease, accumulatorIncrease := instruction.run()

		if indexIncrease != 5 {
			t.Errorf("Incorrect result for run, got indexIncrease: %d, want: %d", indexIncrease, 5)
		}

		if accumulatorIncrease != 0 {
			t.Errorf("Incorrect result for run, got accumulatorIncrease: %d, want: %d", accumulatorIncrease, 0)
		}
	})

	t.Run("other: should return nothing", func(t *testing.T) {
		instruction := Instruction{Operation: "lol", Argument: 5}
		indexIncrease, accumulatorIncrease := instruction.run()

		if indexIncrease != 0 {
			t.Errorf("Incorrect result for run, got indexIncrease: %d, want: %d", indexIncrease, 0)
		}

		if accumulatorIncrease != 0 {
			t.Errorf("Incorrect result for run, got accumulatorIncrease: %d, want: %d", accumulatorIncrease, 0)
		}
	})
}

func TestParseInstructions(t *testing.T) {
	t.Run("should return instructions", func(t *testing.T) {
		input := `nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6`

		instructions := ParseInstructions(input)

		expectedInstructions := []Instruction{
			{Operation: "nop", Argument: 0},
			{Operation: "acc", Argument: 1},
			{Operation: "jmp", Argument: 4},
			{Operation: "acc", Argument: 3},
			{Operation: "jmp", Argument: -3},
			{Operation: "acc", Argument: -99},
			{Operation: "acc", Argument: 1},
			{Operation: "jmp", Argument: -4},
			{Operation: "acc", Argument: 6},
		}

		if !reflect.DeepEqual(instructions, expectedInstructions) {
			t.Errorf("Incorrect result for ParseInstructions, got length: %d, want length with same data: %d", len(instructions), len(expectedInstructions))
		}
	})
}
