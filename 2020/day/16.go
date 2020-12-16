package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/number"
	"github.com/reobin/aoc/2020/pkg/regex"
)

type ticketRule struct {
	fieldName string
	rangeA    number.Range
	rangeB    number.Range
}

type ticket []int

// RunDay16 runs aoc day 16 challenge
func RunDay16(input string) (string, string) {
	chunks := strings.Split(input, "\n\n")

	ticketRules := getTicketRules(chunks[0])
	myTicket := getTickets(chunks[1])[1]
	nearbyTickets := getTickets(chunks[2])
	remaindingTickets, invalidNearbyTicketNumbers := validateTickets(nearbyTickets, ticketRules)

	fields := getFields(remaindingTickets, ticketRules)

	var departureFieldValues []int
	for field, index := range fields {
		if strings.HasPrefix(field, "departure") {
			departureFieldValues = append(departureFieldValues, myTicket[index])
		}
	}

	return strconv.Itoa(number.ComputeSum(invalidNearbyTicketNumbers)), strconv.Itoa(number.ComputeProduct(departureFieldValues))
}

func getFields(tickets []ticket, ticketRules []ticketRule) map[string]int {
	fields := make(map[string][]int)

	for i := 0; i < len(ticketRules); i++ {
		ticketNumbersAtIndex := getTicketNumbersAtIndex(tickets, i)

		var potentialRules []ticketRule
		for _, rule := range ticketRules {
			if isRuleValidForTicketNumbers(rule, ticketNumbersAtIndex) {
				potentialRules = append(potentialRules, rule)
			}
		}

		for _, rule := range potentialRules {
			fields[rule.fieldName] = append(fields[rule.fieldName], i)
		}
	}

	return distributeFieldsIndexByElimination(fields, len(ticketRules))
}

func distributeFieldsIndexByElimination(fields map[string][]int, ticketRuleCount int) map[string]int {
	realFields := make(map[string]int)
	for len(realFields) < ticketRuleCount {
		for field, indexes := range fields {
			if len(indexes) == 1 {
				realFields[field] = indexes[0]
				fields = removeIndexFromFields(fields, indexes[0])
				break
			}
		}
	}
	return realFields
}

func getTicketNumbersAtIndex(tickets []ticket, index int) []int {
	var ticketNumbersAtIndex []int
	for _, ticket := range tickets {
		ticketNumbersAtIndex = append(ticketNumbersAtIndex, ticket[index])
	}
	return ticketNumbersAtIndex
}

func removeIndexFromFields(fields map[string][]int, index int) map[string][]int {
	result := make(map[string][]int)
	for field, indexes := range fields {
		for _, i := range indexes {
			if i != index {
				result[field] = append(result[field], i)
			}
		}
	}
	return result
}

func validateTickets(tickets []ticket, ticketRules []ticketRule) ([]ticket, []int) {
	var invalidNumbers []int
	var remaindingTickets []ticket

	for _, ticket := range tickets {
		if len(ticket) == 0 {
			continue
		}

		invalidNumber := -1

		for _, n := range ticket {
			if !isTicketNumberValidForAnyRule(n, ticketRules) {
				invalidNumber = n
				break
			}
		}

		if invalidNumber != -1 {
			invalidNumbers = append(invalidNumbers, invalidNumber)
			continue
		}

		remaindingTickets = append(remaindingTickets, ticket)
	}

	return remaindingTickets, invalidNumbers
}

func getTickets(text string) []ticket {
	lines := strings.Split(text, "\n")
	var tickets []ticket
	for _, line := range lines {
		matches := strings.Split(line, ",")
		numbers := number.ConvertToNumbers(matches)
		tickets = append(tickets, numbers)
	}
	return tickets
}

func getTicketRules(text string) []ticketRule {
	ruleDescriptions := strings.Split(text, "\n")

	var ticketRules []ticketRule

	for _, description := range ruleDescriptions {
		match := strings.Split(description, ": ")
		if len(match) < 2 {
			continue
		}

		fieldName := match[0]

		rangeMatch := regex.FindAll(match[1], `(\d+)-(\d+)`)

		if len(rangeMatch) < 2 {
			continue
		}

		rangeAMatch := rangeMatch[0]
		rangeBMatch := rangeMatch[1]
		if len(rangeAMatch) < 3 || len(rangeBMatch) < 3 {
			continue
		}

		rangeAMin, err := strconv.Atoi(rangeAMatch[1])
		rangeAMax, err := strconv.Atoi(rangeAMatch[2])
		rangeBMin, err := strconv.Atoi(rangeBMatch[1])
		rangeBMax, err := strconv.Atoi(rangeBMatch[2])
		if err != nil {
			continue
		}

		rangeA := number.Range{Minimum: rangeAMin, Maximum: rangeAMax}
		rangeB := number.Range{Minimum: rangeBMin, Maximum: rangeBMax}
		rule := ticketRule{fieldName: fieldName, rangeA: rangeA, rangeB: rangeB}
		ticketRules = append(ticketRules, rule)
	}

	return ticketRules
}

func isRuleValidForTicketNumbers(rule ticketRule, ticketNumbers []int) bool {
	for _, ticketNumber := range ticketNumbers {
		if !isTicketNumberValidForRule(ticketNumber, rule) {
			return false
		}
	}
	return true
}

func isTicketNumberValidForAnyRule(ticketNumber int, rules []ticketRule) bool {
	for _, rule := range rules {
		if isTicketNumberValidForRule(ticketNumber, rule) {
			return true
		}
	}
	return false
}

func isTicketNumberValidForRule(ticketNumber int, rule ticketRule) bool {
	return number.IsNumberInRange(ticketNumber, rule.rangeA) || number.IsNumberInRange(ticketNumber, rule.rangeB)
}
