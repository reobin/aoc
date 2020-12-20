package day

import (
	"regexp"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
)

type messageRuleMap map[string]string

var cache map[string]string

// RunDay19 runs aoc day 19 challenge
func RunDay19(input string) (string, string) {
	splits := strings.Split(input, "\n\n")

	messageRules := computeMessageRules(splits[0])

	cache = make(map[string]string)
	expression := "^" + computeRegex("0", messageRules) + "$"

	validMessageCount := 0
	compiled := regexp.MustCompile(expression)
	for _, message := range strings.Split(splits[1], "\n") {
		if compiled.MatchString(message) {
			validMessageCount++
		}
	}

	return strconv.Itoa(validMessageCount), ""
}

func computeRegex(rule string, messageRules messageRuleMap) string {
	if len(cache[rule]) > 0 {
		return cache[rule]
	}

	letterMatch := regex.Find(messageRules[rule], `"(a|b)"`)
	if len(letterMatch) > 1 {
		cache[rule] = letterMatch[1]
		return letterMatch[1]
	}

	if rule == "8" {
		return "((" + computeRegex("42", messageRules) + ")+)"
	}

	if rule == "11" {
		e42 := computeRegex("42", messageRules)
		e31 := computeRegex("31", messageRules)
		expression := "(" + e42
		for i := 1; i <= 100; i++ {
			count := strconv.Itoa(i)
			expression += "(" + e42 + "{" + count + "}" + e31 + "{" + count + "})?"
		}
		return expression + e31 + ")"
	}

	var subExpressions []string
	for _, split := range strings.Split(messageRules[rule], " | ") {
		var subExpression string
		numbers := strings.Split(split, " ")
		for _, n := range numbers {
			subExpression += computeRegex(n, messageRules)
		}
		subExpressions = append(subExpressions, subExpression)
	}
	return "(" + strings.Join(subExpressions, "|") + ")"
}

func computeMessageRules(text string) messageRuleMap {
	rules := make(messageRuleMap)

	lines := strings.Split(text, "\n")

	for _, line := range lines {
		matches := regex.Find(line, `(\d+): (.*)`)
		if len(matches) < 3 {
			continue
		}

		rules[matches[1]] = matches[2]
	}

	return rules
}
