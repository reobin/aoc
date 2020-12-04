package day

import (
	"errors"
	"regexp"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/str"
)

type passportValues map[string]string

// RunDay04 runs aoc day 4 challenge
func RunDay04(input string) (string, string) {
	passports := strings.Split(input, "\n\n")

	validPassportCountPart1 := 0
	validPassportCountPart2 := 0

	for _, passport := range passports {
		if isPassportValid(passport, false) {
			validPassportCountPart1++
		}

		if isPassportValid(passport, true) {
			validPassportCountPart2++
		}
	}

	return strconv.Itoa(validPassportCountPart1), strconv.Itoa(validPassportCountPart2)
}

func isPassportValid(passport string, isPart2 bool) bool {
	values, err := getPassportValues(passport)
	if err != nil {
		return false
	}

	// intentionally missing cid
	requiredFields := []string{"ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"}

	for _, field := range requiredFields {
		if _, ok := values[field]; !ok {
			// key is missing from map
			return false
		}

		if isPart2 && !isFieldValueValid(field, values[field]) {
			return false
		}
	}

	return true
}

func getPassportValues(passport string) (passportValues, error) {
	trimmedPassport := strings.ReplaceAll(passport, " ", "\n")

	expression := regexp.MustCompile(`(?m)(\w{3}):(\S+)`)
	matches := expression.FindAllStringSubmatch(trimmedPassport, -1)

	values := make(passportValues)

	if len(matches) < 7 {
		return values, errors.New("Could not get enough matches")
	}

	for _, match := range matches {
		if len(match) < 3 {
			continue
		}
		values[match[1]] = match[2]
	}

	return values, nil
}

func isFieldValueValid(field string, value string) bool {
	switch field {
	case "byr":
		year, err := strconv.Atoi(value)
		if err != nil {
			return false
		}
		return number.IsNumberInRange(year, number.Range{Minimum: 1920, Maximum: 2002})
	case "iyr":
		year, err := strconv.Atoi(value)
		if err != nil {
			return false
		}
		return number.IsNumberInRange(year, number.Range{Minimum: 2010, Maximum: 2020})
	case "eyr":
		year, err := strconv.Atoi(value)
		if err != nil {
			return false
		}
		return number.IsNumberInRange(year, number.Range{Minimum: 2020, Maximum: 2030})
	case "hgt":
		expression := regexp.MustCompile(`^(\d+)(cm|in)$`)
		matches := expression.FindAllStringSubmatch(value, -1)
		if len(matches) < 1 || len(matches[0]) < 2 {
			return false
		}

		height, err := strconv.Atoi(matches[0][1])
		if err != nil {
			return false
		}

		unit := matches[0][2]

		if unit == "cm" {
			return number.IsNumberInRange(height, number.Range{Minimum: 150, Maximum: 193})
		}

		if unit == "in" {
			return number.IsNumberInRange(height, number.Range{Minimum: 59, Maximum: 76})
		}
		// not cm or in
		return false
	case "hcl":
		expression := regexp.MustCompile(`^#[a-f0-9]{6}$`)
		match := expression.MatchString(value)
		return match
	case "ecl":
		possibleValues := []string{"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}
		if !str.Contains(possibleValues, value) {
			return false
		}
		return true
	case "pid":
		expression := regexp.MustCompile(`^\d{9}$`)
		match := expression.MatchString(value)
		return match
	default:
		// If field is out of the required ones, don't validate it
		return true
	}
}
