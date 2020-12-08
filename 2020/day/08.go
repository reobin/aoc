package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/internal/bootcode"

	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay08 runs aoc day 8 challenge
func RunDay08(input string) (string, string) {
	lines := strings.Split(str.RemoveEmptyLines(input), "\n")
	instructions := parseInstructions(lines)

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

func parseInstructions(lines []string) []bootcode.Instruction {
	var instructions []bootcode.Instruction
	for _, line := range lines {
		match := regex.Find(line, `(\w{3}) ((\+|-)\d+)`)
		argument, err := strconv.Atoi(match[2])
		if err != nil {
			continue
		}
		instruction := bootcode.Instruction{Operation: match[1], Argument: argument}
		instructions = append(instructions, instruction)
	}
	return instructions
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
