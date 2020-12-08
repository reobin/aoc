package day

import (
	"errors"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type seatValues struct {
	rowValues    string
	columnValues string
}

// RunDay05 runs aoc day 5 challenge
func RunDay05(input string) (string, string) {
	seats := strings.Split(str.RemoveEmptyLines(input), "\n")
	maxSeatID, seatIDs := findMaxSeatID(seats)
	mySeatID := findMySeatID(seatIDs)
	return strconv.Itoa(maxSeatID), strconv.Itoa(mySeatID)
}

func findMaxSeatID(seats []string) (int, []int) {
	maxSeatID := 0

	var seatIDs []int
	for _, seat := range seats {
		values, err := splitSeatValue(seat)
		if err != nil {
			continue
		}

		row := partitionBinarySpace(values.rowValues, 0, number.Range{Minimum: 0, Maximum: 127})
		column := partitionBinarySpace(values.columnValues, 0, number.Range{Minimum: 0, Maximum: 7})

		seatID := row*8 + column
		if seatID > maxSeatID {
			maxSeatID = seatID
		}

		seatIDs = append(seatIDs, seatID)
	}

	return maxSeatID, seatIDs
}

// Find the seat that +2 exists but +1 not
func findMySeatID(seatIDs []int) int {
	seatIDMap := number.ConvertToMap(seatIDs)
	for _, seatID := range seatIDs {
		if _, ok := seatIDMap[seatID+2]; !ok {
			// +2 does not exist
			continue
		}

		if _, ok := seatIDMap[seatID+1]; ok {
			// +1 exists
			continue
		}

		// found it
		return seatID + 1
	}
	return -1
}

func splitSeatValue(value string) (seatValues, error) {
	matches := regex.Find(value, `^(\w{7})(\w{3})$`)

	if len(matches) < 3 {
		return seatValues{}, errors.New("Could not get partioned seat value")
	}

	return seatValues{rowValues: matches[1], columnValues: matches[2]}, nil
}

func partitionBinarySpace(values string, index int, valueRange number.Range) int {
	if valueRange.Minimum == valueRange.Maximum {
		return valueRange.Minimum
	}

	character := string(values[index])

	if character == "F" || character == "L" {
		// lower half
		newRange := number.Range{Minimum: valueRange.Minimum, Maximum: number.GetMiddle(valueRange, false)}
		return partitionBinarySpace(values, index+1, newRange)
	}

	if character == "B" || character == "R" {
		// higher half
		newRange := number.Range{Minimum: number.GetMiddle(valueRange, true), Maximum: valueRange.Maximum}
		return partitionBinarySpace(values, index+1, newRange)
	}

	return -1
}
