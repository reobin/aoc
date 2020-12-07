package day

import "testing"

func TestRunDay07(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.`

		answerPart1, _ := RunDay07(input)

		if answerPart1 != "4" {
			t.Errorf("Incorrect result for RunDay07 (part 1), got: %s, want: %s", answerPart1, "4")
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		input := `shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.`

		_, answerPart2 := RunDay07(input)

		if answerPart2 != "126" {
			t.Errorf("Incorrect result for RunDay07 (part 2), got: %s, want: %s", answerPart2, "126")
		}
	})
}
