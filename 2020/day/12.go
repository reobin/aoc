package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/plan"
	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type instruction struct {
	action string
	value  int
}

type instructionRunner func(instruction instruction, ship plan.Point, waypoint plan.Point) (plan.Point, plan.Point)

// RunDay12 runs aoc day 12 challenge
func RunDay12(input string) (string, string) {
	lines := strings.Split(str.RemoveEmptyLines(input), "\n")
	instructions := readInstructions(lines)

	shipPart1 := runInstructions(instructions, plan.Point{X: 1, Y: 0}, runInstructionPart1)
	shipPart2 := runInstructions(instructions, plan.Point{X: 10, Y: -1}, runInstructionPart2)

	return strconv.Itoa(shipPart1.ComputeManhattanDistance()), strconv.Itoa(shipPart2.ComputeManhattanDistance())
}

func runInstructions(instructions []instruction, waypoint plan.Point, runInstruction instructionRunner) plan.Point {
	ship := plan.Point{}
	for _, instruction := range instructions {
		ship, waypoint = runInstruction(instruction, ship, waypoint)
	}
	return ship
}

func readInstructions(values []string) []instruction {
	var instructions []instruction

	for _, value := range values {
		matches := regex.Find(value, `(\w)(\d+)`)
		if len(matches) < 3 {
			continue
		}

		instructionValue, err := strconv.Atoi(matches[2])
		if err != nil {
			continue
		}

		instructions = append(instructions, instruction{action: matches[1], value: instructionValue})
	}

	return instructions
}

func runInstructionPart1(instruction instruction, ship plan.Point, waypoint plan.Point) (plan.Point, plan.Point) {
	switch instruction.action {
	case "N":
		return ship.Move(plan.Point{Y: -instruction.value}), waypoint
	case "E":
		return ship.Move(plan.Point{X: instruction.value}), waypoint
	case "S":
		return ship.Move(plan.Point{Y: instruction.value}), waypoint
	case "W":
		return ship.Move(plan.Point{X: -instruction.value}), waypoint
	case "L":
		return ship, waypoint.Rotate(-instruction.value)
	case "R":
		return ship, waypoint.Rotate(instruction.value)
	case "F":
		return ship.Move(plan.Point{X: instruction.value * waypoint.X, Y: instruction.value * waypoint.Y}), waypoint
	default:
		return ship, waypoint
	}
}

func runInstructionPart2(instruction instruction, ship plan.Point, waypoint plan.Point) (plan.Point, plan.Point) {
	switch instruction.action {
	case "N":
		return ship, waypoint.Move(plan.Point{Y: -instruction.value})
	case "E":
		return ship, waypoint.Move(plan.Point{X: instruction.value})
	case "S":
		return ship, waypoint.Move(plan.Point{Y: instruction.value})
	case "W":
		return ship, waypoint.Move(plan.Point{X: -instruction.value})
	case "L":
		return ship, waypoint.Rotate(-instruction.value)
	case "R":
		return ship, waypoint.Rotate(instruction.value)
	case "F":
		return ship.Move(plan.Point{X: instruction.value * waypoint.X, Y: instruction.value * waypoint.Y}), waypoint
	default:
		return ship, waypoint
	}
}
