package main

import (
	"fmt"
	"os"

	"github.com/reobin/aoc/2020/internal/cli"
)

func main() {
	day, err := cli.GetDayArg(os.Args)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	input, err := cli.GetDayInput(day, "")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	runner := cli.DayRunnerMap[day]
	if runner == nil {
		fmt.Println("The specified day might not have been implemented yet")
		os.Exit(1)
	}

	fmt.Printf("Running day %d\n\n", day)
	part1Answer, part2Answer := runner.(func(input string) (string, string))(input)
	fmt.Printf("Part 1 answer is: %s\n", part1Answer)
	fmt.Printf("Part 2 answer is: %s\n", part2Answer)
}
