package bootcode

import (
	"errors"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
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

// ParseInstructions takes in an input file and returns bootcode instructions
func ParseInstructions(input string) []Instruction {
	lines := strings.ReplaceAll(str.RemoveEmptyLines(input), "\n", "")

	var instructions []Instruction
	matches := regex.FindAll(lines, `(\w{3}) ((\+|-)\d+)`)
	for _, match := range matches {
		argument, err := strconv.Atoi(match[2])
		if err != nil {
			continue
		}
		instruction := Instruction{Operation: match[1], Argument: argument}
		instructions = append(instructions, instruction)
	}

	return instructions
}
