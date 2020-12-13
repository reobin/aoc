package cli

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"
	"strconv"

	"github.com/reobin/aoc/2020/day"
)

const minDayNumber = 1
const maxDayNumber = 25

// DayRunnerMap maps a day number to a function to run
var DayRunnerMap = map[int]interface{}{
	1:  day.RunDay01,
	2:  day.RunDay02,
	3:  day.RunDay03,
	4:  day.RunDay04,
	5:  day.RunDay05,
	6:  day.RunDay06,
	7:  day.RunDay07,
	8:  day.RunDay08,
	9:  day.RunDay09,
	10: day.RunDay10,
	11: day.RunDay11,
	12: day.RunDay12,
	13: day.RunDay13,
}

// GetDayArg gets day number from os arguments
func GetDayArg(osArgs []string) (int, error) {
	if len(osArgs) > 1 {
		value, err := getDayValue(osArgs[1])
		if err != nil {
			return 0, err
		}
		return value, nil
	}

	return 0, errors.New("Please specify a day to run")
}

func getDayValue(dayArg string) (int, error) {
	day, err := strconv.Atoi(dayArg)
	if err != nil {
		return 0, errors.New("Please provide a valid day number")
	}

	if day < minDayNumber || day > maxDayNumber {
		return 0, fmt.Errorf("Please provide a day number between %d and %d", minDayNumber, maxDayNumber)
	}

	return day, nil
}

// GetDayInput returns the input file content for the day
func GetDayInput(day int, fileNamePrefix string) (string, error) {
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
