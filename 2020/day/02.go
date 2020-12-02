package day

import (
	"errors"
	"log"
	"regexp"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/str"
)

type passwordPolicy struct {
	character    string
	firstNumber  int
	secondNumber int
	password     string
}

// RunDay02 runs aoc day 2 challenge
func RunDay02(input string) (string, string) {
	passwordEntries := strings.Split(input, "\n")

	validPasswordCountPart1 := 0
	validPasswordCountPart2 := 0

	for _, passwordEntry := range passwordEntries {
		if passwordEntry == "" {
			continue
		}

		policy, err := getPasswordPolicy(passwordEntry)
		if err != nil {
			log.Printf("Error getting policy: %s", err)
			continue
		}

		if isPasswordValidPart1(policy) {
			validPasswordCountPart1++
		}

		if isPasswordValidPart2(policy) {
			validPasswordCountPart2++
		}
	}

	return strconv.Itoa(validPasswordCountPart1), strconv.Itoa(validPasswordCountPart2)
}

func getPasswordPolicy(entry string) (passwordPolicy, error) {
	expression := regexp.MustCompile("(\\d+)-(\\d+) (\\w): (.*)")
	matches := expression.FindAllStringSubmatch(entry, 4)
	if len(matches) < 1 || len(matches[0]) < 5 {
		return passwordPolicy{}, errors.New("Could not find a valid password policy")
	}

	firstNumber, err := strconv.Atoi(matches[0][1])
	if err != nil {
		return passwordPolicy{}, err
	}
	secondNumber, err := strconv.Atoi(matches[0][2])
	if err != nil {
		return passwordPolicy{}, err
	}

	return passwordPolicy{
		character:    matches[0][3],
		firstNumber:  firstNumber,
		secondNumber: secondNumber,
		password:     matches[0][4],
	}, nil
}

func isPasswordValidPart1(policy passwordPolicy) bool {
	characterCount := str.CountCharactersInString(policy.password, policy.character)
	if characterCount < policy.firstNumber || characterCount > policy.secondNumber {
		return false
	}
	return true
}

func isPasswordValidPart2(policy passwordPolicy) bool {
	if len(policy.password) < policy.secondNumber {
		return false
	}

	firstPositionContains := string(policy.password[policy.firstNumber-1]) == policy.character
	secondPositionContains := string(policy.password[policy.secondNumber-1]) == policy.character

	if firstPositionContains && secondPositionContains || !firstPositionContains && !secondPositionContains {
		return false
	}

	return true
}
