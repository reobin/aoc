import NumberHelper from '@/helpers/number';

/**
 * Get the day number from the command line arguments.
 *
 * @returns {string | null} The day number, or null if not provided or invalid
 */
function getDay(): string | null {
  const dayInput = process.argv[2];
  if (typeof dayInput === 'undefined') {
    console.error('Please provide a day number');
    return null;
  }
  if (Number.isNaN(Number(dayInput))) {
    console.error('Please provide a valid day number');
    return null;
  }

  const day = Number(dayInput);
  if (day < 1 || day > 25) {
    console.error('Please provide a day between 1 and 25');
    return null;
  }

  return NumberHelper.pad(day, 2);
}

const SystemHelper = {
  getDay,
};

export default SystemHelper;
