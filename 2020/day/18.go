package day

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/regex"
	"github.com/reobin/aoc/2020/pkg/str"
)

type expressionComputer func(string) int

// RunDay18 runs aoc day 18 challenge
func RunDay18(input string) (string, string) {
	expressions := strings.Split(str.RemoveEmptyLines(input), "\n")

	sumPart1 := computeExpressionSum(expressions, computeExpression)
	sumPart2 := computeExpressionSum(expressions, computeExpressionWithPrecedence)

	return strconv.Itoa(sumPart1), strconv.Itoa(sumPart2)
}

func computeExpressionSum(expressions []string, computer expressionComputer) int {
	sum := 0
	for _, expression := range expressions {
		expression = strings.ReplaceAll(expression, " ", "")
		sum += evaluateExpression(expression, computer)
	}
	return sum
}

func evaluateExpression(expression string, computer expressionComputer) int {
	reg := regexp.MustCompile(`\(([^(^)]*)\)`)
	for strings.Contains(expression, "(") {
		expression = reg.ReplaceAllString(expression, "evaluate{$1}")
	}

	expression = replaceEvaluations(expression, computer)

	return computer(expression)
}

func replaceEvaluations(expression string, computer expressionComputer) string {
	matches := regex.FindAll(expression, `evaluate{([0-9\+\*]+)}`)
	if len(matches) < 1 {
		return expression
	}

	for _, match := range matches {
		subExpression := match[1]
		result := computer(subExpression)
		toReplace := fmt.Sprintf("evaluate{%s}", subExpression)
		expression = strings.Replace(expression, toReplace, strconv.Itoa(result), 1)
	}

	return replaceEvaluations(expression, computer)
}

func computeExpressionWithPrecedence(expression string) int {
	result := 1
	splits := strings.Split(expression, "*")
	for _, split := range splits {
		result *= computeExpression(split)
	}
	return result
}

func computeExpression(expression string) int {
	var operator string
	var result int

	matches := regex.FindAll(expression, `\d+|\*|\+`)
	if len(matches) < 1 {
		return 0
	}

	for _, match := range matches {
		element := match[0]

		if element == "+" || element == "*" {
			operator = element
			continue
		}

		n, err := strconv.Atoi(element)
		if err != nil {
			break
		}

		if operator == "" {
			result = n
			continue
		}

		result = compute(result, operator, n)
	}
	return result
}

func compute(number1 int, operator string, number2 int) int {
	switch operator {
	case "+":
		return number1 + number2
	case "*":
		return number1 * number2
	default:
		return 0
	}
}
