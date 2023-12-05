import NumberHelper from '@/helpers/number';

describe('NumberHelper.pad(value, length, character)', () => {
  test('should not pad number if length is achieved', () => {
    expect(NumberHelper.pad(1, 1)).toBe('1');
    expect(NumberHelper.pad(10, 2)).toBe('10');
  });

  test('should pad number with character', () => {
    expect(NumberHelper.pad(1, 2)).toBe('01');
    expect(NumberHelper.pad(1, 3)).toBe('001');
  });
});

describe('NumberHelper.sum(numbers)', () => {
  test('should return 0 if array is empty', () => {
    expect(NumberHelper.sum([])).toBe(0);
  });

  test('should return sum of numbers', () => {
    expect(NumberHelper.sum([1, 2, 3])).toBe(6);
  });
});

describe('NumberHelper.product(numbers)', () => {
  test('should return 0 if array is empty', () => {
    expect(NumberHelper.product([])).toBe(1);
  });

  test('should return multiplication of numbers', () => {
    expect(NumberHelper.product([1, 2, 3])).toBe(6);
  });
});

describe('NumberHelper.isNumber(value)', () => {
  test('should return true if value is a number', () => {
    expect(NumberHelper.isNumber('1')).toBe(true);
  });

  test('should return false if value is not a number', () => {
    expect(NumberHelper.isNumber('a')).toBe(false);
  });
});
