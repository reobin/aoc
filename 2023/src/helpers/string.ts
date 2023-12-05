/**
 * Split a string by new line. Will remove empty lines.
 *
 * @param value The string to split.
 *
 * @returns An array of strings.
 */
function splitLines(value: string): string[] {
  return value.split('\n').filter(Boolean);
}

const StringHelper = {
  splitLines,
};

export default StringHelper;
