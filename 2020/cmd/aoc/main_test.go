package main

import (
	"strconv"
	"testing"
)

func TestGetDayArg(t *testing.T) {
	t.Run("should return second argument", func(t *testing.T) {
		osArgs := []string{"function", "01"}
		dayArg, err := getDayArg(osArgs)
		if err != nil {
			t.Errorf("Incorrect result for getDayArg; got error: %s", err)
		}

		if dayArg != "01" {
			t.Errorf("Incorrect result for getDayArg; got: %s, want: %s", dayArg, "01")
		}
	})

	t.Run("should return error if second argument is missing", func(t *testing.T) {
		osArgs := []string{"function"}
		dayArg, err := getDayArg(osArgs)

		if err == nil {
			t.Error("Incorrect result for getDayArg; got no error")
		}

		if dayArg != "" {
			t.Errorf("Incorrect result for getDayArg; got: %s, want: %s", dayArg, "")
		}
	})
}

func TestGetDayValue(t *testing.T) {
	t.Run("should return the number when argument is a valid number string", func(t *testing.T) {
		day, err := getDayValue("1")

		if err != nil {
			t.Errorf("Incorrect result for getDayValue; got error: %s", err)
		}

		if day != 1 {
			t.Errorf("Incorrect result for getDayValue; got: %d, want: %d", day, 1)
		}
	})

	t.Run("should return error if argument is not a valid number", func(t *testing.T) {
		day, err := getDayValue("1a")

		if err == nil {
			t.Error("Incorrect result for getDayValue; got no error")
		}

		if day != -1 {
			t.Errorf("Incorrect result for getDayValue; got: %d, want: %d", day, -1)
		}
	})

	t.Run("should return error if argument number is out of bounds", func(t *testing.T) {
		day, err := getDayValue(strconv.Itoa(maxDayNumber + 1))

		if err == nil {
			t.Error("Incorrect result for getDayValue; got no error")
		}

		if day != -1 {
			t.Errorf("Incorrect result for getDayValue; got: %d, want: %d", day, -1)
		}
	})
}
