package main

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"
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

var (
	_, b, _, _ = runtime.Caller(0)
	basepath   = filepath.Dir(b)
)

// set working directory to project root
func setWdToRoot() {
	os.Chdir("../..")
}

// set working directory back to this test file
func resetWd() {
	os.Chdir(basepath)
}

func cleanUp(target string) {
	if _, err := os.Stat(target); !os.IsNotExist(err) {
		os.Remove(target)
	}
}

func TestGetDayInput(t *testing.T) {
	t.Run("should return input if day (>= 10) file exists", func(t *testing.T) {
		setWdToRoot()

		workingDirectory, err := os.Getwd()
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, error getting wd: %s", err)
		}

		target := fmt.Sprintf("%s/input/.tmp.10.txt", workingDirectory)

		cleanUp(target)

		expectedFileContent := "file content"

		file, err := os.Create(target)
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, error creating file: %s", err)
		}

		if _, err := os.Stat(target); os.IsNotExist(err) {
			t.Error("Incorrect result for getDayInput, did not create file")
		}

		_, err = file.WriteString(expectedFileContent)
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, error writing to file: %s", err)
		}

		input, err := getDayInput(10, ".tmp.")
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, got error: %s", err)
		}

		if input != expectedFileContent {
			t.Errorf("Incorrect result for getDayInput, got: %s, want: %s", input, expectedFileContent)
		}

		cleanUp(target)

		resetWd()
	})

	t.Run("should return input if day (< 10) file exists", func(t *testing.T) {
		setWdToRoot()

		workingDirectory, err := os.Getwd()
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, error getting wd: %s", err)
		}

		target := fmt.Sprintf("%s/input/.tmp.01.txt", workingDirectory)

		cleanUp(target)

		expectedFileContent := "file content"

		file, err := os.Create(target)
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, error creating file: %s", err)
		}

		if _, err := os.Stat(target); os.IsNotExist(err) {
			t.Error("Incorrect result for getDayInput, did not create file")
		}

		_, err = file.WriteString(expectedFileContent)
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, error writing to file: %s", err)
		}

		input, err := getDayInput(1, ".tmp.")
		if err != nil {
			t.Errorf("Incorrect result for getDayInput, got error: %s", err)
		}

		if input != expectedFileContent {
			t.Errorf("Incorrect result for getDayInput, got: %s, want: %s", input, expectedFileContent)
		}

		cleanUp(target)

		resetWd()
	})

	t.Run("should return error if day input does not exist", func(t *testing.T) {
		setWdToRoot()

		_, err := getDayInput(1, ".tmp.")

		if err == nil {
			t.Error("Incorrect result for getDayInput, did not get error")
		}

		resetWd()
	})
}
