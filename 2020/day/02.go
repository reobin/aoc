package day

import (
	"errors"
	"fmt"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type passwordPolicy struct {
	character    string
	firstNumber  int
	secondNumber int
}

// RunDay02 runs aoc day 2 challenge
func RunDay02(input string) (string, string) {
	passwordEntries := strings.Split(str.RemoveEmptyLines(input), "\n")

	validPasswordCountPart1 := 0
	validPasswordCountPart2 := 0
	for _, passwordEntry := range passwordEntries {
		password, policy, err := interpretPaswordEntry(passwordEntry)
		if err != nil {
			fmt.Printf("Error interprating password entry: %s", err)
			continue
		}

		if isPasswordValidPart1(password, policy) {
			validPasswordCountPart1++
		}

		if isPasswordValidPart2(password, policy) {
			validPasswordCountPart2++
		}
	}

	return strconv.Itoa(validPasswordCountPart1), strconv.Itoa(validPasswordCountPart2)
}

func interpretPaswordEntry(entry string) (string, passwordPolicy, error) {
	matches := regex.Find(entry, `(\d+)-(\d+) (\w): (.*)`)
	if len(matches) < 5 {
		return "", passwordPolicy{}, errors.New("Could not find a valid password policy")
	}

	firstNumber, err := strconv.Atoi(matches[1])
	if err != nil {
		return "", passwordPolicy{}, err
	}

	secondNumber, err := strconv.Atoi(matches[2])
	if err != nil {
		return "", passwordPolicy{}, err
	}

	return matches[4],
		passwordPolicy{
			character:    matches[3],
			firstNumber:  firstNumber,
			secondNumber: secondNumber,
		},
		nil
}

func isPasswordValidPart1(password string, policy passwordPolicy) bool {
	characterCount := str.CountCharacters(password)
	if characterCount[policy.character] < policy.firstNumber || characterCount[policy.character] > policy.secondNumber {
		return false
	}
	return true
}

func isPasswordValidPart2(password string, policy passwordPolicy) bool {
	if len(password) < policy.secondNumber {
		return false
	}

	firstPositionContains := string(password[policy.firstNumber-1]) == policy.character
	secondPositionContains := string(password[policy.secondNumber-1]) == policy.character

	if firstPositionContains && secondPositionContains || !firstPositionContains && !secondPositionContains {
		return false
	}

	return true
}
