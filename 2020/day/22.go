package day

import (
	"strconv"
	"strings"

	"github.com/reobin/aoc/2020/pkg/str"
)

// RunDay22 runs aoc day 22 challenge
func RunDay22(input string) (string, string) {
	decks := buildPlayerDecks(input)

	winnerPart1, decksPart1 := playCrabCombat(copyDecks(decks), false, []map[int][]int{})
	winnerPart2, decksPart2 := playCrabCombat(copyDecks(decks), true, []map[int][]int{})

	scorePart1 := computeWinningDeckScore(decksPart1[winnerPart1])
	scorePart2 := computeWinningDeckScore(decksPart2[winnerPart2])

	return strconv.Itoa(scorePart1), strconv.Itoa(scorePart2)
}

func computeWinningDeckScore(deck []int) int {
	score := 0
	for index, card := range deck {
		score += (len(deck) - index) * card
	}
	return score
}

func playCrabCombat(decks map[int][]int, recursive bool, roundHistory []map[int][]int) (int, map[int][]int) {
	if len(decks[1]) == 0 {
		return 2, decks
	}

	if len(decks[2]) == 0 {
		return 1, decks
	}

	if hasRoundPlayed(decks, roundHistory) {
		return 1, decks
	}
	roundHistory = append(roundHistory, copyDecks(decks))

	player1Card := decks[1][0]
	player2Card := decks[2][0]

	winner := 1
	if player2Card > player1Card {
		winner = 2
	}

	if recursive && len(decks[1]) > player1Card && len(decks[2]) > player2Card {
		decksCopy := copyDecks(decks)
		decksCopy[1] = decksCopy[1][1 : player1Card+1]
		decksCopy[2] = decksCopy[2][1 : player2Card+1]
		winner, _ = playCrabCombat(decksCopy, recursive, []map[int][]int{})
	}

	decks[1] = decks[1][1:]
	decks[2] = decks[2][1:]

	switch winner {
	case 1:
		decks[1] = append(decks[1], []int{player1Card, player2Card}...)
		break
	case 2:
		decks[2] = append(decks[2], []int{player2Card, player1Card}...)
		break
	}

	return playCrabCombat(decks, recursive, roundHistory)
}

func copyDecks(decks map[int][]int) map[int][]int {
	decksCopy := make(map[int][]int)
	for player, deck := range decks {
		for _, card := range deck {
			decksCopy[player] = append(decksCopy[player], card)
		}
	}
	return decksCopy
}

func hasRoundPlayed(decks map[int][]int, roundHistory []map[int][]int) bool {
	if len(roundHistory) == 0 {
		return false
	}

	for _, pastDecks := range roundHistory {
		isEqual := true
		for player, pastDeck := range pastDecks {
			if !isEqual {
				break
			}

			if len(decks[player]) != len(pastDeck) {
				isEqual = false
				break
			}
			for index, pastCard := range pastDeck {
				if decks[player][index] != pastCard {
					isEqual = false
					break
				}
			}
		}

		if isEqual {
			return true
		}
	}

	return false
}

func buildPlayerDecks(input string) map[int][]int {
	decks := make(map[int][]int)

	for index, playerInfo := range strings.Split(input, "\n\n") {
		for i, line := range strings.Split(str.RemoveEmptyLines(playerInfo), "\n") {
			if i == 0 {
				continue
			}

			card, err := strconv.Atoi(line)
			if err != nil {
				continue
			}

			decks[index+1] = append(decks[index+1], card)
		}
	}

	return decks
}
