package day

import (
	"strconv"

	"github.com/reobin/aoc/2020/internal/bootcode"
)

// RunDay08 runs aoc day 8 challenge
func RunDay08(input string) (string, string) {
	instructions := bootcode.ParseInstructions(input)

	lastAccumulatorBeforeInfiniteLoop, _ := bootcode.Run(instructions)

	var lastAccumulator int
	oneOffVariations := getInstructionVariations(instructions)
	for _, variation := range oneOffVariations {
		accumulator, err := bootcode.Run(variation)
		if err == nil {
			lastAccumulator = accumulator
			break
		}
	}

	return strconv.Itoa(lastAccumulatorBeforeInfiniteLoop), strconv.Itoa(lastAccumulator)
}

func getInstructionVariations(instructions []bootcode.Instruction) [][]bootcode.Instruction {
	variations := [][]bootcode.Instruction{instructions}

	for index, instruction := range instructions {
		if instruction.Operation == "jmp" || instruction.Operation == "nop" {
			variation := copyInstructions(instructions)
			newOperation := "jmp"
			if instruction.Operation == "jmp" {
				newOperation = "nop"
			}
			variation[index] = bootcode.Instruction{Operation: newOperation, Argument: instruction.Argument}
			variations = append(variations, variation)
		}
	}

	return variations
}

func copyInstructions(instructions []bootcode.Instruction) []bootcode.Instruction {
	instructionsCopy := make([]bootcode.Instruction, len(instructions))
	copy(instructionsCopy, instructions)
	return instructionsCopy
}
