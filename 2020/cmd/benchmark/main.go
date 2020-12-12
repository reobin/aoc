package main

import (
	"fmt"
	"os"
	"time"

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

	var times []time.Duration
	for i := 0; i < 1000; i++ {
		startTime := time.Now()
		runner.(func(input string) (string, string))(input)
		times = append(times, time.Since(startTime))
	}

	var totalTime time.Duration
	for _, elapsedTime := range times {
		totalTime += elapsedTime
	}

	fmt.Printf("Running day %d 1000 times\n\n", day)
	fmt.Printf("Average elapsed time (1000 runs): %s\n", totalTime/1000)
}
