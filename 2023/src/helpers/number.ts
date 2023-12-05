/**
 * Pad a number with leading characters.
 *
 * @example pad(1, 2) // '01'
 * @example pad(1, 2, ' ') // ' 1'
 *
 * @param {number} value The number to pad
 * @param {number} length The length of the resulting string
 * @param {string} character The character to pad with
 *
 * @returns {string} The padded string
 */
function pad(value: number, length: number, character: string = '0'): string {
  return (value + '').padStart(length, character);
}

/**
 * Sum an array of numbers
 *
 * @example sum([1, 2, 3]) // 6
 *
 * @param {number[]} numbers The numbers to sum
 *
 * @returns {number} The sum of the numbers
 */
function sum(numbers: number[]): number {
  return numbers.reduce((a, b) => a + b, 0);
}

/**
 * Multiply an array of numbers
 *
 * @example product([1, 2, 3]) // 6
 *
 * @param {number[]} numbers The numbers to multiply
 *
 * @returns {number} The product of the numbers
 */
function product(numbers: number[]): number {
  return numbers.reduce((a, b) => a * b, 1);
}

function isNumber(value: string): boolean {
  return !isNaN(parseInt(value));
}

const NumberHelper = {
  pad,
  sum,
  product,
  isNumber,
};

export default NumberHelper;
