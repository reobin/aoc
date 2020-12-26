package day

import (
	"reflect"
	"testing"
)

func TestRunDay24(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew`

		answerPart1, answerPart2 := RunDay24(input)

		if answerPart1 != "10" {
			t.Errorf("Incorrect result for RunDay24 (part 1), got: %s, want: %s", answerPart1, "10")
		}

		if answerPart2 != "2208" {
			t.Errorf("Incorrect result for RunDay24 (part 2), got: %s, want: %s", answerPart2, "2208")
		}
	})
}

func TestGetInstructions(t *testing.T) {
	t.Run("should return list of instructions (sample 1)", func(t *testing.T) {
		line := "esew"
		instructions := getInstructions(line)
		expectedInstructions := []string{"e", "se", "w"}

		if !reflect.DeepEqual(instructions, expectedInstructions) {
			t.Errorf("Incorrect result for getInstructions, got: %s, want: %s", instructions, expectedInstructions)
		}
	})

	t.Run("should return list of instructions (sample 2)", func(t *testing.T) {
		line := "nwwswee"
		instructions := getInstructions(line)
		expectedInstructions := []string{"nw", "w", "sw", "e", "e"}

		if !reflect.DeepEqual(instructions, expectedInstructions) {
			t.Errorf("Incorrect result for getInstructions, got: %s, want: %s", instructions, expectedInstructions)
		}
	})

	t.Run("should return list of instructions (sample 3)", func(t *testing.T) {
		line := "sesenwnenenewseeswwswswwnenewsewsw"
		instructions := getInstructions(line)
		expectedInstructions := []string{"se", "se", "nw", "ne", "ne", "ne", "w", "se", "e", "sw", "w", "sw", "sw", "w", "ne", "ne", "w", "se", "w", "sw"}

		if !reflect.DeepEqual(instructions, expectedInstructions) {
			t.Errorf("Incorrect result for getInstructions, got: %s, want: %s", instructions, expectedInstructions)
		}
	})
}
