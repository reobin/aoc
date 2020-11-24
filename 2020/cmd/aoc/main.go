package main

import (
	"errors"
	"fmt"
	"log"
	"os"
	"strconv"

	dayRunner "github.com/reobin/aoc/day"
)

const minDayNumber = 1
const maxDayNumber = 25

var dayRunnerMap = map[int]interface{}{
	1: dayRunner.RunDay01,
}

func main() {
	dayArg, err := getDayArg(os.Args)
	if err != nil {
		log.Print(err)
		os.Exit(1)
	}

	day, err := getDayValue(dayArg)
	if err != nil {
		log.Print(err)
		os.Exit(1)
	}

	runner := dayRunnerMap[day]
	if runner == nil {
		log.Print("The specified day might not have been implemented yet")
		os.Exit(1)
	}

	log.Printf("Running day %s", dayArg)
	runner.(func())()
	log.Print(":wq")
}

func getDayValue(dayArg string) (int, error) {
	day, err := strconv.Atoi(dayArg)
	if err != nil {
		return -1, errors.New("Please provide a valid day number")
	}

	if day < minDayNumber || day > maxDayNumber {
		return -1, fmt.Errorf("Please provide a day number between %d and %d", minDayNumber, maxDayNumber)
	}

	return day, nil
}

func getDayArg(osArgs []string) (string, error) {
	if len(osArgs) > 1 {
		return osArgs[1], nil
	}

	return "", errors.New("Please specify a day to run")
}
