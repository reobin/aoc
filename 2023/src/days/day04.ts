/* https://adventofcode.com/2023/day/4 */

import NumberHelper from '@/helpers/number';
import StringHelper from '@/helpers/string';

function part1(input: string): number {
  const cards = parseCards(input);
  return computePoints(cards);
}

function part2(input: string): number {
  const cards = parseCards(input);
  return countCards(cards);
}

/**
 * Count cards after all the copies have been added.
 *
 * @param cards The cards.
 * @returns The number of cards.
 */
function countCards(cards: Card[]): number {
  const multiplicators = cards.reduce((acc, c) => ({ ...acc, [c.id]: 1 }), {});

  for (const card of cards) {
    const count = countMatchingNumbers(card);
    const rangeToAdd = Array.from({ length: count }, (_, i) => card.id + 1 + i);

    for (const id of rangeToAdd) {
      multiplicators[id] += 1 * multiplicators[card.id];
    }
  }

  return NumberHelper.sum(Object.values(multiplicators));
}

/**
 * Compute the total points of all the cards.
 *
 * @param cards The cards.
 * @returns The total points.
 */
function computePoints(cards: Card[]): number {
  return NumberHelper.sum(cards.map(computeCardPoints));
}

/**
 * Compute the points of a card.
 *
 * @param card
 * @returns The points.
 */
function computeCardPoints(card: Card): number {
  const matchingNumbersCount = countMatchingNumbers(card);
  return matchingNumbersCount > 0 ? Math.pow(2, matchingNumbersCount - 1) : 0;
}

/**
 * Count the number of winning numbers owned by the player.
 *
 * @param card The card.
 * @returns The number of winning numbers.
 */
function countMatchingNumbers(card: Card): number {
  return NumberHelper.sum(
    card.winningNumbers.map(n => (card.ownedNumbers.includes(n) ? 1 : 0)),
  );
}

interface Card {
  id: number;
  winningNumbers: number[];
  ownedNumbers: number[];
}

/**
 * Parse all the cards from the input.
 *
 * @param input The input with all the cards.
 * @returns The list of cards.
 */
function parseCards(input: string): Card[] {
  return StringHelper.splitLines(input).map(parseCard);
}

/**
 * Parse a card and its data from a line.
 *
 * @param line The line with card info.
 * @returns The card.
 */
function parseCard(line: string): Card {
  const [_full, idMatch, winningNumbersMatch, _partial, ownedNumbersMatch] =
    line.match(/Card\s+(\d+):\s+((\d+\s*)+)\|\s+((\d+\s*)+)/);

  return {
    id: parseInt(idMatch),
    winningNumbers: parseNumbers(winningNumbersMatch),
    ownedNumbers: parseNumbers(ownedNumbersMatch),
  };
}

/**
 * Parse a string of numbers separated by spaces.
 *
 * @param value The string of numbers.
 * @returns The list of numbers.
 */
function parseNumbers(value: string): number[] {
  return value
    .replace(/\s+(?= )/g, '')
    .split(' ')
    .filter(Boolean)
    .map(n => parseInt(n));
}

export default { part1, part2 };
