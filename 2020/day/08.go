package day

import (
	"strconv"

	"github.com/reobin/aoc/2020/internal/bootcode"
)

// RunDay08 runs aoc day 8 challenge
func RunDay08(input string) (string, string) {
	instructions := bootcode.ParseInstructions(input)
	lastAccumulatorBeforeInfiniteLoop, _ := bootcode.Run(instructions, 0)
	lastAccumulator, _ := bootcode.Run(instructions, 1)
	return strconv.Itoa(lastAccumulatorBeforeInfiniteLoop), strconv.Itoa(lastAccumulator)
}
