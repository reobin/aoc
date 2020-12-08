package bootcode

import (
	"errors"
)

// Instruction represents a bootcode computer instruction
type Instruction struct {
	Operation string
	Argument  int
}

// Run runs instructions on a bootcode computer until an error happens or until
// the program terminates
func Run(instructions []Instruction) (int, error) {
	accumulator := 0
	operations := make(map[int][]int)

	nextInstructionIndex := 0
	index := 0

	for {
		nextInstruction := instructions[nextInstructionIndex]
		if len(operations[nextInstructionIndex]) > 0 {
			return accumulator, errors.New("Infinite loop detected")
		}

		operations[nextInstructionIndex] = append(operations[nextInstructionIndex], index)

		indexIncrease, accumulatorIncrease := runInstruction(nextInstruction)

		nextInstructionIndex += indexIncrease
		accumulator += accumulatorIncrease

		if nextInstructionIndex >= len(instructions) {
			// Program terminated
			break
		}

		index++
	}

	return accumulator, nil
}

func runInstruction(instruction Instruction) (int, int) {
	switch instruction.Operation {
	case "nop":
		// do nothing
		return 1, 0
	case "acc":
		return 1, instruction.Argument
	case "jmp":
		return instruction.Argument, 0
	}
	return 0, 0
}
