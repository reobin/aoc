/**
 * Pad a number with leading characters
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

const NumberHelper = {
  pad,
};

export default NumberHelper;
