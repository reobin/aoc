package day

import (
	"encoding/json"
	"testing"
)

func TestRunDay02(t *testing.T) {
	t.Run("test #1", func(t *testing.T) {
		input := "2x3x4\n1x1x10"
		part1Answer, part2Answer := RunDay02(input)

		if part1Answer != "101" {
			t.Errorf("Incorrect result for RunDay02 (part 1), got: %s, want: %s", part1Answer, "101")
		}

		if part2Answer != "48" {
			t.Errorf("Incorrect result for RunDay02 (part 2), got: %s, want: %s", part1Answer, "48")
		}
	})
}

func dimensionsToString(dimensions Dimensions) string {
	out, err := json.Marshal(dimensions)
	if err != nil {
		return ""
	}

	return string(out)
}

func TestGetDimensions(t *testing.T) {
	t.Run("sample test 2x3x4", func(t *testing.T) {
		spec := "2x3x4"

		dimensions := getDimensions(spec)
		emptyDimensions := Dimensions{}
		if dimensions == emptyDimensions {
			t.Errorf("Incorrect result for getDimensions, got empty dimensions")
		}

		expectedDimensions := Dimensions{length: 2, width: 3, height: 4}
		if dimensions != expectedDimensions {
			t.Errorf("Incorrect result for getDimensions, got: %s, want: %s", dimensionsToString(dimensions), dimensionsToString(expectedDimensions))
		}
	})

	t.Run("sample test 1x1x10", func(t *testing.T) {
		spec := "1x1x10"

		dimensions := getDimensions(spec)
		emptyDimensions := Dimensions{}
		if dimensions == emptyDimensions {
			t.Errorf("Incorrect result for getDimensions, got empty dimensions")
		}

		expectedDimensions := Dimensions{length: 1, width: 1, height: 10}
		if dimensions != expectedDimensions {
			t.Errorf("Incorrect result for getDimensions, got: %s, want: %s", dimensionsToString(dimensions), dimensionsToString(expectedDimensions))
		}
	})
}

func TestComputeSurfaceArea(t *testing.T) {
	t.Run("sample test 2x3x4", func(t *testing.T) {
		dimensions := Dimensions{length: 2, width: 3, height: 4}
		surfaceArea := computeSurfaceArea(dimensions)
		expectedSurfaceArea := 58

		if surfaceArea != expectedSurfaceArea {
			t.Errorf("Incorrect result for computeSurfaceArea, got: %d, want: %d", surfaceArea, expectedSurfaceArea)
		}
	})

	t.Run("sample test 1x1x10", func(t *testing.T) {
		dimensions := Dimensions{length: 1, width: 1, height: 10}
		surfaceArea := computeSurfaceArea(dimensions)
		expectedSurfaceArea := 43

		if surfaceArea != expectedSurfaceArea {
			t.Errorf("Incorrect result for computeSurfaceArea, got: %d, want: %d", surfaceArea, expectedSurfaceArea)
		}
	})
}

func TestComputeRibbonBowLength(t *testing.T) {
	t.Run("sample test 2x3x4", func(t *testing.T) {
		dimensions := Dimensions{length: 2, width: 3, height: 4}
		bowLength := computeRibbonBowLength(dimensions)
		expectedBowLength := 10
		if bowLength != expectedBowLength {
			t.Errorf("Incorrect result for computeRibbonBowLength, got: %d, want: %d", bowLength, expectedBowLength)
		}
	})

	t.Run("sample test 1x1x10", func(t *testing.T) {
		dimensions := Dimensions{length: 1, width: 1, height: 10}
		bowLength := computeRibbonBowLength(dimensions)
		expectedBowLength := 4
		if bowLength != expectedBowLength {
			t.Errorf("Incorrect result for computeRibbonBowLength, got: %d, want: %d", bowLength, expectedBowLength)
		}
	})
}

func TestComputeRibbonWrapLength(t *testing.T) {
	t.Run("sample test 2x3x4", func(t *testing.T) {
		dimensions := Dimensions{length: 2, width: 3, height: 4}
		wrapLength := computeRibbonWrapLength(dimensions)
		expectedWrapLength := 24
		if wrapLength != expectedWrapLength {
			t.Errorf("Incorrect result for computeRibbonWrapLength, got: %d, want: %d", wrapLength, expectedWrapLength)
		}
	})

	t.Run("sample test 1x1x10", func(t *testing.T) {
		dimensions := Dimensions{length: 1, width: 1, height: 10}
		wrapLength := computeRibbonWrapLength(dimensions)
		expectedWrapLength := 10
		if wrapLength != expectedWrapLength {
			t.Errorf("Incorrect result for computeRibbonWrapLength, got: %d, want: %d", wrapLength, expectedWrapLength)
		}
	})
}

func TestComputeRibbonLength(t *testing.T) {
	t.Run("sample test 2x3x4", func(t *testing.T) {
		dimensions := Dimensions{length: 2, width: 3, height: 4}
		ribbonLength := computeRibbonLength(dimensions)
		expectedRibbonLength := 34
		if ribbonLength != expectedRibbonLength {
			t.Errorf("Incorrect result for computeRibbonLength, got: %d, want: %d", ribbonLength, expectedRibbonLength)
		}
	})

	t.Run("sample test 1x1x10", func(t *testing.T) {
		dimensions := Dimensions{length: 1, width: 1, height: 10}
		ribbonLength := computeRibbonLength(dimensions)
		expectedRibbonLength := 14
		if ribbonLength != expectedRibbonLength {
			t.Errorf("Incorrect result for computeRibbonLength, got: %d, want: %d", ribbonLength, expectedRibbonLength)
		}
	})
}
