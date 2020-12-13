package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay13 runs aoc day 13 challenge
func RunDay13(input string) (string, string) {
	firstTimestamp, busIDs, err := readSchedule(input)
	if err != nil {
		return "", ""
	}

	firstDeparture, busID := getFirstDeparture(firstTimestamp, busIDs)
	earliestTimestamp := getEarliestSequenceTimestamp(busIDs)

	return strconv.Itoa((firstDeparture - firstTimestamp) * busID), strconv.Itoa(earliestTimestamp)
}

func getFirstDeparture(timestamp int, busIDs []int) (int, int) {
	for ; ; timestamp++ {
		for _, id := range busIDs {
			if id != 0 && timestamp%id == 0 {
				return timestamp, id
			}
		}
	}
}

func getEarliestSequenceTimestamp(busIDs []int) int {
	incrementTimestampBy := busIDs[0]

	currentConstraintIndex := 1

	for timestamp := busIDs[0]; ; timestamp += incrementTimestampBy {
		currentConstraint := busIDs[currentConstraintIndex]

		if currentConstraint == 0 {
			currentConstraintIndex++
			continue
		}

		if (timestamp+currentConstraintIndex)%currentConstraint != 0 {
			continue
		}

		if currentConstraintIndex == len(busIDs)-1 {
			return timestamp
		}

		incrementTimestampBy *= currentConstraint
		currentConstraintIndex++
	}
}

func readSchedule(input string) (int, []int, error) {
	lines := strings.Split(str.RemoveEmptyLines(input), "\n")
	timestamp, err := strconv.Atoi(lines[0])
	if err != nil {
		return -1, []int{}, err
	}

	var busIDs []int
	matches := regex.FindAll(lines[1], `(\d+|x)`)
	for _, match := range matches {
		id, err := strconv.Atoi(match[1])
		if err == nil {
			busIDs = append(busIDs, id)
			continue
		}
		busIDs = append(busIDs, 0)
	}

	return timestamp, busIDs, nil
}
