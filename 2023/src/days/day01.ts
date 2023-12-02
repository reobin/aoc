/* https://adventofcode.com/2023/day/1 */

import NumberHelper from '../helpers/number';

function part1(input: string): number {
  const lines = input.split('\n').filter(Boolean);
  const numbers = lines.map(getCalibrationValues);
  return NumberHelper.sum(numbers);
}

function part2(input: string): number {
  const lines = input.split('\n').filter(Boolean);
  const transformedLines = lines.map(translate);
  const numbers = transformedLines.map(getCalibrationValues);
  return NumberHelper.sum(numbers);
}

/**
 * Get the calibration value: the sum of the first and last digit of the string.
 *
 * @param value The string to get the calibration value from.
 *
 * @returns The calibration value.
 */
function getCalibrationValues(value: string): number {
  const firstDigit = value.match(/^[^\d]{0,}(\d)/)[1];
  const lastDigit = value.match(/(\d)[^\d]{0,}$/)[1];
  return parseInt(`${firstDigit}${lastDigit}`);
}

const NUMBER_TRANSLATIONS = {
  one: '1',
  two: '2',
  three: '3',
  four: '4',
  five: '5',
  six: '6',
  seven: '7',
  eight: '8',
  nine: '9',
};

const NUMBER_MATCH = Object.keys(NUMBER_TRANSLATIONS).join('|');

/**
 * Replace written-out numbers. Once from the start and once from the end.
 *
 * @param value The string to replace numbers in.
 *
 * @returns The string with the first number replaced or the original string if no match was found.
 */
function translate(value: string): string {
  value = replaceNumbers(value, false);
  value = replaceNumbers(value, true);
  return value;
}

/**
 * Replace written-out numbers with their numeric equivalent.
 * Stops at the first match.
 *
 * @param value The string to replace numbers in.
 * @param fromEnd Whether to start from the end of the string.
 *
 * @returns The string with the first number replaced or the original string if no match was found.
 */
function replaceNumbers(value: string, fromEnd: boolean): string {
  let acc = '';

  const chars = fromEnd ? value.split('').reverse() : value;
  for (const char of chars) {
    acc = fromEnd ? char + acc : acc + char;
    const match = acc.match(NUMBER_MATCH);
    if (match) {
      return value.replace(match[0], NUMBER_TRANSLATIONS[match[0]]);
    }
  }

  return value;
}

export default { part1, part2 };
