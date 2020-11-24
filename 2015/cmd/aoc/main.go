package main

import (
	"errors"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"

	dayRunner "github.com/reobin/aoc/2015/day"
)

const minDayNumber = 1
const maxDayNumber = 25

var dayRunnerMap = map[int]interface{}{
	1: dayRunner.RunDay01,
	2: dayRunner.RunDay02,
	3: dayRunner.RunDay03,
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

	input, err := getDayInput(day, "")
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
	part1Answer, part2Answer := runner.(func(input string) (string, string))(input)
	log.Printf("Part 1 answer is: %s", part1Answer)
	log.Printf("Part 2 answer is: %s", part2Answer)
	log.Print(":wq")
}

func getDayInput(day int, fileNamePrefix string) (string, error) {
	workingDirectory, err := os.Getwd()
	if err != nil {
		return "", err
	}

	dayKey := strconv.Itoa(day)
	if day < 10 {
		dayKey = fmt.Sprintf("0%s", dayKey)
	}

	inputPath := fmt.Sprintf("%s/input/%s%s.txt", workingDirectory, fileNamePrefix, dayKey)

	input, err := ioutil.ReadFile(inputPath)
	if err != nil {
		return "", err
	}

	return string(input), nil
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
