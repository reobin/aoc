package main

import (
	"log"
	"os"

	"github.com/reobin/aoc/2020/internal/cli"
)

func main() {
	day, err := cli.GetDayArg(os.Args)
	if err != nil {
		log.Print(err)
		os.Exit(1)
	}

	input, err := cli.GetDayInput(day, "")
	if err != nil {
		log.Print(err)
		os.Exit(1)
	}

	runner := cli.DayRunnerMap[day]
	if runner == nil {
		log.Print("The specified day might not have been implemented yet")
		os.Exit(1)
	}

	log.Printf("Running day %d", day)
	part1Answer, part2Answer := runner.(func(input string) (string, string))(input)
	log.Printf("Part 1 answer is: %s", part1Answer)
	log.Printf("Part 2 answer is: %s", part2Answer)
	log.Print(":wq")
}
