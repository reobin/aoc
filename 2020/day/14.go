package day

import (
	"errors"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type writeInstruction struct {
	address value
	value   value
}

type memory map[value]value

type value int

const maskLength = 36

// RunDay14 runs aoc day 14 challenge
func RunDay14(input string) (string, string) {
	lines := strings.Split(str.RemoveEmptyLines(input), "\n")

	memoryPart1 := runMemoryInstructions(lines)
	sumPart1 := memoryPart1.computeSum()

	memoryPart2 := runMemoryInstructionsV2(lines)
	sumPart2 := memoryPart2.computeSum()

	return strconv.Itoa(sumPart1), strconv.Itoa(sumPart2)
}

func runMemoryInstructions(lines []string) memory {
	mem := make(memory)

	mask := ""
	for _, line := range lines {
		maskValue, write, err := readInstruction(line)
		if err != nil {
			continue
		}

		if maskValue != "" {
			mask = maskValue
			continue
		}

		mem[write.address] = write.value.applyMask(mask)
	}

	return mem
}

func runMemoryInstructionsV2(lines []string) memory {
	mem := make(memory)

	mask := ""
	for _, line := range lines {
		maskValue, write, err := readInstruction(line)
		if err != nil {
			continue
		}

		if maskValue != "" {
			mask = maskValue
			continue
		}

		floatingAddress := write.address.applyMaskV2(mask)
		writeInstructions := getFloatingInstructions(floatingAddress, write.value)
		for _, write := range writeInstructions {
			mem[write.address] = write.value
		}
	}

	return mem
}

func getFloatingInstructions(floatingAddress string, v value) []writeInstruction {
	if !strings.Contains(floatingAddress, "X") {
		address, err := strconv.ParseInt(floatingAddress, 2, 64)
		if err != nil {
			return []writeInstruction{}
		}
		return []writeInstruction{{address: value(address), value: v}}
	}

	for index, character := range floatingAddress {
		if character == 'X' {
			var instructions []writeInstruction

			floatingAddress0 := floatingAddress[:index] + "0" + floatingAddress[index+1:]
			instructions = append(instructions, getFloatingInstructions(floatingAddress0, v)...)

			floatingAddress1 := floatingAddress[:index] + "1" + floatingAddress[index+1:]
			instructions = append(instructions, getFloatingInstructions(floatingAddress1, v)...)

			return instructions
		}
	}

	return []writeInstruction{}
}

func (memory memory) computeSum() int {
	sum := 0
	for _, value := range memory {
		sum += int(value)
	}
	return sum
}

func (v value) applyMask(mask string) value {
	binaryValue := number.GetBinary(int(v), maskLength)

	binaryResult := ""
	for index, character := range mask {
		if character == 'X' {
			binaryResult += string(binaryValue[index])
			continue
		}
		binaryResult += string(mask[index])
	}

	decimalResult, err := strconv.ParseInt(binaryResult, 2, 64)
	if err != nil {
		return -1
	}

	return value(int(decimalResult))
}

func (v value) applyMaskV2(mask string) string {
	binaryValue := number.GetBinary(int(v), maskLength)

	binaryResult := ""
	for index, character := range mask {
		if character == '0' {
			binaryResult += string(binaryValue[index])
			continue
		}

		binaryResult += string(character)
	}

	return binaryResult
}

func readInstruction(line string) (string, writeInstruction, error) {
	maskMatch := regex.Find(line, `mask = ((X|[0-1]){36})`)
	if len(maskMatch) >= 2 {
		return maskMatch[1], writeInstruction{}, nil
	}

	assignationMatch := regex.Find(line, `mem\[(\d+)\] = (\d+)`)
	if len(assignationMatch) >= 3 {
		memorySpace, err := strconv.Atoi(assignationMatch[1])
		if err != nil {
			return "", writeInstruction{}, err
		}
		v, err := strconv.Atoi(assignationMatch[2])
		if err != nil {
			return "", writeInstruction{}, err
		}
		return "", writeInstruction{address: value(memorySpace), value: value(v)}, nil
	}

	return "", writeInstruction{}, errors.New("No match found")
}
