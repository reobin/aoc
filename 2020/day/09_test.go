package day

import (
	"reflect"
	"testing"
)

func TestRunDay09(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		input := `1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26`

		answerPart1, _ := RunDay09(input)

		if answerPart1 != "-1" {
			t.Errorf("Incorrect result for RunDay09 (part 1), got: %s, want: %s", answerPart1, "-1")
		}
	})

	t.Run("sample test 2", func(t *testing.T) {
		input := `1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
49`

		answerPart1, _ := RunDay09(input)

		if answerPart1 != "-1" {
			t.Errorf("Incorrect result for RunDay09 (part 1), got: %s, want: %s", answerPart1, "-1")
		}
	})

	t.Run("sample test 3", func(t *testing.T) {
		input := `1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
100`

		answerPart1, _ := RunDay09(input)

		if answerPart1 != "100" {
			t.Errorf("Incorrect result for RunDay09 (part 1), got: %s, want: %s", answerPart1, "100")
		}
	})

	t.Run("sample test 4", func(t *testing.T) {
		input := `1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
50`

		answerPart1, _ := RunDay09(input)

		if answerPart1 != "50" {
			t.Errorf("Incorrect result for RunDay09 (part 1), got: %s, want: %s", answerPart1, "50")
		}
	})
}

func TestValidateXMasData(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		xMasData := []int{
			35,
			20,
			15,
			25,
			47,
			40,
			62,
			55,
			65,
			95,
			102,
			117,
			150,
			182,
			127,
			219,
			299,
			277,
			309,
			576,
		}

		invalidEntry := validateXmasData(xMasData, 5)

		if invalidEntry != 127 {
			t.Errorf("Incorrect result for validateXmasData, got: %d, want: %d", invalidEntry, 127)
		}
	})
}

func TestFindContiguousSummands(t *testing.T) {
	t.Run("sample test 1", func(t *testing.T) {
		xMasData := []int{
			35,
			20,
			15,
			25,
			47,
			40,
			62,
			55,
			65,
			95,
			102,
			117,
			150,
			182,
			127,
			219,
			299,
			277,
			309,
			576,
		}

		summands := findContiguousSummands(xMasData, 127)
		expectedSummands := []int{15, 25, 47, 40}

		if !reflect.DeepEqual(summands, expectedSummands) {
			t.Errorf("Incorrect result for findContiguousSummands, got: %d, want: %d", summands, expectedSummands)
		}
	})
}
