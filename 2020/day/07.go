package day

import (
	"errors"
	"regexp"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type colorPolicies map[string][]colorQuantityPolicy

type colorQuantityPolicy struct {
	color    string
	quantity int
}

// RunDay07 runs aoc day 7 challenge
func RunDay07(input string) (string, string) {
	policyValues := strings.Split(str.RemoveEmptyLines(input), "\n")

	policies := computeColorPolicies(policyValues)

	goldContainingBagCount := countBagsContainingColor("shiny gold", policies)
	goldContainedBagCount := countContainedBags("shiny gold", policies)

	return strconv.Itoa(goldContainingBagCount), strconv.Itoa(goldContainedBagCount)
}

func countBagsContainingColor(color string, policies colorPolicies) int {
	count := 0
	for color := range policies {
		if canColorContainColor(color, "shiny gold", policies) {
			count++
		}
	}
	return count
}

func canColorContainColor(color string, target string, policies colorPolicies) bool {
	for _, colorQuantityPolicy := range policies[color] {
		if colorQuantityPolicy.color == target {
			return true
		}

		if canColorContainColor(colorQuantityPolicy.color, target, policies) {
			return true
		}
	}

	return false
}

func countContainedBags(color string, policies colorPolicies) int {
	quantities := policies[color]

	count := 0

	for _, quantity := range quantities {
		containedBagCount := countContainedBags(quantity.color, policies)
		count += quantity.quantity + quantity.quantity*containedBagCount
	}

	return count
}

func computeColorPolicies(values []string) colorPolicies {
	policies := make(colorPolicies)

	for _, policyValue := range values {
		color, quantityPolicies, err := getColorPolicy(policyValue)
		if err != nil {
			continue
		}
		policies[color] = quantityPolicies
	}

	return policies
}

func getColorPolicy(value string) (string, []colorQuantityPolicy, error) {
	split := regex.FindAll(value, `(\w+ \w+) bags contain ((\d+ \w+ \w+ bags?,? ?)*).*\.`)

	if len(split) < 1 {
		return "", []colorQuantityPolicy{}, errors.New("No main color found")
	}

	mainColor := split[0]

	if len(split) < 2 {
		// contains no other bags
		return mainColor, []colorQuantityPolicy{}, nil
	}

	expression := regexp.MustCompile(`(\d+) (\w+ \w+) bags? ?,?`)
	matches := expression.FindAllStringSubmatch(split[1], -1)

	var quantityPolicies []colorQuantityPolicy

	for _, match := range matches {
		if len(match) < 3 {
			continue
		}
		quantity, err := strconv.Atoi(match[1])
		if err != nil {
			quantity = 0
		}
		quantityPolicies = append(quantityPolicies, colorQuantityPolicy{color: match[2], quantity: quantity})
	}

	return mainColor, quantityPolicies, nil
}
