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
func Run(instructions []Instruction, offByAccepted int) (int, error) {
	return run(instructions, 0, 0, offByAccepted)
}

func run(instructions []Instruction, nextInstructionIndex int, accumulator int, offByAccepted int) (int, error) {
	operations := make(map[int][]int)
	index := 0
	for {
		if nextInstructionIndex < 0 || nextInstructionIndex >= len(instructions) {
			return accumulator, errors.New("Went out of bounds")
		}

		nextInstruction := instructions[nextInstructionIndex]
		if len(operations[nextInstructionIndex]) > 0 {
			return accumulator, errors.New("Infinite loop detected")
		}

		potentialAccumulator, err := checkOffRun(nextInstructionIndex, instructions, accumulator, offByAccepted)
		if err == nil {
			return potentialAccumulator, nil
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

// Checks alternative runs by changing some operations
func checkOffRun(nextInstructionIndex int, instructions []Instruction, accumulator int, offByAccepted int) (int, error) {
	if nextInstructionIndex >= len(instructions) {
		return 0, errors.New("out of bounds")
	}

	nextInstruction := instructions[nextInstructionIndex]

	if offByAccepted > 0 && (nextInstruction.Operation == "nop" || nextInstruction.Operation == "jmp") {
		newOperation := "jmp"
		if nextInstruction.Operation == "jmp" {
			newOperation = "nop"
		}

		newInstructions := copyInstructions(instructions)
		newInstructions[nextInstructionIndex] = Instruction{Operation: newOperation, Argument: nextInstruction.Argument}

		potentialAccumulator, err := run(newInstructions, nextInstructionIndex, accumulator, offByAccepted-1)
		if err == nil {
			// Found alternative that terminates the program successfully
			return potentialAccumulator, nil
		}
	}

	return accumulator, errors.New("No success route found")
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

func copyInstructions(instructions []Instruction) []Instruction {
	instructionsCopy := make([]Instruction, len(instructions))
	copy(instructionsCopy, instructions)
	return instructionsCopy
}
