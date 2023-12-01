import NumberHelper from '../number';

describe('NumberHelper.pad', () => {
  test('should not pad number if length is achieved', () => {
    expect(NumberHelper.pad(1, 1)).toBe('1');
    expect(NumberHelper.pad(10, 2)).toBe('10');
  });

  test('should pad number with character', () => {
    expect(NumberHelper.pad(1, 2)).toBe('01');
    expect(NumberHelper.pad(1, 3)).toBe('001');
  });
});
