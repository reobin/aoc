/* https://adventofcode.com/2023/day/2 */

import NumberHelper from '@/helpers/number';
import StringHelper from '@/helpers/string';

type Color = 'red' | 'green' | 'blue';
type Set = Record<Color, number>;
type Games = Record<string, Game>;
type Game = Set[];

const BASE_SET: Set = { red: 0, green: 0, blue: 0 };

function part1(input: string): number {
  const games = getGames(input);
  const values = Object.keys(games).map(gameNumber =>
    isPossible(games[gameNumber], { red: 12, green: 13, blue: 14 })
      ? parseInt(gameNumber)
      : 0,
  );
  return NumberHelper.sum(values);
}

function part2(input: string): number {
  const games = getGames(input);
  const minimumSets = Object.keys(games).map(gameNumber =>
    getMinimumSet(games[gameNumber]),
  );
  const powers = minimumSets.map(set =>
    NumberHelper.multiply(Object.values(set)),
  );
  return NumberHelper.sum(powers);
}

/**
 * Get the minimum set of cubes needed to play a game.
 *
 * @param game The game to play.
 *
 * @returns The minimum set of cubes needed to play the game.
 */
function getMinimumSet(game: Game): Set {
  return game.reduce((acc: Set, set: Set): Set => {
    return Object.keys(set).reduce((acc: Set, color: Color): Set => {
      return { ...acc, [color]: Math.max(acc[color], set[color]) };
    }, acc);
  }, BASE_SET);
}

/**
 * Check if a game is possible to play with a given bag of cubes.
 *
 * @param game The game to play.
 * @param bag The bag of cubes.
 *
 * @returns true if the game is possible, false otherwise.
 */
function isPossible(game: Game, bag: Set) {
  return game.every(set =>
    Object.keys(set).every(color => set[color] <= bag[color]),
  );
}

/**
 * Get the games from the input.
 *
 * @example Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue
 *          Game 2: 1 blue, 2 green; 3 green
 *          =
 *          {
 *            '1': [
 *              { red: 4, green: 0, blue: 3 },
 *              { red: 1, green: 2, blue: 6 }
 *            ],
 *            '2': [
 *              { red: 0, green: 2, blue: 1 },
 *              { red: 0, green: 3, blue: 0 }
 *            ]
 *          }
 *
 * @param input The input.
 *
 * @returns The games.
 */
function getGames(input: string): Games {
  return StringHelper.splitLines(input).reduce(
    (acc: Games, line: string): any => {
      const [name, setDefinitions] = line.split(': ');
      const number = name.replace('Game ', '');
      return {
        ...acc,
        [number]: setDefinitions.split('; ').map(getSet),
      };
    },
    {},
  );
}

/**
 * Get a set from a set definition.
 *
 * @example '3 blue, 4 red' = { red: 4, green: 0, blue: 3 }
 *
 * @param setDefinition The set definition.
 *
 * @returns The set.
 */
function getSet(setDefinition: string): Set {
  return setDefinition
    .split(', ')
    .reduce((cubes: any, cubeDefinition: string): Set => {
      const [number, color] = cubeDefinition.split(' ');
      const value = parseInt(number, 10);
      return { ...cubes, [color]: cubes[color] + value };
    }, BASE_SET);
}

export default { part1, part2 };
