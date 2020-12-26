package day

import (
	"errors"
	"sort"
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/str"
)

type ingredientCount map[string]int
type allergenMap map[string]ingredientCount

// RunDay21 runs aoc day 21 challenge
func RunDay21(input string) (string, string) {
	allergens, ingredients := getAllergenMap(str.RemoveEmptyLines(input))

	allergenAssociations := findAllergenAssociations(allergens)

	var associatedIngredients []string
	for _, associatedIngredient := range allergenAssociations {
		associatedIngredients = append(associatedIngredients, associatedIngredient)
	}

	var allergenFreeIngredients []string
	for _, ingredient := range ingredients {
		if !str.Contains(associatedIngredients, ingredient) {
			allergenFreeIngredients = append(allergenFreeIngredients, ingredient)
		}
	}

	var sortedAllergens []string
	for allergen := range allergenAssociations {
		sortedAllergens = append(sortedAllergens, allergen)
	}
	sort.Strings(sortedAllergens)

	var sortedIngredients []string
	for _, allergen := range sortedAllergens {
		sortedIngredients = append(sortedIngredients, allergenAssociations[allergen])
	}

	return strconv.Itoa(len(allergenFreeIngredients)), strings.Join(sortedIngredients, ",")
}

func findAllergenAssociations(allergens allergenMap) map[string]string {
	asociations := make(map[string]string)

	allergenCount := len(allergens)

	for len(asociations) < allergenCount {
		for allergen, count := range allergens {
			maxIngredient, err := findMaxIngredient(count)
			if err == nil {
				asociations[allergen] = maxIngredient
				allergens = removeAllergenAndIngredient(allergen, maxIngredient, allergens)
				break
			}
		}
	}

	return asociations
}

func removeAllergenAndIngredient(allergenToRemove string, ingredientToRemove string, allergens allergenMap) allergenMap {
	result := make(allergenMap)
	for allergen, ingredients := range allergens {
		if allergen == allergenToRemove {
			continue
		}
		if result[allergen] == nil {
			result[allergen] = make(map[string]int)
		}
		for ingredient, count := range ingredients {
			if ingredient == ingredientToRemove {
				continue
			}
			result[allergen][ingredient] = count
		}
	}
	return result
}

func findMaxIngredient(ingredients ingredientCount) (string, error) {
	var maxCount int
	var ingredientWithMaxCount string

	for ingredient, count := range ingredients {
		if count > maxCount {
			maxCount = count
			ingredientWithMaxCount = ingredient
		}
	}

	var maxCountCount int
	for _, count := range ingredients {
		if count == maxCount {
			maxCountCount++
		}
	}

	if maxCountCount > 1 {
		return "", errors.New("duplicate max count")
	}

	return ingredientWithMaxCount, nil
}

func getAllergenMap(input string) (allergenMap, []string) {
	allergens := make(allergenMap)

	var totalIngredients []string

	for _, line := range strings.Split(input, "\n") {
		ingredients, allergenElements := parseFood(line)

		totalIngredients = append(totalIngredients, ingredients...)

		for _, allergen := range allergenElements {
			if allergens[allergen] == nil {
				allergens[allergen] = make(ingredientCount)
			}

			for _, ingredient := range ingredients {
				allergens[allergen][ingredient]++
			}
		}
	}

	return allergens, totalIngredients
}

func parseFood(food string) ([]string, []string) {
	splits := strings.Split(food, " (contains ")
	ingredients := strings.Split(splits[0], " ")
	cleanedAllergenValue := strings.Replace(splits[1], ")", "", 1)
	allergenElements := strings.Split(cleanedAllergenValue, ", ")
	return ingredients, allergenElements
}
