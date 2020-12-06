package day

import (
	"errors"
	"log"
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
			log.Printf("Error interprating password entry: %s", err)
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
	matches := regex.FindAll(entry, `(\d+)-(\d+) (\w): (.*)`)
	if len(matches) < 4 {
		return "", passwordPolicy{}, errors.New("Could not find a valid password policy")
	}

	firstNumber, err := strconv.Atoi(matches[0])
	if err != nil {
		return "", passwordPolicy{}, err
	}

	secondNumber, err := strconv.Atoi(matches[1])
	if err != nil {
		return "", passwordPolicy{}, err
	}

	return matches[3],
		passwordPolicy{
			character:    matches[2],
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
