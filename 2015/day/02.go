package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2015/internal/number"
)

// Dimensions represents a gift box dimensions
type Dimensions struct {
	length int
	width  int
	height int
}

// RunDay02 runs aoc day 2 challenge
func RunDay02(input string) (string, string) {
	lines := strings.Split(input, "\n")

	totalSurfaceArea := 0
	totalRibbonLength := 0

	for _, spec := range lines {
		if spec == "" {
			continue
		}

		dimensions := getDimensions(string(spec))

		surfaceArea := computeSurfaceArea(dimensions)
		totalSurfaceArea += surfaceArea

		ribbonLength := computeRibbonLength(dimensions)
		totalRibbonLength += ribbonLength
	}

	return strconv.Itoa(totalSurfaceArea), strconv.Itoa(totalRibbonLength)
}

func getDimensions(spec string) Dimensions {
	strDimensions := strings.Split(spec, "x")
	if len(strDimensions) < 3 {
		return Dimensions{}
	}

	length, err := strconv.Atoi(strDimensions[0])
	if err != nil {
		return Dimensions{}
	}

	width, err := strconv.Atoi(strDimensions[1])
	if err != nil {
		return Dimensions{}
	}

	height, err := strconv.Atoi(strDimensions[2])
	if err != nil {
		return Dimensions{}
	}

	return Dimensions{length: length, width: width, height: height}
}

func computeSurfaceArea(dimensions Dimensions) int {
	side1 := dimensions.length * dimensions.width
	side2 := dimensions.width * dimensions.height
	side3 := dimensions.height * dimensions.length

	smallestSide, _ := number.MinMax([]int{side1, side2, side3})

	return 2*side1 + 2*side2 + 2*side3 + smallestSide
}

func computeRibbonLength(dimensions Dimensions) int {
	return computeRibbonBowLength(dimensions) + computeRibbonWrapLength(dimensions)
}

func computeRibbonBowLength(dimensions Dimensions) int {
	smallestSides := number.ExcludeMax([]int{dimensions.length, dimensions.width, dimensions.height})

	bowLength := 0

	for _, side := range smallestSides {
		bowLength += 2 * side
	}

	return bowLength
}

func computeRibbonWrapLength(dimensions Dimensions) int {
	return dimensions.length * dimensions.width * dimensions.height
}
