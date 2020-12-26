package day

import (
	"fmt"
	"strconv"
	"strings"
	// "github.com/reobin/aoc/2020/pkg/number"
)

type cup struct {
	value int
	next  *cup
}

type cupList struct {
	head    *cup
	current *cup
}

type cupReference map[int]*cup

var ref cupReference

// RunDay23 runs aoc day 23 challenge
func RunDay23(input string) (string, string) {
	ref = make(cupReference)
	listPart1 := createCupList()
	listPart1.addInitialCups(strings.Split(input, ""), -1)
	listPart1.runMoves(100)
	resultPart1 := strings.Join(listPart1.getLabelsAfter(1, -1), "")

	// ref = make(cupReference)
	// listPart2 := createCupList()
	// listPart2.addInitialCups(strings.Split(input, ""), 1000000)
	// listPart2.runMoves(10000000)
	// labelsPart2 := listPart2.getLabelsAfter(1, 2)
	// fmt.Println(labelsPart2)
	// resultPart2 := strconv.Itoa(number.ComputeProduct(number.ConvertToNumbers(labelsPart2)))

	return resultPart1, "" // resultPart2
}

func (list *cupList) addInitialCups(values []string, finalCupCount int) {
	var current *cup
	for index, value := range values {
		cupValue, err := strconv.Atoi(value)
		if err != nil {
			continue
		}

		newCup := &cup{value: cupValue}

		ref[cupValue] = newCup

		if index == 0 {
			list.head = newCup
			list.head.next = list.head
			current = list.head
			continue
		}

		current.next = newCup
		newCup.next = list.head

		current = newCup
	}

	for i := len(values); i <= finalCupCount; i++ {
		newCup := &cup{value: i}
		ref[i] = newCup
		current.next = newCup
		newCup.next = list.head
		current = newCup
	}

	list.current = list.head
}

func (list *cupList) runMoves(moveCount int) {
	for move := 1; move <= moveCount; move++ {
		nextThree := list.removeNext(3)
		destinationCup := list.getDestination(list.current.value, nextThree)
		list.addCupsAfter(destinationCup, nextThree)
		list.current = list.current.next
	}
}

func (list *cupList) getLabelsAfter(value int, labelCount int) []string {
	var result []string
	cup := ref[value]

	current := cup.next
	for (labelCount != -1 && labelCount > len(result)) || (labelCount == -1 && current != cup) {
		result = append(result, strconv.Itoa(current.value))
		current = current.next
	}

	return result
}

func (list *cupList) getDestination(currentValue int, nextThree []*cup) *cup {
	destination := currentValue - 1

	isFound := false
	for _, cup := range nextThree {
		if cup.value == destination {
			isFound = true
			break
		}
	}

	if destination > 0 && !isFound {
		return ref[destination]
	}

	if destination > 0 {
		return list.getDestination(currentValue-1, nextThree)
	}

	return list.findMaxCup(nextThree)
}

func (list *cupList) findMaxCup(excludeList []*cup) *cup {
	var maxCup *cup

	for value, cup := range ref {
		excluded := false
		for _, exclude := range excludeList {
			if exclude.value == value {
				excluded = true
				break
			}
		}
		if excluded {
			continue
		}

		if maxCup == nil {
			maxCup = cup
			continue
		}

		if value > maxCup.value {
			maxCup = cup
		}
	}

	return maxCup
}

func (list *cupList) removeNext(count int) []*cup {
	var next []*cup

	current := list.current

	for i := 0; i < count; i++ {
		current = current.next
		next = append(next, current)
	}

	list.current.next = current.next

	return next
}

func (list *cupList) print() {
	currentNode := list.head
	if currentNode == nil {
		fmt.Println("list is empty")
		return
	}

	currentNode.print()

	for currentNode.next != list.head {
		currentNode = currentNode.next
		currentNode.print()
	}

	fmt.Print("\n")
}

func (cup *cup) print() {
	fmt.Printf("%d -> %d ", cup.value, cup.next.value)
}

func createCupList() *cupList {
	return &cupList{}
}

func (list *cupList) addCupsAfter(target *cup, cups []*cup) {
	oldNext := target.next

	target.next = cups[0]

	for index, cup := range cups {
		if index == len(cups)-1 {
			cup.next = oldNext
			continue
		}

		cup.next = cups[index+1]
	}
}
